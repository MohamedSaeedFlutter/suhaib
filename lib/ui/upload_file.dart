import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:suhaib/Apis/upload_file_logic.dart';
import 'package:suhaib/Auth/auth_logic/auth_api_REMOTE_1630.dart';
import 'package:suhaib/Auth/widgets/custum_txt_field.dart';

class UploadFile extends StatefulWidget {
  const UploadFile({Key key, this.category}) : super(key: key);
final String category;
  @override
  _UploadFileState createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {
  var auth = FirebaseAuth.instance.currentUser;
  File fileOutput;
  TextEditingController pdfController ;
_sendFile(){
  UploadFileLogic.get(context).sendFile(
      amId: auth.uid, localFile: AuthApi.get(context).fileOutput,
      cat: widget.category , sub: pdfController.text
  ).then((value) => Fluttertoast.showToast(
      msg: "The File uploaded successfully !"));
}
  _pickFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result != null) {
       AuthApi.get(context).setFileOutput(
         file: File(result.files.single.path)
       );
    } else {
        print("File picker is cancelled");}
  }

  @override
  Widget build(BuildContext context) {
    pdfController =
    TextEditingController(text:
    fileOutput?.path?.split('/')?.last.toString()??"");
print("1////${fileOutput?.path?.split('/')?.last.toString()??""}");
    return Scaffold(
      body: Center(child:
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
              obscureTxt: false,txtType: TextInputType.text,
              hintTxt: "العنوان" ,vald: "برجاء ادخال عنوان",
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 18),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.95,
            child: ElevatedButton(
              onPressed: _sendFile ,
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(155, 156, 184 , 1),
                // onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
              child: Text("اضافة",style:
            TextStyle(fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.white),),
            ),
          ),
        ),
      ],),),);
  }
}
