import 'package:flutter/material.dart';
import 'package:todo_list_sqlite/helpers/drawer_navigation.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos'),
      ),
      drawer: DrawerNavigation(),
    );
  }
}
