import 'package:flutter/material.dart';

class NotSignIn extends StatefulWidget {
  const NotSignIn({Key key}) : super(key: key);

  @override
  _NotSignInState createState() => _NotSignInState();
}

class _NotSignInState extends State<NotSignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Text("عليك تسجيل الدخول لمشاهدة قائمتك",
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromRGBO(283, 239, 243, 1)
                  ),
              ),
              onPressed: (){},
              child: Text("تسجيل الدخول",
              style: TextStyle(color: Theme.of(context).buttonColor),)),
        )
      ],),),
    );
  }
}
