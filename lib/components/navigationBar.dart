import 'package:flutter/material.dart';

class MyAppNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const MyAppNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.blue),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people, color: Colors.blue),
          label: 'Atletas',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.sports_tennis, color: Colors.blue),
          label: 'Torneio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.emoji_events, color: Colors.blue),
          label: 'Liga',
        ),
      ],
    );
  }
}
