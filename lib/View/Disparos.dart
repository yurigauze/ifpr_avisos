import 'package:flutter/material.dart';
import 'package:ifpr_avisos/View/Widgets/DrawerADM.dart';

class Disparos extends StatelessWidget {
  const Disparos({super.key});

  Widget criarContainer() {
    return Card(
      child: Container(
        alignment: Alignment.center,
        width: 170,
        height: 170,
        color: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text("Disparar Avisos")),
      drawer: DrawerGlobal().criarDrawer(context),
      body: Container(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                color: colorScheme.inversePrimary,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/disparoTodos');
                  },
                  child: Container(
                    width: 170,
                    height: 170,
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.groups_outlined,
                            size: 50.0,
                          ),
                          Text(
                            'Disparar para todos',
                            style: TextStyle(
                              fontSize:
                                  15, // Definindo o tamanho da fonte para 20
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                color: colorScheme.inversePrimary,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/dispararTurma');
                  },
                  child: Container(
                    width: 170,
                    height: 170,
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.class_outlined, size: 50.0),
                          Text(
                            'Disparar para turma',
                            style: TextStyle(
                              fontSize:
                                  15, // Definindo o tamanho da fonte para 20
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                color: colorScheme.inversePrimary,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/dispararAluno');
                  },
                  child: Container(
                    width: 170,
                    height: 170,
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.people_outline, size: 50.0),
                          Text(
                            'Disparar para alunos',
                            style: TextStyle(
                              fontSize:
                                  15, // Definindo o tamanho da fonte para 20
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                color: colorScheme.inversePrimary,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/dispararTurno');
                  },
                  child: Container(
                    width: 170,
                    height: 170,
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.timelapse_outlined, size: 50.0),
                          Text(
                            'Disparar para turnos',
                            style: TextStyle(
                              fontSize:
                                  15, // Definindo o tamanho da fonte para 20
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
