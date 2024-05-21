import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditarTorneio extends StatefulWidget {
  final String torneioId;
  final Map<String, dynamic> torneioData;

  EditarTorneio({required this.torneioId, required this.torneioData});

  @override
  _EditarTorneioState createState() => _EditarTorneioState();
}

class _EditarTorneioState extends State<EditarTorneio> {
  final _formKey = GlobalKey<FormState>();
  late String _nome;
  late String _data;
  late String _localizacao;

  @override
  void initState() {
    super.initState();
    _nome = widget.torneioData['nome'] ?? '';
    _data = widget.torneioData['data'] ?? '';
    _localizacao = widget.torneioData['localizacao'] ?? '';
  }

  Future<void> _salvarTorneio() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      await FirebaseFirestore.instance.collection('torneios').doc(widget.torneioId).update({
        'nome': _nome,
        'data': _data,
        'localizacao': _localizacao,
      });

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Torneio atualizado com sucesso')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Torneio'),
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
                    return 'Por favor, insira o nome do torneio';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _data,
                decoration: InputDecoration(labelText: 'Data'),
                onSaved: (value) => _data = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a data do torneio';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _localizacao,
                decoration: InputDecoration(labelText: 'Localização'),
                onSaved: (value) => _localizacao = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a localização do torneio';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _salvarTorneio,
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
