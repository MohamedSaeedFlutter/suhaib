
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suhaib/home_chat/home_chat_logic/home_chat_api.dart';
import 'package:suhaib/states/chat_state.dart';


class test extends StatefulWidget {
  @override
  _testState createState() => _testState();
}

class _testState extends State<test> {
  @override
  void initState() {
    super.initState();
  }
  String defaultImg = "https://upload.wikimedia.org/"
      "wikipedia/commons/thumb/b/bc/Unknown_person.jpg/542px-Unknown_person.jpg";
  var auth = FirebaseAuth.instance.currentUser;


  @override
  Widget build(BuildContext context) {
    print("uid" + FirebaseAuth.instance.currentUser.uid);
      return Expanded(
        child: BlocConsumer<DataApi, ChangeChatState>(
        listener: (context, state) { print(state); },
        builder: (context, state) { print(state); print(" bloc Consumer works");
        return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: DataApi.get(context).recentList(uid: auth.uid),
          builder: (context, snapshot) {
            List<T> flattenDeep<T>(Iterable<dynamic> list) => [
              for (var element in list)
                if (element is! Iterable) element else ...flattenDeep(element), ];
            List<dynamic> personIdList = [];  List<dynamic> personVerIdList = [];
            var b = [];  Message msgItem = Message();
            print("snap1.docs......${snapshot.data.docs}");
            for (var doc in snapshot.data.docs) {
              print("snap2.docs......${snapshot.data.docs}");
              print("doc.data() ${doc.data()}");
    msgItem = Message.fromJSON(doc.data());
    print("msgItem...$msgItem");
    if (msgItem.messageWith == null) { print("-1"); continue;}
    else{
    if (!msgItem.messageWith.contains(auth.uid)) {print("-2"); continue;}
    else{ print("3");
    msgItem.messageWith.removeWhere((item) => item == auth.uid);
    print("friendId.............${msgItem.messageWith}"); print("4");
    personIdList.add(msgItem.messageWith.elementAt(0));
    print("personIdList.............$personIdList");
    // personVerIdList = flattenDeep(personIdList).toSet().toList();
    personVerIdList = [...{...personIdList}];
    print("personVerIdList$personVerIdList");  } } }
           // b = Set.from(personIdList.expand((x) => [x.toString()])).toList();
           //  print("bbbbbb ${b}");


          return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: DataApi.get(context).recentPersons(personIdList: personVerIdList),
              builder: (context, snapshot) {
                print("0////////////${[...{...personVerIdList}]}");
                print("data sss ....${snapshot?.data?.docs?.length}");
                return
                snapshot?.data != null  ?
                 Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: auth != null ?ListView(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          scrollDirection: Axis.vertical,
                            children: snapshot.data.docs.map((DocumentSnapshot document) {
                              Map<String, dynamic> data = document.data() as Map<String,
                                  dynamic>;  print("data0000099999 : $data");
                            return GestureDetector(
                              // onDoubleTap: () =>   Navigator.push(context,MaterialPageRoute(
                              //   builder: (context) => DetailScreen(personId: data['id'],
                              //   ),
                              // ),
                              // ),
                              onTap: () {},
                                  // Navigator.push(context,MaterialPageRoute(
                                  // builder: (context) => ChatScreen(
                                  //   userId:data["id"],
                                  //         ),
                                  //   ),
                                  // ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child:
                                Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: 35.0,
                                      backgroundImage: NetworkImage(
                            data["imageUrl"] != null ? data["imageUrl"] : defaultImg),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            data["name"]??"",
                                            style: const TextStyle(
                                              color: Colors.teal,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            data["mail"]??"", maxLines: 2,
                                            overflow: TextOverflow.fade,
                                            style: const TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              color: Colors.teal,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ).toList()):
                        CircularProgressIndicator(),

                                 )
                : SizedBox(height: 50,child: Text("No_data_added"),);
              }
      );
    });}));
    }
  }
