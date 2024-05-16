import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(child: Text('Página inicial')),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_tennis),
            label: 'Torneio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: 'Liga',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Atletas',
          ),
        ],
      ),
    );
  }
}

class AtletasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Implemente a tela de visualização e gerenciamento de atletas aqui
    return Container();
  }
}

class TorneioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Implemente a tela de visualização e gerenciamento de torneios aqui
    return Container();
  }
}

class LigaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Implemente a tela de visualização e gerenciamento de ligas aqui
    return Container();
  }
}

class Atleta {
  String nome;
  DateTime dataNascimento;
  String universidade;
  String raquete;
  String borrachaForehand;
  String borrachaBackhand;

  Atleta({
    required this.nome,
    required this.dataNascimento,
    required this.universidade,
    required this.raquete,
    required this.borrachaForehand,
    required this.borrachaBackhand,
  });
}
