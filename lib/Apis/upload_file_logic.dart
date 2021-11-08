import 'dart:io';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suhaib/models/files_model.dart';
import 'package:suhaib/models/person_model.dart';
import 'package:suhaib/states/chat_state.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as path;

class UploadFileLogic extends Cubit<ChangeChatState>  {
  UploadFileLogic() : super(InitialChatState());

  static UploadFileLogic get(context) => BlocProvider.of(context);


  Future<void> sendFile(
      {File localFile, String amId,String cat, String sub}) async {
    if (localFile != null) {
      print("uploading image");
      var fileExtension = path.extension(localFile.path);
      print(fileExtension);
      var uuid = const Uuid().v4();
      final Reference firebaseStorageRef = FirebaseStorage.instance
          .ref().child('sahib/data/${amId}$uuid/');
      await firebaseStorageRef.putFile(localFile)
          .catchError((onError) {print(onError); return false;});
      String url = await firebaseStorageRef.getDownloadURL();
      print("download url: $url");
      Files file = Files(
          subject: sub,
          fileUrl:  url,
          userId: amId,
          category: cat,
          id: "$amId$uuid$url",
          date: DateTime.now().toIso8601String().substring(0,19));
      send(files:  file);
    } else {
      print('...skipping image upload');
    }
  }

  Future<void> send({Files files }) async {
    await FirebaseFirestore.instance
    .collection("persons").doc(files.userId)
        .collection('files')
        .add(files.toMap())
        .then((value) {})
        .catchError((error) {});
    emit(SendMessageChatState());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>getFiles(
      {String uid})  {
    var res;
    try{   res =
        FirebaseFirestore.instance.collection('persons').doc(uid)
            .collection("files")
            .snapshots();}
    catch (e){print("Error Files $e");}
    return  res;
  }

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


  //
  // final mainReference = FirebaseDatabase.instance.reference().child('Database');
  // Future getPdfAndUpload()async{
  //   var rng = new Random();
  //   String randomName="";
  //   for (var i = 0; i < 20; i++) {
  //     print(rng.nextInt(100));
  //     randomName += rng.nextInt(100).toString();
  //   }
  //   FilePickerResult result = await FilePicker.platform.pickFiles();
  //   File file = File(result.files.first.path);
  //       // .getFile(type: FileType.custom, fileExtension: 'pdf')
  //   String fileName = '${randomName}.pdf';
  //   print(fileName);
  //   print('${file.readAsBytesSync()}');
  //   savePdf(file.readAsBytesSync(), fileName);
  // }
  //
  // Future savePdf(List<int> asset, String name) async {
  //
  //   Reference reference = FirebaseStorage.instance.ref().child(name);
  //   UploadTask uploadTask = reference.putData(asset);
  //   String url = await (await uploadTask..onComplete).ref.getDownloadURL();
  //   print(url);
  //   documentFileUpload(url);
  //   return  url;
  // }
  // void documentFileUpload(String str) {
  //
  //   var data = {
  //     "PDF": str,
  //   };
  //   mainReference.child("Documents").child('pdf').set(data).then((v) {
  //   });
  // }











}



