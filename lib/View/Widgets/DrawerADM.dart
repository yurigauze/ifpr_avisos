import 'package:flutter/material.dart';

class DrawerGlobal {
  Widget criarDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const UserAccountsDrawerHeader(
            accountName: Text('Usuario'),
            accountEmail: Text('RA Usuario'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://miro.medium.com/v2/resize:fit:1400/1*g09N-jl7JtVjVZGcd-vL2g.jpeg'),
            ),
          ),
          ListTile(
              leading: const Icon(Icons.account_circle_outlined),
              title: const Text('Perfil'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/perfil');
              }),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                  context, '/home', (route) => false);
            },
          ),
          ListTile(
            leading: const Icon(Icons.people_outline_rounded),
            title: const Text('Alunos'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/alunosList');
            },
          ),
          ListTile(
            leading: const Icon(Icons.school_outlined),
            title: const Text('Professores'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/professorList');
            },
          ),
          ListTile(
            leading: const Icon(Icons.timelapse),
            title: const Text('Turnos'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/turnoList');
            },
          ),
          ListTile(
            leading: const Icon(Icons.class_outlined),
            title: const Text('Turmas'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/turmaLista');
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications_outlined),
            title: const Text('Avisos'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '');
            },
          ),
        ],
      ),
    );
  }
}
