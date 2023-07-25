import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Importe o pacote flutter_svg

class Introducao extends StatelessWidget {
  const Introducao({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 1), () {
      Navigator.pushNamed(context, '/login');
    });

    // Define o caminho para o arquivo SVG baseado no tema

    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/ifpr-logo-light.png'),
              // Utilize o SvgPicture.asset para exibir o arquivo SVG

              const Text(
                'Guia de Campus',
                style: TextStyle(
                  fontSize: 35,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
