import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suhaib/home_chat/home_chat_logic/home_chat_api.dart';
import 'package:suhaib/states/chat_state.dart';
import 'package:suhaib/ui/bottom_n_b.dart';

import 'Auth/auth_logic/auth_api_REMOTE_1630.dart';
import 'Auth/auth_ui/login.dart';
import 'home_chat/home_chat_logic/upload_file_logic.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthApi>(
          create: (BuildContext context) => AuthApi(),
        ),
        BlocProvider<DataApi>(
          create: (BuildContext context) => DataApi(),
        ),
        BlocProvider<UploadFileLogic>(
          create: (BuildContext context) => UploadFileLogic(),
        ),
      ],
      child:
      MyApp(),
    )
  );
}

class MyApp extends StatefulWidget {
  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();

  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const CircularProgressIndicator();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return MediaQuery(
                data: const MediaQueryData(),
                child: MaterialApp(
                  initialRoute: '/',
                  title: 'Friends',
                  theme: ThemeData(
                      buttonColor: Color.fromRGBO(56, 59, 110, 1),
                      backgroundColor: Colors.teal,
                      primaryColor: Colors.amber,
                      colorScheme: ColorScheme.fromSwatch()
                          .copyWith(secondary: Colors.white)),
                  home:
                  BlocConsumer<AuthApi, ChangeChatState>(
                    listener: (context, state) {
                      print(state);
                    },
                    builder: (context, state) {
                      print(state);
                      print(" bloc Consumer works");
                      return
                        FirebaseAuth.instance.currentUser != null
                            ? HomeApp()
                            : LogIn();
                    },
                  ),
                ));
            // }

            // Otherwise, show something whilst waiting for initialization to complete
            // return const SizedBox();
            // },
            // );
          }
          return Container( width: 5, height: 5,
            child: CircularProgressIndicator(),);
        });
  }
}