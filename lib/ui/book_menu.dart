import 'package:flutter/material.dart';
import 'package:suhaib/core/share_widget.dart';

import 'sec_main_screen.dart';

class BookMenu extends StatefulWidget {
  const BookMenu({Key key}) : super(key: key);

  @override
  _BookMenuState createState() => _BookMenuState();
}

class _BookMenuState extends State<BookMenu> {
  List<String> listTxt =
  ["الدرسات والابحاث المزجية(المختلطة)","الدراسات والابحاث النوعية",
    "الدراسات والابحاث الكمية","مصادر المعلومات"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        reverse: true,
        itemCount: listTxt.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => SecMainScreen(),)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 12),
              child: Container( height: 50,
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
                    Container(
                      child: Row( mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Icon(Icons.remove_red_eye,
                              color: Colors.deepOrange,),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Icon(Icons.arrow_downward,
                              color: Colors.deepOrange,),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: InkWell(child: Icon(Icons.share,
                                color: Colors.deepOrange,),
                                  onTap: () {
                                    // ShareLogic.onShare(context, filePaths: ),
                                  }
                              )),
                        ],
                      ),
                    ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          listTxt[index],maxLines: 2,
                          overflow: TextOverflow.fade,
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
