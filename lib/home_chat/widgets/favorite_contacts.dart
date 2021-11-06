
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suhaib/home_chat/home_chat_logic/home_chat_api.dart';
import 'package:suhaib/states/chat_state.dart';


class FavouritesContacts extends StatefulWidget {
  @override
  _FavouritesContactsState createState() => _FavouritesContactsState();
}

class _FavouritesContactsState extends State<FavouritesContacts> {
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
      return Container(height: 250,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "fav_con",
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocConsumer<DataApi, ChangeChatState>(
              listener: (context, state) { print(state); },
              builder: (context, state) { print(state); print(" bloc Consumer works");
              return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: DataApi.get(context).getFavourites(uid: auth.uid),
                  builder: (context, snapshot) { print("data ....${snapshot.data.docs.length}");
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
                              scrollDirection: Axis.horizontal,
                                children: snapshot.data.docs.map((DocumentSnapshot document) {
                                  Map<String, dynamic> data = document.data() as Map<String,
                                      dynamic>;  print("data : $data");
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
                                    child:
                                    Column(
                                      children: <Widget>[
                                        CircleAvatar(
                                          radius: 28.0,
                                          backgroundImage: NetworkImage(
                                              data["imageUrl"]??defaultImg),
                                        ),
                                        const SizedBox(height: 6.0),
                                        Text(
                                          data["name"]??"",
                                          style: const TextStyle(
                                            color: Colors.teal,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600,
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
      );
    }    ),
            ),
            SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'rec_con',
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.0,
                  ),
                ),
                // IconButton(
                //   icon: const Icon(
                //     Icons.more_horiz,
                //   ),
                //   iconSize: 30.0,
                //   color: Colors.blueGrey,
                //   onPressed: () {},
                // ),
              ],
            ),
          ],
        )
      );
  }
}
