import 'package:bloc/bloc.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suhaib/models/person_model.dart';
import 'package:suhaib/states/chat_state.dart';




class DataApi extends Cubit<ChangeChatState> {
  DataApi() : super(InitialChatState());

  static DataApi get(context) => BlocProvider.of(context);

var auth = FirebaseAuth.instance.currentUser;
  List<T> flattenDeep<T>(Iterable<dynamic> list) => [
    for (var element in list)
      if (element is! Iterable) element else ...flattenDeep(element),
  ];

  Stream<QuerySnapshot<Map<String, dynamic>>> recentList({String uid})   {
    var snap1 ;
    try{snap1 = FirebaseFirestore.instance.collection("messages")
        .snapshots();} catch (e){rethrow;}

    // List<String> personIdList = []; print("snap1.docs......${snap1.docs.length}");
    // for (var doc in snap1.docs) {
    //   var msgItem = Message.fromJSON(doc.data());
    //   print("msgItem...$msgItem");
    //   if (msgItem.messageWith != null) {
    //     if (msgItem.messageWith.contains(auth.uid)) {
    //       var friendId = msgItem.messageWith.remove(auth.uid).toString();
    //       print("friendId.............$friendId");
    //       personIdList.add("$friendId");
    //       print("personIdList.............$personIdList");
    //       print(flattenDeep(personIdList).toSet().toList());
    //     }
    //   }
    // }
    // flattenDeep(personIdList).toSet().toList();
    // emit(StreamListState());
    return snap1;
  }




 Stream<QuerySnapshot<Map<String, dynamic>>>recentPersons({var personIdList }) {
   var snap2;
    try{ snap2 =  FirebaseFirestore.instance.collection("persons")
          .where("id",whereIn: personIdList).snapshots();}
          catch(e){print("rec Error : $e");}
                 return snap2;
  }


  Stream<QuerySnapshot<Map<String, dynamic>>>getFavourites({String uid})  {
    var res;
    try{   res =
    FirebaseFirestore.instance.collection('persons').doc(uid)
        .collection("fav").where("id",isNotEqualTo: uid).snapshots();}
        catch (e){print("Error fav $e");}
    return  res;
  }


  //
  // Future<List<Person>> getFavourites({String uid}) async {
  //   var res =
  //   await FirebaseFirestore.instance.collection('persons').doc(uid)
  //       .collection("fav").where("id",isNotEqualTo: uid).get();
  //   print("ccccccccc");
  //   List<Person> favList = [];
  //   for (var i in res.docs) {
  //     var person = Person.fromJSON(i.data()); print("fav person ${person}");
  //     favList.add(person);
  //   }
  //   return  favList;
  // }

  Future<Person> getPerson({String uid}) async {
    var res =
    await FirebaseFirestore.instance.collection('persons').doc(uid).get();
    print("ccccccccc");
    print(res.data());
    var person = Person.fromJSON(res.data());
    print('ppppppp');
    print(person.id);
    return person;
  }


}
