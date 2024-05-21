import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tornamenttabletennis/pages/torneios/AdicionarTorneio.dart';
import 'package:tornamenttabletennis/components/navigationBar.dart';
import 'package:tornamenttabletennis/pages/torneios/DetalharTorneio.dart';

class TorneiosListagem extends StatefulWidget {
  @override
  _TorneiosListagemState createState() => _TorneiosListagemState();
}

class _TorneiosListagemState extends State<TorneiosListagem> {
  final CollectionReference _torneiosCollection = FirebaseFirestore.instance.collection('torneios');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Torneios'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AdicionarTorneio()));
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _torneiosCollection.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Nenhum torneio cadastrado'));
          }

          final List<DocumentSnapshot> documents = snapshot.data!.docs;

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final Map<String, dynamic> data = documents[index].data() as Map<String, dynamic>;

              return ListTile(
                title: Text(data['nome'] ?? ''),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetalhesTorneio(
                        torneioId: documents[index].id,
                        torneioData: data,
                      ),
                    ),
                  );
                },
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

