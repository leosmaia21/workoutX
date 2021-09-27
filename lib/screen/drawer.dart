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
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
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
              child: ConstrainedBox(
                constraints: constraints.copyWith(
                  minHeight: constraints.maxHeight,
                  maxHeight: double.infinity,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: IntrinsicHeight(
                    child: SafeArea(
                      child: Column(
                        children: [
                          Column(
                            children: <Widget>[
                              SizedBox(
                                height: 50,
                              ),
                              buildMenuItem("text", Icons.fitness_center, () {
                                null;
                              }),
                            ],
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [Text('ola'),Text('hola'),]
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
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
        onTap: onClicked);
  }
}
