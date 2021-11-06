import 'dart:io';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suhaib/home_chat/home_chat_logic/home_chat_api.dart';
import 'package:suhaib/models/person_model.dart';
import 'package:suhaib/states/chat_state.dart';


class DetailScreen extends StatefulWidget {
String personId;
DetailScreen({this.personId});
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
  }
  var auth = FirebaseAuth.instance.currentUser;
  String defaultTxt = "__________________________________________";
  String defaultImg = "https://upload.wikimedia.org/"
      "wikipedia/commons/thumb/b/bc/Unknown_person.jpg/542px-Unknown_person.jpg";
  File _imageFile;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
      child: AlertDialog(contentPadding: EdgeInsets.all(10),
          backgroundColor: Colors.teal,
          content:
          BlocConsumer<DataApi, ChangeChatState>(listener: (context, state) {
            print(state);
          }, builder: (context, state) {
            print(state);
            print(" bloc Consumer works");
            return auth != null ?
              FutureBuilder<Person>(
                future: DataApi.get(context).getPerson(uid: widget.personId),
                builder: (context, snapshot) {
                  var person = snapshot?.data;
                  print("dddddddd"); print(person.id);
                  if (snapshot.connectionState != ConnectionState.done) {
                    return RefreshProgressIndicator(); }
                  if (!snapshot.hasData) {
                    return Center(
                      child: const Text(
                        "chat has not data", style: TextStyle(fontSize: 35
                          ,color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth: 90,
                                  maxHeight: 90,
                                ),
                                child:Image.network(person?.imageUrl??defaultImg,
                                  fit: BoxFit.cover,
                                  height: 90,),
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    person?.name ?? defaultTxt,
                                    overflow: TextOverflow.fade,
                                    maxLines: 2,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    person?.job ?? defaultTxt,
                                    overflow: TextOverflow.clip,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    person?.catagory ?? defaultTxt,
                                    overflow: TextOverflow.clip,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                'About ',
                                style: const TextStyle(
                                  color: Colors.amber,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Text(
                                person?.about ?? defaultTxt,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text(
                                  'Education',
                                  style: const TextStyle(
                                    color: Colors.amber,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                            Expanded(
                                flex: 5,
                                child: Text(
                                  person?.education ?? defaultTxt,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text(
                                  'experience',
                                  style: const TextStyle(
                                    color: Colors.amber,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                            Expanded(
                                flex: 5,
                                child: Text(
                                  person?.experience ?? defaultTxt,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Column(children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'phone',
                                  style: const TextStyle(
                                    color: Colors.amber,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Text(
                                  // person?.phone ?? defaultTxt,
                                  person?.phone ?? defaultTxt,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'WhatsUp',
                                  style: const TextStyle(
                                    color: Colors.amber,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Text(
                                  person?.whatsapp ?? defaultTxt,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'Email',
                                  style: const TextStyle(
                                    color: Colors.amber,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Text(
                                  person?.mail ?? defaultTxt,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'Facebook',
                                  style: const TextStyle(
                                    color: Colors.amber,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Text(
                                  person?.facebook ?? defaultTxt,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'Linkedin',
                                  style: const TextStyle(
                                    color: Colors.amber,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Text(
                                  person?.linkedin ?? defaultTxt,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'Tweater',
                                  style: const TextStyle(
                                    color: Colors.amber,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Text(
                                  person?.tweater ?? defaultTxt,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'Youtube',
                                  style: const TextStyle(
                                    color: Colors.amber,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Text(
                                  person?.youtube ?? defaultTxt,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],),

                        SizedBox(height: 20,),
                      ],
                    ),
                  );
                }):
            RefreshProgressIndicator();
          })),
    ) );

  }
}
