import 'package:flutter/material.dart';

class Splash0 extends StatefulWidget {
  const Splash0({Key key}) : super(key: key);

  @override
  _Splash0State createState() => _Splash0State();
}

class _Splash0State extends State<Splash0> {
  @override
  Widget build(BuildContext context) {
    return
     Scaffold(body:
     Center(
       child: Container(
           width: MediaQuery.of(context).size.width * 0.5,
           height: MediaQuery.of(context).size.height * 0.15,
           child: Image.asset("assets/intro/ic.png",fit: BoxFit.fill,)),
     )
       ,) ;
  }
}
