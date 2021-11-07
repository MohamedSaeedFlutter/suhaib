import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:suhaib/Auth/widgets/custum_txt_field.dart';
import 'package:suhaib/home_chat/home_chat_logic/upload_file_logic.dart';

class UploadFile extends StatefulWidget {
  const UploadFile({Key key}) : super(key: key);

  @override
  _UploadFileState createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {

  File file;
  TextEditingController pdfController ;

  Future<File> _pickFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result != null) {
       file = File(result.files.single.path);
    } else {
        print("File picker is cancelled");    }
    return file;
  }

  @override
  Widget build(BuildContext context) {
    var auth = FirebaseAuth.instance.currentUser;
    pdfController =
    TextEditingController(text: file?.path.toString());

    return Scaffold(body: Center(child:
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
      InkWell(
        onTap: _pickFile,
        child: Image.asset("assets/intro/pdf6.png",
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.25,),
      ),
        Padding(
          padding: const EdgeInsets.only(top: 18),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.95,
            child: CustumTextField(nameController: pdfController,
              obscureTxt: true,txtType: TextInputType.text,
              hintTxt: "العنوان" ,vald: "برجاء ادخال عنوان",
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 18),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.95,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(155, 156, 184 , 1),
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
              onPressed: () {
                UploadFileLogic.get(context).sendFile(
                  localFile: file,
                    amId: auth.uid
                );
              }
              , child: Text("اضافة",style:
            TextStyle(fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.white),),
            ),
          ),
        ),
      ],),),);
  }
}
