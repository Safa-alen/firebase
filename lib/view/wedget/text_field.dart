import 'package:flutter/material.dart';

class textField extends StatefulWidget {
  textField({
    super.key,
    required this.hint,
    this.obscureText = false,
    required this.controller,
  });
  final String hint;
  final bool obscureText;
  final TextEditingController controller;
  @override
  State<textField> createState() => _textFieldState(); //arwani@gmail.com
}

class _textFieldState extends State<textField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            controller: TextEditingController(),
            obscureText: widget.obscureText,
            decoration: InputDecoration(
                border: InputBorder.none, hintText: widget.hint),
          ),
        ),
      ),
    );
  }
}
