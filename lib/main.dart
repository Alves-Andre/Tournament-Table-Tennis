import 'package:flutter/material.dart';
import 'package:tornamenttabletennis/firebase_options.dart';
import 'package:tornamenttabletennis/pages/HomePage.dart';
import 'package:tornamenttabletennis/pages/atletas/atleta.dart';
import 'package:tornamenttabletennis/components/navigationBar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tornamenttabletennis/pages/atletas/editAtleta.dart';
import 'package:tornamenttabletennis/pages/torneios/torneio.dart';
import 'package:tornamenttabletennis/pages/torneios/AdicionarTorneio.dart';
import 'package:tornamenttabletennis/pages/torneios/EditarTorneio.dart';
import 'package:tornamenttabletennis/pages/torneios/DetalharTorneio.dart';
import 'package:tornamenttabletennis/pages/torneios/RealizarTorneio.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seu App2',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        // Verificar a rota solicitada e os argumentos passados
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) => MyHomePage());
          case '/atletas':
            return MaterialPageRoute(builder: (context) => AtletasPage());
          case '/atletas/edit':
            return MaterialPageRoute(builder: (context) => AtletaEditScreen());
          case '/liga':
            return MaterialPageRoute(builder: (context) => MyHomePage());
          case '/torneio':
            return MaterialPageRoute(builder: (context) => TorneiosListagem());
          case '/torneio/new':
            return MaterialPageRoute(builder: (context) => AdicionarTorneio());
          case '/torneio/edit':
            // Verificar se os argumentos são fornecidos
            final args = settings.arguments as Map<String, dynamic>?;
            if (args != null) {
              return MaterialPageRoute(
                builder: (context) => EditarTorneio(torneioId: args['torneioId'], torneioData: args['torneioData']),
              );
            }
            return _erroDeRota();
          case '/torneio/detalhes':
            // Verificar se os argumentos são fornecidos
            final args = settings.arguments as Map<String, dynamic>?;
            if (args != null) {
              return MaterialPageRoute(
                builder: (context) => DetalhesTorneio(torneioId: args['torneioId'], torneioData: args['torneioData']),
              );
            }
            return _erroDeRota();
          case '/torneio/realizar':
            // Verificar se os argumentos são fornecidos
            final args = settings.arguments as Map<String, dynamic>?;
            if (args != null) {
              return MaterialPageRoute(
                builder: (context) => RealizarTorneio(torneioId: args['torneioId']),
              );
            }
            return _erroDeRota();
          default:
            return _erroDeRota();
        }
      },
    );
  }
  MaterialPageRoute _erroDeRota() {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Erro'),
        ),
        body: Center(
          child: Text('Rota não encontrada!'),
        ),
      );
    });
  }
}

