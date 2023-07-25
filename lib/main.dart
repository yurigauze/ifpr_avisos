import 'package:flutter/material.dart';
import 'package:ifpr_avisos/Controles/Notifications/Custom_firebase_messager.dart';
import 'package:ifpr_avisos/Login.dart';
import 'package:ifpr_avisos/View/Formas%20e%20Lista/AlunoForm.dart';
import 'package:ifpr_avisos/View/Formas%20e%20Lista/Aluno_por_turma.dart';
import 'package:ifpr_avisos/View/Formas%20e%20Lista/AlunosList.dart';
import 'package:ifpr_avisos/View/Formas%20e%20Lista/Turma_por_Turno.dart';
import 'package:ifpr_avisos/View/Formas%20e%20Lista/ProfessorForm.dart';
import 'package:ifpr_avisos/View/Formas%20e%20Lista/ProfessorList.dart';
import 'package:ifpr_avisos/View/Formas%20e%20Lista/TurmaForm.dart';
import 'package:ifpr_avisos/View/Formas%20e%20Lista/TurmaList.dart';
import 'package:ifpr_avisos/View/Formas%20e%20Lista/TurnoForm.dart';
import 'package:ifpr_avisos/View/Formas%20e%20Lista/TurnoLista.dart';
import 'package:ifpr_avisos/View/Home.dart';
import 'package:ifpr_avisos/introducao.dart';
import 'color_schemes.g.dart';
import 'package:firebase_core/firebase_core.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await CustomFirebaseMessaging().inicialize();
  await CustomFirebaseMessaging().getTokenFirebase();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      routes: {
        '/': (context) => Introducao(),
        '/login': (context) => Login(),
        '/home': (context) => Home(),
        '/alunosList': (context) => AlunosLista(),
        '/alunoForm': (context) => AlunoForm(),
        '/turnoList': (context) => TurnosLista(),
        '/turnoForm': (context) => TurnoForm(),
        '/professorList': (context) => ProfessorLista(),
        '/professorForm': (context) => ProfessorForm(),
        '/turmaLista': (context) => TurmaLista(),
        '/turmaForm': (context) => TurmaForm(),
        '/turmasPorTurno': (context) => TurmasPorTurno(),
        '/alunosPorTurma': (context) => AlunoPorTurma(),
      },
    );
  }
}
