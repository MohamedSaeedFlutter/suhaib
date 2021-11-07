
import 'dart:io';

import 'package:bloc/bloc.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:suhaib/models/person_model.dart';
import 'package:suhaib/states/chat_state.dart';
import 'package:url_launcher/url_launcher.dart';


enum AuthMode {LogIn , SignUp}

class AuthApi extends Cubit<ChangeChatState> {
  AuthApi() : super(InitialChatState());

  static AuthApi get(context) => BlocProvider.of(context);

  User currentUser;

 Future<User> login({String mail, String pass}) async {
   try{UserCredential authResult = await FirebaseAuth.instance
       .signInWithEmailAndPassword(email: mail.trim(),
       password: pass.trim())
       .catchError((error) {
     print(error);
   });
   if (authResult != null) {
     currentUser = authResult.user;
     if (currentUser != null) {
       print("Log In: $currentUser");
     }
   }} on FirebaseAuthException catch (e){Get.snackbar("Error", e.toString());}
   catch (e){
     rethrow;
   }
   emit(SignInChatState());
    return currentUser;
  }

  Future<User> signInWithGoogle(
      {@required BuildContext context }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleSignInAccount =
    await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      try {
        final UserCredential userCredential =
        await auth.signInWithCredential(credential);
        emit(SignInGoogleChatState());
        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          Fluttertoast.showToast(msg: "account exists with different credential");        }
        else if (e.code == 'invalid-credential') {
          Fluttertoast.showToast(msg: 'invalid-credential');
        }
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      }
    }
    return user;
  }


  Future<User> signup({String mail, String pass,String phone, String name,
                       Future<String> photoURL, Function callBack}) async {
    UserCredential userCredential;
    try {
      print(mail);
      print(pass);
       userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: mail.trim(),
        password: pass.trim(),
      );
      print(userCredential.user);
      print("ssssssssssss");
      emit(SignUpChatState());
    } on FirebaseAuthException catch (e) {
      print(
          "..........................$e.....................................");
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print('......................${e}....................');
    }
    currentUser = userCredential.user;
    return currentUser;  }

  logout() async {
    await FirebaseAuth.instance.signOut()
        .catchError((error) => print('Error :........${error.code}'));
    emit(SignOutChatState());
  }
AuthMode authMode ;
  toLoginState (){
   authMode = AuthMode.LogIn;
   emit(ToLogInState());
  }
  toSignUpState (){
    authMode = AuthMode.SignUp;
    emit(ToSignUpState());
  }
int currentIndex = 0 ;
  setCurrentIndex (int index){
    currentIndex = index;
    emit(SetCurrentIndexState());
  }

  String appBarTxt ;
  setAppBarTxt ({String txt}){
    appBarTxt = txt;
    emit(AppBarTextState());
  }
// appBarText({String x}){
//   String  appBarTxt = "";
//   switch(currentIndex) {
//       case 0: {appBarTxt = "قائمتى";}
//       break;
//       case 1: {appBarTxt = "القائمة الرئيسية";}
//       break;
//       case 4: {appBarTxt = "اضافة";}
//       break;
//       default: {appBarTxt = x;}
//       break;
//     }
//     return appBarTxt;
//   }

  Future <User> initializeCurrentUser() async {
   try{currentUser = await FirebaseAuth.instance.currentUser;}
   catch (e){
     Get.snackbar("Authentication Failed !", "No current user is connected");
     return null;
    };
     emit(IntializeCurrentChatState());
     return currentUser;
  }

  uploadPerson(Person person) async {
    CollectionReference personRef =
    FirebaseFirestore.instance.collection('persons');
    var documentRef = await personRef.doc(person.id).set(person.toMap());
    emit(AddChatState());
    print('uploaded person successfully: ${person.toString()}');
  }

  urlLauncher({String mail}){
    String encodeQueryParameters(
        Map<String, String> params, String mail) {
      return params.entries
          .map((e) =>
      '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: mail,
      query: encodeQueryParameters(<String, String>{
        'Suhaib_Digital_Base_App':  '' },mail),
    );
    launch(emailLaunchUri.toString());
  }






  // Future<String> uploadFile({File localFile,String uid}) async {
  //   final Reference firebaseStorageRef =
  //   FirebaseStorage.instance.ref().child('sahib/data/');
  //   await firebaseStorageRef.putFile(localFile).catchError((onError) {
  //     print(onError);
  //     return false;
  //   });
  //   String url = await firebaseStorageRef.getDownloadURL();
  //   print("uploading file download url: $url");
  //   emit(UploadImageChatState());
  //   return url;
  // }




}
