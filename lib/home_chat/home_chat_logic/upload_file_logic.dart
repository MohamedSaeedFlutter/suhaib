import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suhaib/models/files_model.dart';
import 'package:suhaib/states/chat_state.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as path;

class UploadFileLogic extends Cubit<ChangeChatState>  {
  UploadFileLogic() : super(InitialChatState());

  static UploadFileLogic get(context) => BlocProvider.of(context);


  Future<void> sendFile(
      {File localFile, String amId,}) async {
    if (localFile != null) {
      print("uploading image");
      var fileExtension = path.extension(localFile.path);
      print(fileExtension);
      var uuid = const Uuid().v4();
      final Reference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('sahib/data/${amId}/');
      await firebaseStorageRef.putFile(localFile)
          .catchError((onError) {
        print(onError);
        return false;
      });
      String url = await firebaseStorageRef.getDownloadURL();
      print("download url: $url");
      Files file = Files(
          fileUrl:  url,
          userId: amId,
          id: "$amId$uuid$url",
          date: DateTime.now().toIso8601String().substring(0,19));
      send(files:  file);
    } else {
      print('...skipping image upload');
    }
  }

  Future<void> send({Files files}) async {
    await FirebaseFirestore.instance
    .collection("persons").doc(files.id)
        .collection('files')
        .add(files.toMap())
        .then((value) {})
        .catchError((error) {});
    emit(SendMessageChatState());
  }

}



