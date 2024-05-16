import 'package:flutter/material.dart';
import 'package:tornamenttabletennis/controller/classes.dart';
import 'package:tornamenttabletennis/pages/atletas/atleta.dart';
import 'package:tornamenttabletennis/services/atletaService.dart';

class AtletaEditScreen extends StatefulWidget {
  final Atleta? atleta;

  AtletaEditScreen({Key? key, this.atleta}) : super(key: key);

  @override
  _AtletaEditScreenState createState() => _AtletaEditScreenState();
}

class _AtletaEditScreenState extends State<AtletaEditScreen> {
  late TextEditingController _nomeController;
  late TextEditingController _universidadeController;
  late TextEditingController _raqueteController;
  late TextEditingController _borrachaForehandController;
  late TextEditingController _borrachaBackhandController;
  
  AtletaService atletaService = AtletaService();

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.atleta?.nome ?? '');
    _universidadeController =
        TextEditingController(text: widget.atleta?.universidade ?? '');
    _raqueteController =
        TextEditingController(text: widget.atleta?.raquete ?? '');
    _borrachaForehandController =
        TextEditingController(text: widget.atleta?.borrachaForehand ?? '');
    _borrachaBackhandController =
        TextEditingController(text: widget.atleta?.borrachaBackhand ?? '');
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _universidadeController.dispose();
    _raqueteController.dispose();
    _borrachaForehandController.dispose();
    _borrachaBackhandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.atleta == null ? 'Adicionar Atleta' : 'Editar Atleta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _universidadeController,
              decoration: InputDecoration(labelText: 'Universidade'),
            ),
            TextField(
              controller: _raqueteController,
              decoration: InputDecoration(labelText: 'Raquete'),
            ),
            TextField(
              controller: _borrachaForehandController,
              decoration: InputDecoration(labelText: 'Borracha Forehand'),
            ),
            TextField(
              controller: _borrachaBackhandController,
              decoration: InputDecoration(labelText: 'Borracha Backhand'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await atletaService.adicionarAtleta(
                  nome: _nomeController.text,
                  universidade: _universidadeController.text,
                  raquete: _raqueteController.text,
                  borrachaForhand: _borrachaForehandController.text,
                  borrachaBackhand: _borrachaBackhandController.text,
                );
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
