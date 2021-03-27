import 'package:flutter/material.dart';
import 'package:${context.projectName.toLowerCase()}/views/dashboard.dart';

void main() {
  runApp(${context.projectName.toPascalCase()}());
}

class ${context.projectName.toPascalCase()} extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.indigo[500],
          accentColor: Colors.blueAccent[900],
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.blueAccent[900],
            textTheme: ButtonTextTheme.primary,
          )
      ),
      home: Dashboard(),
    );
  }

}

