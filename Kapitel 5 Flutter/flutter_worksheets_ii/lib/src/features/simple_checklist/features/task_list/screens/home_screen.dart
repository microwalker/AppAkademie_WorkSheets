import 'package:flutter/material.dart';
import 'package:flutter_worksheets_ii/src/data/checklist_repositories/shared_preferences_repository.dart';

import '../../../../../data/checklist_repositories/database_repository.dart';
import '../../statistics/screens/statistics_screen.dart';
import 'list_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  final DatabaseRepository repository = SharedPreferencesRepository();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedNavBarIndex = 0;
  List<Widget> _navBarWidgets = [];

  @override
  void initState() {
    super.initState();
    _navBarWidgets = [
      ListScreen(repository: widget.repository),
      StatisticsScreen(repository: widget.repository),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _navBarWidgets[_selectedNavBarIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Aufgaben',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Statistik',
          ),
        ],
        currentIndex: _selectedNavBarIndex,
        selectedItemColor: Colors.deepPurple[200],
        onTap: (int index) {
          setState(() {
            _selectedNavBarIndex = index;
          });
        },
      ),
    );
  }
}
