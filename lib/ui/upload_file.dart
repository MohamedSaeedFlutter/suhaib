import 'dart:io';

import 'package:file_picker_cross/file_picker_cross.dart';
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
  TextEditingController pdfController ;
  File fileOutput;
  FilePickerCross filePickerCross;
  String _fileString = '';
  Set<String> lastFiles;
  FileQuotaCross quota = FileQuotaCross(quota: 0, usage: 0);

  _pickFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path);
    } else {
print("User canceled the picker");    }
  }

  _sendFile(){
    UploadFileLogic.get(context).sendFile(
        amId: auth.uid, localFile: fileOutput,
        cat: widget.category , sub: pdfController.text
    ).then((value) => Fluttertoast.showToast(
        msg: "The File uploaded successfully !"));
  }


  @override
  Widget build(BuildContext context) {

    pdfController =
    TextEditingController(text:filePickerCross?.path ?? 'unknown' );
        print("1////${filePickerCross?.path ?? 'unknown'}");
    return Scaffold(
      body: Center(child:
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
      GestureDetector(
        child: Image.asset("assets/intro/pdf6.png",
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.25,),
        onTap:() => _selectFile(context),
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
              onPressed: () {
                print("category ${AuthApi.get(context).appBarTxt}");
print("1////${AuthApi.get(context).fileOutput?.path?.split('/')?.last?.toString()??""}");
                UploadFileLogic.get(context).sendFile(
                    amId: auth.uid,
                    localFile: File(filePickerCross?.path),
                    cat: AuthApi.get(context).appBarTxt,
                    sub: pdfController.text
                ).then((value) => Fluttertoast.showToast(
                    msg: "The File uploaded successfully !"));
              },
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
  void _selectFile(context) {
    FilePickerCross.importMultipleFromStorage().then((filePicker) {
      setFilePicker(filePicker[0]);
      print("filePicker555555555${filePicker.single.path}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('You selected ${filePicker.length} file(s).'),
        ),
      );
      setState(() {});
    });
  }



  setFilePicker(FilePickerCross filePicker) => setState(() {
    filePickerCross = filePicker;
    filePickerCross.saveToPath(path: filePickerCross.fileName);
    FilePickerCross.quota().then((value) {
      setState(() => quota = value);
    });
    lastFiles.add(filePickerCross.fileName);
    try {
      _fileString = filePickerCross.toString();
    } catch (e) {
      _fileString = 'Not a text file. Showing base64.\n\n' +
          filePickerCross.toBase64();
    }
  });


}
