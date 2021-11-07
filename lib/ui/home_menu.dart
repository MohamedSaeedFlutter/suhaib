import 'package:flutter/material.dart';
import 'package:suhaib/Auth/auth_logic/auth_api_REMOTE_1630.dart';

import 'bottom_n_b.dart';
import 'sec_main_screen.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({Key key}) : super(key: key);

  @override
  _HomeMenuState createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  List<String> listTxt =
  ["الدرسات والابحاث المزجية(المختلطة)","الدراسات والابحاث النوعية",
    "الدراسات والابحاث الكمية","مصادر المعلومات"];
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body: ListView.builder(
        reverse: true,
        itemCount: listTxt.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              AuthApi.get(context).setCurrentIndex(2);
              AuthApi.get(context).setAppBarTxt(txt: listTxt[index]??"");
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 12),
              child: Container( height: 72,
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Icon(Icons.arrow_back_ios),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          listTxt[index],
                          style: TextStyle(
                            fontFamily: 'Tajawal',
                            fontSize: 17,
                            color: const Color(0xff242126),
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],),),
              ),
            ),
          );
        },
      ),
    );
  }
}
