import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:suhaib/core/constants.dart';



class HomeScreen extends StatefulWidget {
  HomeScreen({this.selectedIndex});
  var selectedIndex = 0 ;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  onItemTapped(var index){
    setState(() {
      widget.selectedIndex = index;
    });
  }
  bool _showDrawerVar = false;
  _showDrawerStateFunction(){
    setState(() {
      _showDrawerVar = !_showDrawerVar;
    });
  }
  bool langClicked = false;

  String defaultImg = "https://upload.wikimedia.org/"
      "wikipedia/commons/thumb/b/bc/Unknown_person.jpg/542px-Unknown_person.jpg";
  TextEditingController phController = TextEditingController();
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> get widgetOptions => <Widget>[
    Text(""),
    Text(""),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          backgroundColor: kMainColor,
          leading: IconButton(
            icon: const Icon(Icons.search),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {
              setState(() {
                widget.selectedIndex = 0;
              });
            },
          ),
          elevation: 0.0,
          actions:  <Widget>[
            IconButton( icon : const Icon(Icons.menu),
              onPressed: () {
                return setState(() {
                  widget.selectedIndex = 4;
                });
              },),
          ]),
      body:
      Center(
        child: widgetOptions[0]
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.school),
            label: "قائمتى",
            backgroundColor: kMainColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "الرئيسية",
            backgroundColor: kMainColor,
          ),
        ],
        currentIndex: 0,
        // widget.selectedIndex < 2 ? widget.selectedIndex : 0 ,
        selectedItemColor: Colors.amber[800],
        onTap: onItemTapped,
      ),
    );
    // });
  }
}
