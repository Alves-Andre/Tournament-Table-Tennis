import 'package:cloud_firestore/cloud_firestore.dart';
import '../../controller/classes.dart';


class AtletaService {
  final CollectionReference atletasCollection =
      FirebaseFirestore.instance.collection('atletas');
  Future<List<Atleta>> getAtletas() async {
    try {
      QuerySnapshot querySnapshot = await atletasCollection.get();
      List<Atleta> atletas = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Atleta(
          nome: data['nome'],
          dataNascimento: data['dataNascimento'],
          universidade: data['universidade'],
          raquete: data['raquete'],
          borrachaForehand: data['borrachaForhand'],
          borrachaBackhand: data['borrachaBackhand'],
          // Adicione outros campos do atleta conforme necessário
        );
      }).toList();
      return atletas;
    } catch (e) {
      print('Erro ao buscar os atletas: $e');
      return [];
    }
  }

  Future<void> adicionarAtleta({
    required String nome,
    required String universidade,
    required String raquete,
    required String borrachaForhand,
    required String borrachaBackhand,
    // Adicione outros parâmetros do atleta conforme necessário
  }) async {
    try {
      await atletasCollection.add({
        'nome': nome,
        'universidade': universidade,
        'raquete': raquete,
        'borrachaForhand': borrachaForhand,
        'borrachaBackhand': borrachaBackhand,
        // Adicione outros campos do atleta aqui, conforme necessário
      });
      print('Atleta adicionado com sucesso ao Firestore!');
    } catch (e) {
      print('Erro ao adicionar o atleta: $e');
      // Trate o erro conforme necessário
    }
  }
}