import 'package:firebase/view/wedget/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
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
                textField(
                  // val: emailController.text,
                  controller: emailController,
                  hint: 'Email',
                  keyboardType: TextInputType.emailAddress,
                ),
                textField(
                  //  val: passwordController.text,
                  controller: passwordController,
                  hint: "Password",
                  obscureText: true,
                  keyboardType: TextInputType.numberWithOptions(),
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
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                        });

                        try {
                          final user =
                              await _auth.createUserWithEmailAndPassword(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          );

                          Navigator.of(context).pushNamed("homescreen");
                          setState(() {
                            isLoading = false;
                          });
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: Center(child: Text("Register")),
                    ),
                  ),
                )
              ],
            ),
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
