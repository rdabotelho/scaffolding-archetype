import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:${context.projectName.toLowerCase()}/config/base_config.dart';

class MainMenu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: getMenu(context)
    );
  }

}