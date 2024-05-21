import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AdicionarTorneio extends StatefulWidget {
  final String? torneioId;
  final Map<String, dynamic>? torneioData;

  AdicionarTorneio({this.torneioId, this.torneioData});

  @override
  _AdicionarTorneioState createState() => _AdicionarTorneioState();
}

class _AdicionarTorneioState extends State<AdicionarTorneio> {
  final _formKey = GlobalKey<FormState>();
  late String _nome;
  File? _imagem;
  String? _imagemUrl;

  @override
  void initState() {
    super.initState();
    _nome = widget.torneioData?['nome'] ?? '';
    _imagemUrl = widget.torneioData?['imagemUrl'];
  }

  Future<void> _selecionarImagem() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imagem = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImagem() async {
    if (_imagem == null) return;

    final storageReference = FirebaseStorage.instance.ref().child('torneios/${DateTime.now().millisecondsSinceEpoch}');
    final uploadTask = storageReference.putFile(_imagem!);
    final taskSnapshot = await uploadTask;
    _imagemUrl = await taskSnapshot.ref.getDownloadURL();
  }

  Future<void> _salvarTorneio() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_imagem != null) {
        await _uploadImagem();
      }

      final data = {
        'nome': _nome,
        'imagemUrl': _imagemUrl,
      };

      if (widget.torneioId == null) {
        await FirebaseFirestore.instance.collection('torneios').add(data);
      } else {
        await FirebaseFirestore.instance.collection('torneios').doc(widget.torneioId).update(data);
      }

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Torneio salvo com sucesso')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.torneioId == null ? 'Adicionar Torneio' : 'Editar Torneio'),
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
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _selecionarImagem,
                child: Text('Selecionar Imagem'),
              ),
              if (_imagem != null) Image.file(_imagem!, height: 200),
              if (_imagemUrl != null) Image.network(_imagemUrl!, height: 200),
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
