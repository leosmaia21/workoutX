// ignore_for_file: prefer_const_constructors


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:workout/databasemanager/databasemanager.dart';
import 'package:workout/services/authservice.dart';

import 'drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String? userName;
  @override
  Widget build(BuildContext context) {
      // context.read<DatabaseManager>().Name();
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: NavigationDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) {
            return Builder(
              builder: (context) {
                return IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.black,
                  ),
                  onPressed: () async{
                    
                    Scaffold.of(context).openDrawer();
                  },
                );
              }
            );
          },
        ),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: SizedBox(
            height: 50,
            width: 50,
            child: Text(
              FirebaseAuth.instance.currentUser!.uid.toString(),
            ),
          ),
        ),
      ),
    );
  }
}
