import 'package:flutter/material.dart';
import 'package:tornamenttabletennis/pages/atletas/editAtleta.dart';
import '../../controller/classes.dart';
import '../../services/atletaService.dart'; // Importe o AtletaService

class AtletasPage extends StatefulWidget {
  @override
  _AtletasPageState createState() => _AtletasPageState();
}

class _AtletasPageState extends State<AtletasPage> {
  final AtletaService _atletaService = AtletaService(); // Instância do AtletaService
  List<Atleta> _atletas = []; // Lista de atletas

  @override
  void initState() {
    super.initState();
    _carregarAtletas(); // Carregar os atletas ao iniciar a tela
  }

  Future<void> _carregarAtletas() async {
    List<Atleta> atletas = await _atletaService.getAtletas();
    setState(() {
      _atletas = atletas;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Atletas'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AtletaEditScreen()),
              );
            },
          ),
        ],
      ),
      body: _atletas.isEmpty
          ? Center(
              child: Text('Nenhum atleta cadastrado'),
            )
          : ListView.builder(
              itemCount: _atletas.length,
              itemBuilder: (context, index) {
                final atleta = _atletas[index];
                return ListTile(
                  title: Text(atleta.nome),
                  subtitle: Text(atleta.universidade),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AtletaEditScreen(atleta: atleta),
                      ),
                    );
                  },
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _excluirAtleta(context, atleta);
                    },
                  ),
                );
              },
            ),
    );
  }

  void _excluirAtleta(BuildContext context, Atleta atleta) {
    // Implemente a lógica para excluir o atleta do Firestore aqui
  }
}