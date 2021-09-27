// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout/utilities/measure_icons.dart';
import 'package:workout/utilities/toast.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: const [
            Color(0xFFF77723),
            Color(0xFFF7A456),
            Color(0xFFF7BE8A),
            Color(0xFFF5EEE9),
          ],
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: ListView(
          children: [
            SizedBox(height: 50),
            buildMenuItem('Treinos antigos', Icons.fitness_center,()=>null),
             SizedBox(height: 10),
            buildMenuItem('Medições', Measure.ruler,()=>null),
             Container(alignment: Alignment.bottomCenter,child: Text('ola'),)
          ],
        ),
      ),
    ));
  }

  Widget buildMenuItem(String text, IconData icon, VoidCallback? onClicked) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          shadows: <Shadow>[
            Shadow(
              //offset: Offset(10.0, 10.0),
              blurRadius: 20.0,
              color: Colors.black,
            ),
          ],
        ),
      ),
      onTap: onClicked
    );
  }
}
