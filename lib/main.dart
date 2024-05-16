import 'package:flutter/material.dart';
import 'package:tornamenttabletennis/pages/HomePage.dart';
import 'package:tornamenttabletennis/pages/atletas/atleta.dart';
import 'package:tornamenttabletennis/components/navigationBar.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  print('Firebase inicializado com sucesso!');
  runApp(MyApp()); // Inicie o aplicativo com o MyApp
}

class MyApp extends StatelessWidget {

  @override
  
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seu App2',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => MyHomePage(),
        '/atletas': (context) => AtletasPage(),
        '/torneio':(context) => MyHomePage(),
        '/liga':(context) => MyHomePage(), // Adiciona a rota para a tela de atletas
      },
    );
  }
}
