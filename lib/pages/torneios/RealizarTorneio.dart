import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RealizarTorneio extends StatefulWidget {
  final String torneioId;

  RealizarTorneio({required this.torneioId});

  @override
  _RealizarTorneioState createState() => _RealizarTorneioState();
}

class _RealizarTorneioState extends State<RealizarTorneio> {
  int _quantidadeAtletas = 2;
  List<String> _atletasSelecionados = [];
  final CollectionReference _atletasCollection = FirebaseFirestore.instance.collection('atletas');

  Future<void> _realizarTorneio() async {
    if (_atletasSelecionados.length != _quantidadeAtletas) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Selecione exatamente $_quantidadeAtletas atletas')));
      return;
    }

    // Salvar os dados do torneio realizado (por exemplo, participantes)
    await FirebaseFirestore.instance.collection('torneios').doc(widget.torneioId).collection('partidas').add({
      'atletas': _atletasSelecionados,
      'data': DateTime.now(),
    });

    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Torneio iniciado com sucesso')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Realizar Torneio'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<int>(
              value: _quantidadeAtletas,
              onChanged: (value) {
                setState(() {
                  _quantidadeAtletas = value!;
                  _atletasSelecionados.clear();
                });
              },
              items: [2, 4, 8, 16].map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text('$value Atletas'),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Quantidade de Atletas',
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _atletasCollection.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('Nenhum atleta cadastrado'));
                  }

                  final List<DocumentSnapshot> documents = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      final Map<String, dynamic> data = documents[index].data() as Map<String, dynamic>;
                      final String atletaId = documents[index].id;
                      final String atletaNome = data['nome'] ?? '';

                      return CheckboxListTile(
                        title: Text(atletaNome),
                        value: _atletasSelecionados.contains(atletaId),
                        onChanged: (bool? selected) {
                          setState(() {
                            if (selected == true) {
                              if (_atletasSelecionados.length < _quantidadeAtletas) {
                                _atletasSelecionados.add(atletaId);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Número máximo de atletas selecionado')));
                              }
                            } else {
                              _atletasSelecionados.remove(atletaId);
                            }
                          });
                        },
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _realizarTorneio,
              child: Text('Iniciar Torneio'),
            ),
          ],
        ),
      ),
    );
  }
}
