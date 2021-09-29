// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/src/provider.dart';
import 'package:workout/databasemanager/databasemanager.dart';
import 'package:workout/services/authservice.dart';
import 'package:workout/utilities/measure_icons.dart';
import 'package:workout/utilities/toast.dart';

import '../main.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var name = context.read<DatabaseManager>().getName();

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
                              header(name!),
                              // SizedBox(
                              //   height: 50,
                              // ),
                              buildMenuItem(
                                "Treinos antigos",
                                Icons.fitness_center,
                                () {
                                  null;
                                },
                              ),
                              buildMenuItem('Medições', Measure.ruler, () {
                                toast("funciona");
                              }),
                              buildMenuItem(
                                  'Peso', Icons.monitor_weight_outlined, () {
                                null;
                              }),
                              buildMenuItem(
                                "Fotografias",
                                Icons.photo,
                                () {
                                  null;
                                },
                              ),
                            ],
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      leading: Icon(Icons.logout),
                                      title: Text('Terminar sessão'),
                                      onTap: ()async {
                                         await context.read<AuthService>().signOut();
                                         Navigator.pushAndRemoveUntil(context,
                                              MaterialPageRoute(builder: (context) => Wrapper()), (_) => false);}
                                    )
                                  ]),
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

  Widget header(String name) {
    return DrawerHeader(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 40,
            ),
          ),
          Align(
            alignment: Alignment.centerRight + Alignment(-0.2, -0.4),
            child: Text(
              name,
              style: GoogleFonts.amita(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
