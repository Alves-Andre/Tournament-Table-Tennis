import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../controller/classes.dart';

class AtletaEditScreen extends StatefulWidget {
  final Atleta? atleta;
  final String? atletaId;
  final Function(String)? onSaved;

  AtletaEditScreen({this.atleta, this.atletaId, this.onSaved});

  @override
  _AtletaEditScreenState createState() => _AtletaEditScreenState();
}

class _AtletaEditScreenState extends State<AtletaEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _nome;
  late String _universidade;
  late String _raquete;
  late String _borrachaForehand;
  late String _borrachaBackhand;

  @override
  void initState() {
    super.initState();
    _nome = widget.atleta?.nome ?? '';
    _universidade = widget.atleta?.universidade ?? '';
    _raquete = widget.atleta?.raquete ?? '';
    _borrachaForehand = widget.atleta?.borrachaForehand ?? '';
    _borrachaBackhand = widget.atleta?.borrachaBackhand ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.atleta == null ? 'Adicionar Atleta' : 'Editar Atleta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _nome,
                decoration: InputDecoration(labelText: 'Nome'),
                onSaved: (value) => _nome = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _universidade,
                decoration: InputDecoration(labelText: 'Universidade'),
                onSaved: (value) => _universidade = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a universidade';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _raquete,
                decoration: InputDecoration(labelText: 'Raquete'),
                onSaved: (value) => _raquete = value!,
              ),
              TextFormField(
                initialValue: _borrachaForehand,
                decoration: InputDecoration(labelText: 'Borracha Forehand'),
                onSaved: (value) => _borrachaForehand = value!,
              ),
              TextFormField(
                initialValue: _borrachaBackhand,
                decoration: InputDecoration(labelText: 'Borracha Backhand'),
                onSaved: (value) => _borrachaBackhand = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _salvarAtleta,
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _salvarAtleta() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final atleta = Atleta(
        nome: _nome,
        universidade: _universidade,
        raquete: _raquete,
        borrachaForehand: _borrachaForehand,
        borrachaBackhand: _borrachaBackhand,
      );

      if (widget.atletaId == null) {
        // Adicionar novo atleta
        await FirebaseFirestore.instance.collection('atletas').add({
          'nome': atleta.nome,
          'universidade': atleta.universidade,
          'raquete': atleta.raquete,
          'borrachaForehand': atleta.borrachaForehand,
          'borrachaBackhand': atleta.borrachaBackhand,
        });
        widget.onSaved?.call('Atleta adicionado com sucesso');
      } else {
        // Atualizar atleta existente
        await FirebaseFirestore.instance
            .collection('atletas')
            .doc(widget.atletaId)
            .update({
          'nome': atleta.nome,
          'universidade': atleta.universidade,
          'raquete': atleta.raquete,
          'borrachaForehand': atleta.borrachaForehand,
          'borrachaBackhand': atleta.borrachaBackhand,
        });
        widget.onSaved?.call('Atleta atualizado com sucesso');
      }

      // Exibir pop-up e navegar de volta para a lista de atletas
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Sucesso'),
            content: Text(widget.atletaId == null
                ? 'Atleta adicionado com sucesso'
                : 'Atleta atualizado com sucesso'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Fechar o diálogo
                  Navigator.of(context).pop(); // Voltar para a tela anterior
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
