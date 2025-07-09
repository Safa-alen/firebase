import 'package:firebase/view/auth.dart';
import 'package:firebase/view/chat_screen.dart';
import 'package:firebase/view/register_screen.dart';
import 'package:firebase/view/sign_screen.dart';
import 'package:firebase/view/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: FirebaseOptions(
      //     apiKey: "AIzaSyAa8UpVYutktDByrs2nskjswWQ1bGzt1EA",
      //     appId: "1:834322050540:android:9845790a058dee2e1524c9",
      //     messagingSenderId: "834322050540",
      //     projectId: "fir-d4ea9")
      );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //  theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: WelcomeScreen(),
      initialRoute:
          _auth.currentUser != null ? "chat_screen" : "welcome_screen",
      routes: {
        "chat_screen": (context) => ChatScreen(),
        "sign_screen": (context) => SignScreen(),
        "welcome_screen": (context) => WelcomeScreen(),
        "register_screen": (context) => RegisterScreen()
      },
    );
  }
}
