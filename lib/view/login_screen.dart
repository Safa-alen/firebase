import 'package:firebase/view/wedget/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  @override
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Future<void> signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 219, 225, 244),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/image.webp",
                width: 188,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "SIGN In",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Text(
                "Welcome back Nice to see you again",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              textField(
                controller: emailController,
                hint: 'Email',
              ),
              textField(
                controller: passwordController,
                hint: "Password",
                obscureText: true,
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(19)),
                  child: GestureDetector(
                    onTap: signIn,
                    child: Center(child: Text("Sign In")),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


// الباكيج              | الاستخدام                                     |
 //-------------------- | --------------------------------------------- |
 //`firebase_core`      | تهيئة وبدء الاتصال بـ Firebase (مطلوب دائمًا) |
 //`firebase_auth`      | تسجيل الدخول، الخروج، إنشاء حسابات            |
 //`firebase_messaging` | استقبال وإرسال إشعارات Push                   |
