// import 'package:firebase/view/home_screen.dart';
// import 'package:firebase/view/login_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class AuthGate extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//       stream:
//           FirebaseAuth.instance.authStateChanges(), //اسمع التغييرات على فايربيس
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           //هذا يعني: هل يوجد مستخدم حالي مسجل دخوله
//           return HomeScreen(); //عامل تسجيل دخول
//         }
//         return LogInScreen();
//       },
//     );
//   }
// }
