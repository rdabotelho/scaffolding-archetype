import 'package:flutter/material.dart';
import 'package:${context.projectName.toLowerCase()}/views/menu.dart';

class Dashboard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: MainMenu()
    );
  }

}