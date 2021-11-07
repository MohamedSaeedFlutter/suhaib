import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:suhaib/Apis/download_file.dart';
import 'package:suhaib/Auth/auth_logic/auth_api_REMOTE_1630.dart';
import 'package:suhaib/Auth/widgets/custum_txt_field.dart';
import 'package:suhaib/models/firebase_file.dart';
import 'package:suhaib/splash/splash0.dart';
import 'package:open_file/open_file.dart';

class BookMenu extends StatefulWidget {
  const BookMenu({Key key, this.file, this.appBarTxt})
      : super(key: key);
  final String appBarTxt;
  final FirebaseFile file;
  @override
  _BookMenuState createState() => _BookMenuState();
}

class _BookMenuState extends State<BookMenu> {
  TextEditingController searchController = TextEditingController();
  List<String> listTxt =
  ["الدرسات والابحاث المزجية(المختلطة)","الدراسات والابحاث النوعية",
    "الدراسات والابحاث الكمية","مصادر المعلومات"];
  @override
  Widget build(BuildContext context) {
    String url;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {Navigator.pop(context);},
        ),
        title:Text(widget.appBarTxt??""),
        actions: [
          InkWell( onTap: () {
            AuthApi.get(context).setCurrentIndex(4);

            },
            child: Row(children: [
              Icon(Icons.add_circle_outline,size: 32,),
              SizedBox(width: 3,),
              Text("أضف",style: TextStyle(fontSize: 18),),
              SizedBox(width: 12,),
            ],),
          )
        ],
      ),
      body:
          Column(children: [
            Container(child: Row(children: [
              CustumTextField(
                nameController: searchController,
                obscureTxt: true,txtType: TextInputType.text,
                hintTxt: "ابحث" ,
                // onClick: (value){_pass = value ;}
              ),
            ],),),
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: listTxt.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                        Navigator.push(context,
                        MaterialPageRoute(builder: (context) =>
                            Splash0(),));
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
                              Container(
                                child:
                                Row( mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: InkWell(
                                        onTap: () async {
                                          var file = await DefaultCacheManager().getSingleFile(url);
                                          OpenFile.open(
"https://firebasestorage.googleapis.com/v0/b/semsar-21596.appspot.com/o/sahib%2Fdata%2FWpn36EAgeIMQFUEbNYbBXcAIaNp1ad7157d3-7d9c-4d4f-a31b-568114c08bbc?alt=media&token=1472b5b7-0abd-43c5-b018-535744ea61e4");},
                                        child: Icon(Icons.remove_red_eye,
                                          color: Colors.deepOrange,),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: InkWell(onTap:() async {
                                        await FirebaseApi.downloadFile(widget.file.ref);

                                        final snackBar = SnackBar(
                                          content: Text('Downloaded ${widget.file.name}'),
                                        );
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      },
                                        child: Icon(Icons.arrow_downward,
                                          color: Colors.deepOrange,),
                                      ),
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
                                    fontSize: 14,
                                    color: const Color(0xff242126),
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.right,
                                ),

                              ),
                            ],),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],),
    );
  }
}
