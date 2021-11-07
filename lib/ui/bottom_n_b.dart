import 'package:flutter/material.dart';
import 'package:suhaib/Auth/auth_logic/auth_api_REMOTE_1630.dart';
import 'package:suhaib/ui/all_data.dart';
import 'package:suhaib/ui/home_menu.dart';
import 'package:suhaib/ui/sec_main_screen.dart';
import 'package:suhaib/ui/upload_file.dart';


class HomeApp extends StatefulWidget {
  const HomeApp({Key key, this.appBarTxt}) : super(key: key);
  final String appBarTxt;
  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {


  int selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static  List<Widget> _widgetOptions = <Widget>[
    UploadFile(),
    HomeMenu(),
    SecMainScreen(),
    AllData(),
    UploadFile()
  ];

  void _onItemTapped(int index) {
    AuthApi.get(context).setCurrentIndex(index);
    // setState(() {
    //   selectedIndex = index;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(AuthApi.get(context).currentIndex == 0 ?"قائمتى"
           :AuthApi.get(context).currentIndex == 1 ?"القائمة الرئيسية":
        AuthApi.get(context).appBarTxt??""),
      ),
      body: Center(
        child: _widgetOptions.elementAt(
            AuthApi.get(context).currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'قائمتى',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
        ],
        currentIndex: AuthApi.get(context).currentIndex > 1 ? 1 :
                      AuthApi.get(context).currentIndex ,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
