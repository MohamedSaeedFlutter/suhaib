import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:suhaib/Auth/auth_logic/auth_api_REMOTE_1630.dart';
import 'package:suhaib/Auth/widgets/custum_txt_field.dart';
import 'package:suhaib/models/person_model.dart';
import 'package:suhaib/ui/bnb.dart';




class LogIn extends StatefulWidget {
   // LogIn({AuthMode authMode}) ;
// AuthMode authMode ;
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController passController = TextEditingController();
  TextEditingController coController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  String _name , _mail , _pass , _phone;
AuthMode authMode;
  resetPass() {
    passController.text = "";
    coController.text = "";
  }

  @override
  void initState() {
    BlocProvider.of<AuthApi>(context, listen: false);
    authMode = AuthApi.get(context).authMode;
    super.initState();
  }
bool isGoogle = false;
bool isFacebook = false;
  String mail , pass , coPass;
  String defaultImg = "https://upload.wikimedia.org/"
      "wikipedia/commons/thumb/b/bc/Unknown_person.jpg/542px-Unknown_person.jpg";
  File _imageFile;
  String imgUrl;
  Person account = Person();
  bool hud = false;

  _loginBack (){
    // setState(() {
    //   hud = true;
    // });

  }
  _registerBack() {
    setState(() {
      hud = true;
    });
  }
  List<String> loc;
  String country, city , area , town;

  _onSubmit() async {
    if(formKey.currentState.validate()){
      if(authMode == AuthMode.LogIn){
        // if(isGoogle){
        //   AuthApi.get(context).signInWithGoogle(context: context).then((value) =>
        //       Navigator.push(context, MaterialPageRoute(builder: (context) =>
        //           HomeScreen(),))
        //   );
        // }
        // else if (isFacebook){ AuthApi.get(context).signInWithFacebook().then((value) =>
        //     Navigator.push(context, MaterialPageRoute(builder: (context)
        //     => BottomNav(),))
        // );}
 // else {
   await AuthApi.get(context).login(mail: mailController.text ,
          pass: passController.text ,).then((value) {
          if(value != null){
            Navigator.push(context,
                MaterialPageRoute(builder: (context) =>
                    HomeScreen(),));
          }
        });
      // }
      }
      else {
        if(coController.text != passController.text){
          return  Fluttertoast.showToast(
              msg: "Please confirm your password correctly !",);
        } else {

          // if(isGoogle){
          //   AuthApi.get(context).signInWithGoogle(context: context).then(
          //           (value) async {
          //         Person person = Person(name: value.displayName,
          //           id: value.uid,mail: value.email,phone: value.phoneNumber,
          //           imageUrl: value.photoURL,
          //           country: country, city: city , vilige: town,
          //         );
          //         await  AuthApi.get(context).uploadPerson(person);
          //         _registerBack;
          //           }
          //   );
          // }
          // else if (isFacebook){
          //   AuthApi.get(context).signInWithFacebook().then(
          //           (value) async {
          //         Person person = Person(name: value.displayName,
          //           id: value.uid,mail: value.email,phone: value.phoneNumber,
          //           imageUrl: value.photoURL,
          //           country: country, city: city , vilige: town,
          //         );
          //         await  AuthApi.get(context).uploadPerson(person);
          //         _registerBack;
          //           }
          //   );
          // }
          // else {

          AuthApi.get(context).signup(
            mail: mailController.text ,
            pass: coController.text ,
          ).then((value) async {
            User fire = FirebaseAuth.instance.currentUser;
            Person person = Person(
              imageUrl: imgUrl??"",
              pass: passController.text, mail: mailController.text,
              id: fire.uid,
              country: country, city: city , vilige: town,
            );
            await  AuthApi.get(context).uploadPerson(person);
            setState(() {
              authMode = AuthMode.LogIn;
            });
            _registerBack;
          });}
      }
    } return null;
  }
// }


  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    Person person = Person(
      pass: passController.text.trim(),
      mail: mailController.text.trim(),
    );
    return Scaffold( backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
      backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(
            Icons.arrow_back_ios ,color: Colors.black,),
        onPressed: () { Navigator.pop(context);},),
        actions: [Padding(
          padding:  EdgeInsets.only(
              right: MediaQuery.of(context).size.width * 0.3),
          child: Image.asset("assets/intro/ic.png",
          alignment: Alignment.center,),
        ),],
      ),
      body:  ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        children: <Widget>[
          SizedBox(height: height * .02,),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Text(
              authMode == AuthMode.LogIn ? "تسجيل الدخول" : "تسجيل جديد",
              textAlign: TextAlign.end,
              style: const TextStyle(
                  fontSize: 36,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(height: height * .01),
          Form(
            key: formKey,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column( mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    authMode == AuthMode.SignUp ?
                    CustumTextField(nameController: coController,
                        obscureTxt: true,txtType: TextInputType.text,
                        hintTxt: "الاسم" ,
                        // onClick: (value){_pass = value ;}
                    ) : const SizedBox(height: 1),
                    SizedBox(height: height * .02,),
                    CustumTextField(nameController: mailController,
                      hintTxt: "البريد الالكترونى" ,
                      obscureTxt: false,txtType: TextInputType.emailAddress,
                      onClick: (value){_mail = value;},),
                    SizedBox(height: height * .02,),
                    CustumTextField(
                      nameController: passController,obscureTxt: true,
                      txtType: TextInputType.visiblePassword,
                      hintTxt: "الرقم السرى" ,
                    ),
                    SizedBox(height: height * .02,),
                authMode == AuthMode.LogIn ?
                    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(onPressed: () {

                      },
                          child: Text("هل نسيت كلمة السر؟",style:
                          TextStyle(color: Color.fromRGBO(111, 108, 108, 1.0),
                      fontSize: 13,fontWeight: FontWeight.w500),)),
                      TextButton(onPressed: () {
                        setState(() {
                        authMode = AuthMode.SignUp;
                      });},
                          child: Text("انشاء حساب",  style:
                          TextStyle(color: Color.fromRGBO(111, 108, 108, 1.0),
                              fontSize: 13,fontWeight: FontWeight.w500),)),
                    ],):
                    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(onPressed: () {

                        },
                            child: Text("هل نسيت كلمة السر؟",style:
                            TextStyle(color: Color.fromRGBO(111, 108, 108, 1.0),
                                fontSize: 13,fontWeight: FontWeight.w500),)),
                        TextButton(onPressed: () {
                          setState(() {
                            authMode = AuthMode.LogIn;
                          });},
                            child: Text(" لديك حساب بالفعل ؟",  style:
                            TextStyle(color: Color.fromRGBO(111, 108, 108, 1.0),
                                fontSize: 13,fontWeight: FontWeight.w500),)),
                      ],),
                    SizedBox(height: height * .02,),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child:
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(155, 156, 184 , 1),
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                        onPressed: _onSubmit
                        , child: Text("تسجيل الدخول",style:
                      TextStyle(fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),),
                      ),
                    ),
                    SizedBox(height: height * .02,),
                    Text("---------------------------------أو---------------------------------"),
                    SizedBox(height: height * .02,),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32)),
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                        onPressed: () async {
                         await AuthApi.get(context).signInWithGoogle(context: context)
                                .then((value) async {
                                  Person person = Person(name: value.displayName,
                                    id: value.uid,mail: value.email,
                                  );
                                  await AuthApi.get(context).uploadPerson(person);
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => HomeScreen(),));
                                    }
                            );
                          // AuthApi.get(context).signInWithGoogle(context: context).then((value) =>
                          //     Navigator.push(context, MaterialPageRoute(builder: (context) =>
                          //   HomeScreen(),)));
                        },
                        icon: FaIcon(FontAwesomeIcons.google),
                        label: Text(" الاستمرار عبر",style:
                      TextStyle(fontSize: 18,
                          fontWeight: FontWeight.w400,color: Colors.white),),
                      ),
                    ),
                    SizedBox(height: height * .02,),
                    Row(mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                     TextButton(onPressed: () {},
                       child: Text("الشروط والأحكام",style:
                         TextStyle(fontSize: 12,color: Colors.black ,
                         fontWeight: FontWeight.w600),),),
                      Text("الاشتراك فى التطبيق بعطى الموافقة على",
                      style: TextStyle(color: Color.fromRGBO(111, 108, 108, 1.0),
                      fontSize: 12,fontWeight: FontWeight.w500),),
                    ],),
                    SizedBox(height: height * .02,),

                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
    // },
    // );
  }
}

