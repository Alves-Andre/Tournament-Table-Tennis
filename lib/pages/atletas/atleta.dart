import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tornamenttabletennis/pages/atletas/editAtleta.dart';
import '../../controller/classes.dart';
import '../../components/navigationBar.dart';

class AtletasPage extends StatefulWidget {
  @override
  _AtletasPageState createState() => _AtletasPageState();
}

class _AtletasPageState extends State<AtletasPage> {
  final CollectionReference _atletasCollection =
      FirebaseFirestore.instance.collection('atletas');

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
                MaterialPageRoute(
                  builder: (context) => AtletaEditScreen(
                    onSaved: (String message) {
                      _showPopup(context, message);
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _atletasCollection.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
              final Map<String, dynamic> data =
                  documents[index].data() as Map<String, dynamic>;

              final atleta = Atleta(
                nome: data['nome'] ?? '',
                universidade: data['universidade'] ?? '',
                raquete: data['raquete'] ?? '',
                borrachaForehand: data['borrachaForehand'] ?? '',
                borrachaBackhand: data['borrachaBackhand'] ?? '',
              );

              return ListTile(
                title: Text(atleta.nome),
                subtitle: Text(atleta.universidade),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AtletaEditScreen(
                        atleta: atleta,
                        atletaId: documents[index].id,
                        onSaved: (String message) {
                          _showPopup(context, message);
                        },
                      ),
                    ),
                  );
                },
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AtletaEditScreen(
                              atleta: atleta,
                              atletaId: documents[index].id,
                              onSaved: (String message) {
                                _showPopup(context, message);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _excluirAtleta(documents[index].id);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: MyAppNavigationBar(
        currentIndex: 1,
        onTap: _onItemTapped,
      ),
    );
  }

  void _excluirAtleta(String atletaId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Excluir Atleta'),
          content: Text('Tem certeza que deseja excluir este atleta?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fechar o diálogo
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Fechar o diálogo antes da exclusão
                await FirebaseFirestore.instance
                    .collection('atletas')
                    .doc(atletaId)
                    .delete();
                _showPopup(context, 'Atleta excluído com sucesso');
              },
              child: Text('Excluir'),
            ),
          ],
        );
      },
    );
  }

  void _showPopup(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fechar o diálogo
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    ).then((_) {
      Navigator.popUntil(context, ModalRoute.withName('/atletas'));
    });
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushNamed(context, '/'); // Navegar para a tela inicial
    } else if (index == 2) {
      Navigator.pushNamed(context, '/torneio'); // Navegar para a tela de torneio
    } else if (index == 3) {
      Navigator.pushNamed(context, '/liga'); // Navegar para a tela de liga
    }
  }
}
