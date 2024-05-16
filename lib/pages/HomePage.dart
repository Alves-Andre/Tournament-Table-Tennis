import 'package:flutter/material.dart';
import 'package:tornamenttabletennis/components/navigationBar.dart';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
  setState(() {
    _selectedIndex = index;
  });
  if (index == 0) {
      Navigator.pushNamed(context, '/'); // Navegar para a tela inicial
    } else if (index == 1) {
      Navigator.pushNamed(context, '/atletas'); // Navegar para a tela de atletas
    }
    else if (index == 2) {
      Navigator.pushNamed(context, '/torneio'); // Navegar para a tela de torneio
    } else if (index == 3) {
      Navigator.pushNamed(context, '/liga'); // Navegar para a tela de liga
    }
}
  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      // Tela de boas-vindas
      Center(
        child: Text(
          'Bem-vindo ao seu app! Home Page2',
          style: TextStyle(fontSize: 24),
        ),
      ),
      Container(
        child: Center(child: Text('Tela de Atletas')), // Tela temporária para Atletas
      ),
      Container(
        child: Center(child: Text('Tela de Torneio')), // Tela temporária para Torneio
      ),
      Container(
        child: Center(child: Text('Tela de Liga')), // Tela temporária para Liga
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Seu App'),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: MyAppNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}