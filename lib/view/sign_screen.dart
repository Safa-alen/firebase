import 'package:firebase/view/wedget/text_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignScreen extends StatefulWidget {
  const SignScreen({super.key});

  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool isLoading = false;



  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 219, 225, 244),
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: SafeArea(
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
                          final user = await _auth.signInWithEmailAndPassword(
                            //لازم كون بعرف كلمة السر
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          );
                          setState(() {
                            isLoading = false;
                          });

                          Navigator.of(context).pushNamed("chat_screen");
                        } catch (e) {
                          setState(() {
                            isLoading = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text("فشل تسجيل الدخول: ${e.toString()}")),
                          );

                          print("فشل تسجيل الدخول: ${e.toString()}");
                        }
                      },
                      child: Center(child: Text("Sign In")),
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
