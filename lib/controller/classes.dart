import 'package:flutter/material.dart';


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
  String universidade;
  String raquete;
  String borrachaForehand;
  String borrachaBackhand;

  Atleta({
    required this.nome,
    required this.universidade,
    required this.raquete,
    required this.borrachaForehand,
    required this.borrachaBackhand,
  });
}

class Torneio{ 
  
}