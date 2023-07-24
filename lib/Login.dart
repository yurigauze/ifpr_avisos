import 'package:flutter/material.dart';
import 'package:ifpr_avisos/View/Widgets/text.form.global.dart';
import 'package:ifpr_avisos/color_schemes.g.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final TextEditingController cpf = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
          child: Container(
              color: Theme.of(context).dialogBackgroundColor,
              child: SafeArea(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 100),
                      Container(
                          alignment: Alignment.center,
                          child: Text(
                            'Guia de Campus',
                            style: Theme.of(context).textTheme.displayLarge,
                          )),
                      const SizedBox(height: 100),

                      /// Email input
                      TextFormGlobal(
                          controller: cpf,
                          text: 'CPF',
                          obscure: false,
                          textInputType: TextInputType.number),

                      const SizedBox(height: 20),

                      /// Senha input
                      TextFormGlobal(
                          controller: password,
                          text: 'Senha',
                          obscure: true,
                          textInputType: TextInputType.text),

                      const SizedBox(height: 20),

                      Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FilledButton(
                              style: ElevatedButton.styleFrom(),
                              child: Text(
                                ' Entrar ',
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, '/home');
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ))),
    ));
  }
}
