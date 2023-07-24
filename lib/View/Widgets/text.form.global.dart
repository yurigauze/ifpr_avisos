import 'package:flutter/material.dart';
import 'package:ifpr_avisos/color_schemes.g.dart';

class TextFormGlobal extends StatelessWidget {
  const TextFormGlobal(
      {Key? key,
      required this.controller,
      required this.text,
      required this.textInputType,
      required this.obscure})
      : super(key: key);

  final TextEditingController controller;
  final String text;
  final TextInputType textInputType;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: const EdgeInsets.only(top: 3, left: 15),
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType,
        obscureText: obscure,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(0),
            labelText: text,
            hintStyle: const TextStyle(
              height: 1,
            )),
      ),
    );
  }
}
