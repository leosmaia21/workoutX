import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout/databasemanager/databasemanager.dart';
import 'package:workout/utilities/toast.dart';

class Workout extends StatefulWidget {
  Workout({Key? key}) : super(key: key);

  @override
  _WorkoutState createState() => _WorkoutState();
}

class _WorkoutState extends State<Workout> {
  late Future<Map?> _load;
  Map? exercises;

  @override
  void initState() {
    super.initState();

    _load = context.read<DatabaseManager>().getworkout();
  }

  @override
  Widget build(BuildContext context) {
    final x = context.read<DatabaseManager>().workoutID;
    return Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (context) {
              return Builder(builder: (context) {
                return IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                );
              });
            },
          ),
        ),
        body: FutureBuilder(
          future: _load,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              exercises = snapshot.data as Map;
              return _workout();
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  Widget _workout() {
    print(exercises);
    return Text('ole');
  }
}
