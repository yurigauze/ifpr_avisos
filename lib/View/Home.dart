import 'package:flutter/material.dart';
import 'package:ifpr_avisos/View/Widgets/DrawerADM.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Início'),
      ),
      drawer: DrawerGlobal().criarDrawer(context),
      body: Container(
        child: Column(),
      ),
    );
  }
}
