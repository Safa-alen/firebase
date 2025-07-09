import 'package:flutter/material.dart';

import 'wedget/buttom.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/download.png"),
                Text(
                  "MessageMe",
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 15,
                ),
                Buttom(
                    text: "Sign in",
                    color: Colors.orange,
                    onPressed: () {
                      Navigator.of(context).pushNamed("sign_screen");
                    }),
                SizedBox(
                  height: 20,
                ),
                Buttom(
                  text: "register",
                  color: Colors.blueAccent,
                  onPressed: () {
                    Navigator.of(context).pushNamed("register_screen");
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
