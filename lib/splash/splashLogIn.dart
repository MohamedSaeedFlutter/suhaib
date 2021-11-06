import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:suhaib/Auth/auth_logic/auth_api_REMOTE_1630.dart';

class SplashLogin extends StatefulWidget {
  const SplashLogin({Key key}) : super(key: key);

  @override
  _SplashLoginState createState() => _SplashLoginState();
}

class _SplashLoginState extends State<SplashLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          image: DecorationImage( fit: BoxFit.cover,
        image: AssetImage(
          "assets/icon.png",),
      )),
      child: ListView(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          Image.asset("assets/intro/ic.png",height: 80,width: 300,),
          Padding(
            padding: EdgeInsets.only(right: 8,),
            child: Text("العلم النافع",textAlign: TextAlign.right ,style:
            TextStyle(fontSize: 24,fontWeight: FontWeight.w600,
                color: Color.fromRGBO(56, 59, 110,1)),),
          ),
          Padding(
            padding: EdgeInsets.only(right: 8,),
            child: Text(".يوصف عصرنا بعصر العلم، وتفخر الأُمم بالاتصاف به",
              textAlign: TextAlign.right , style:
            TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.black),),
          ),
          Padding(
            padding: EdgeInsets.only(right: 8,),
            child: Text("مقدمة تعريفية",textAlign: TextAlign.right ,style:
            TextStyle(fontSize: 24,fontWeight: FontWeight.w600,
                color: Color.fromRGBO(56, 59, 110,1)),),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 60, right: 12, bottom: 12,top: 8,),
            child: Text(" .وإدراك المسلمون الأوائل لهذا المعنى يُعدّ من "
                "يوصف عصرنا بعصر العلم، وتفخر الأُمم بالاتصاف به"
                "أبرز الأسباب التي دفعتهم لإقامة حلقات العلم بعد الفتوحات الإسلامية"
                "، فقد برع المسلمون في العديد من التخصصات،"
                " فقام جابر بن حيَّان بإرساء قواعد في الكيمياء تُعد الأُولى من نوعها، "
                "وفي مجال الطب ألَّف الرازي الكثير من الكُتب التي تُرجِمت إلى العديد من اللغات",style:
            TextStyle(fontSize: 15,fontWeight: FontWeight.w400,
                color: Colors.black),textAlign: TextAlign.right ,),
          ),
          SizedBox(height: 18,child: Text("...",textAlign: TextAlign.center,),),
          Padding(
            padding: EdgeInsets.only(right: 8,),
            child: Text("صهيب صالح معمار",textAlign: TextAlign.right ,style:
            TextStyle(fontSize: 24,fontWeight: FontWeight.w600,color: Colors.black),),
          ),
          Padding(
            padding: EdgeInsets.only(right: 8,),
            child: GestureDetector(onTap:  () {
      AuthApi.get(context).urlLauncher(mail: "Suhaib.memar@gmail.com");
            },
              child: Row( mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("SuhaibMemar",textAlign: TextAlign.right ,style:
                  TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.black),),
                  SizedBox(width: 18,),
                  FaIcon(FontAwesomeIcons.twitterSquare,
                    color: Colors.blue,
                    textDirection: TextDirection.rtl,),
                ],
              ),
            ),
          ),
        SizedBox(height: 10,),
          Padding(
            padding: EdgeInsets.only(right: 8,),
            child: GestureDetector(onTap:  () {
              AuthApi.get(context).urlLauncher(mail: "Suhaib.memar@gmail.com");
            },
             child: Row( mainAxisAlignment: MainAxisAlignment.end,
                 children: [
                   Text("Suhaib.memar@gmail.com",
                     textAlign: TextAlign.right ,style:
              TextStyle(fontSize: 18,fontWeight: FontWeight.w500,
                  color: Colors.black),),
               SizedBox(width: 18,),
                   Icon(Icons.email,color: Colors.amber,),
                 ],
               ),
            ),
          ),
          SizedBox(height: 18,),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18, vertical: 2,
            ),
            child: ElevatedButton(
              onPressed: () {
            }, child: Text("تسجيل الدخول",style:
            TextStyle(fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.white),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 18, left: 18, top: 2, bottom: 18,
            ),
            child: ElevatedButton(
              onPressed: () {
              }, child: Text("عضو جديد",style:
            TextStyle(fontSize: 18,
                fontWeight: FontWeight.w400,color: Colors.white),),
            ),
          )
        ],
      ),
    ));
  }
}
