import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  final user = FirebaseAuth.instance.currentUser!;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Hello Your\'re Signed in",
              style: TextStyle(fontSize: 25),
            ),
            Text(
              user.email!,
              style: TextStyle(fontSize: 25),
            ),
            MaterialButton(
                color: Colors.amber,
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                })
          ],
        ),
      ),
    );
  }
}
