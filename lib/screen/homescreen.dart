// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout/databasemanager/databasemanager.dart';
import 'package:workout/screen/workout.dart';
import 'package:workout/services/authservice.dart';
import 'package:workout/utilities/toast.dart';
import '../drawer/drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<Map> _workouts;
  Map? x;
  @override
  initState() {
    super.initState();
    _workouts = context.read<DatabaseManager>().getWorkouts();
  }

  String? userName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      drawer: NavigationDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) {
            return Builder(builder: (context) {
              return IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
                onPressed: () async {
                  Scaffold.of(context).openDrawer();
                },
              );
            });
          },
        ),
      ),
      body: FutureBuilder<Object>(
        future: _workouts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            x = snapshot.data as Map;
            return Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                SingleChildScrollView(
                  child: Column( ////
                    children: [
                      for (int i = 1; i <= x!.length; i++)
                        tile(Icons.ac_unit_outlined, x!['$i'], 10),
                    ],
                  ),
                )
              ],
            );
          } else {
            return const Center(
              child: Image(
                image: AssetImage('lib/assets/images/cara_moniz_gif1.gif'),
              ),
            );
          }
        },
      ),
    );
  }

  Widget tile(IconData icon, String name, int number) {
    final border =
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0));
    return Container(
      // alignment: Alignment.center,
      // width: MediaQuery.of(context).size.width,
      height: 100,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          // vertical: 20,
          horizontal: 20,
        ),
        child: InkWell(
          onTap: () => toast('ole'),
          child: Card(
            margin: EdgeInsets.symmetric(vertical: 10),
            // clipBehavior: Clip.values,
            shape: border,
            color: Colors.black45,
            elevation: 7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    SizedBox(width: 20),
                    Icon(icon),
                    SizedBox(width: 20),
                    Text(
                      name,
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                // SizedBox(width: MediaQuery.of(context).size.width * 0.2),
                Row(
                  children: [
                    Text('$number'),
                    SizedBox(width: 30),
                  ],
                ),
                // SizedBox(width: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
