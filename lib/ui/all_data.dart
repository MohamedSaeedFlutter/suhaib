import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:open_file/open_file.dart';
import 'package:suhaib/Apis/upload_file_logic.dart';
import 'package:suhaib/core/share_widget.dart';
import 'package:suhaib/states/chat_state.dart';


class AllData extends StatefulWidget {
  @override
  _AllDataState createState() => _AllDataState();
}

class _AllDataState extends State<AllData> {
  @override
  void initState() {
    super.initState();
  }
File filePath;
  var auth = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    print("uid" + FirebaseAuth.instance.currentUser.uid);
      return BlocConsumer<UploadFileLogic, ChangeChatState>(
      listener: (context, state) { print(state); },
      builder: (context, state) { print(state); print(" bloc Consumer works");
      return Expanded(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: UploadFileLogic.get(context).getFiles(uid: auth.uid),
            builder: (context, snapshot) {
              print("data ....${snapshot.data.docs.length}");
              // if (snapshot.connectionState != ConnectionState.done) {
              //   return CircularProgressIndicator(strokeWidth: 0.0001,); }
              // if (!snapshot.hasData) { print("snapshot data ${snapshot.data}");
              //   return Container(
              //     child: const Text(
              //       "chat has not data", style: TextStyle(fontSize: 35
              //         ,color: Colors.white, fontWeight: FontWeight.w500),
              //     ),
              //   );
              // }
              return
              snapshot.data != null  ?
               Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: auth != null ?ListView(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        scrollDirection: Axis.vertical,
                          children: snapshot.data.docs.map(
                                (DocumentSnapshot document) {
                            Map<String, dynamic> data = document.data()
                            as Map<String, dynamic>;  print("data : $data");
                          return GestureDetector(
                            onTap: () {},
                                // Navigator.push(context,MaterialPageRoute(
                                // builder: (context) => ChatScreen(
                                //   userId:data["id"],
                                //         ),
                                //   ),
                                // ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child:
                                    Row( mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: InkWell(
                                            onTap: () async {
                                              await DefaultCacheManager()
                                                  .getSingleFile(data["fileUrl"]??"")
                                              .then((value) {
                                                setState(() {
                                                  filePath = value;
                                                });
                                                OpenFile.open(value.path );
                                                Fluttertoast.showToast(msg: "View Mode");
                                              });
                                              },
                                            child: Icon(Icons.remove_red_eye,
                                              color: Colors.deepOrange,),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: InkWell(onTap:() async {
                                            await DefaultCacheManager()
                                                .getSingleFile(data["fileUrl"]??"")
                                                .then((value) => Fluttertoast
                                                .showToast(msg: "downloaded"));
                                          },
                                            child: Icon(Icons.arrow_downward,
                                              color: Colors.deepOrange,),
                                          ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(left: 8.0),
                                            child: InkWell(child: Icon(Icons.share,
                                              color: Colors.deepOrange,),
                                                onTap: () {
                                          ShareLogic.onShare(context,
                                              filePaths: [filePath.path]);
                                                }
                                            )),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Icon(Icons.arrow_back_ios),
                                  ),
                                  const SizedBox(height: 6.0),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      data["subject"]??"",
                                      style: const TextStyle(
                                        color: const Color(0xff242126),
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ).toList()):
                      CircularProgressIndicator(),  )
              : SizedBox(height: 50,child:
              Text("No_data_added"));
            }
        ),
      );
    }    );
  }
}
