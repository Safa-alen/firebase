import 'package:firebase/view/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      //options: FirebaseOptions(
      //  apiKey: "AIzaSyAa8UpVYutktDByrs2nskjswWQ1bGzt1EA",
      //appId: "1:834322050540:android:9845790a058dee2e1524c9",
      //messagingSenderId: "834322050540",
      //projectId: "fir-d4ea9")
      );
  //await FcmApi().initNotifacation(); //هي مشان الاشعارات
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'تعلم API',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthGate(),
    );
  }
}
