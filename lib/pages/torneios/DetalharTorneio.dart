import 'package:flutter/material.dart';
import 'package:tornamenttabletennis/pages/torneios/AdicionarTorneio.dart';
import 'package:tornamenttabletennis/pages/torneios/RealizarTorneio.dart';


class DetalhesTorneio extends StatelessWidget {
  final String torneioId;
  final Map<String, dynamic> torneioData;

  DetalhesTorneio({required this.torneioId, required this.torneioData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(torneioData['nome'] ?? 'Detalhes do Torneio'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (torneioData['imagemUrl'] != null)
              Image.network(torneioData['imagemUrl'], height: 200),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navegar para a tela de histórico (a ser implementada)
              },
              child: Text('Visualizar Histórico'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RealizarTorneio(torneioId: torneioId),
                  ),
                );
              },
              child: Text('Realizar Torneio'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdicionarTorneio(
                      torneioId: torneioId,
                      torneioData: torneioData,
                    ),
                  ),
                );
              },
              child: Text('Atualizar Informações'),
            ),
          ],
        ),
      ),
    );
  }
}
