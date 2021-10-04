import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout/databasemanager/databasemanager.dart';
import 'package:workout/screen/workout/exercise.dart';
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
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: FutureBuilder(
          future: _load,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                exercises = snapshot.data as Map;

                return _workout(x);
              } else {
                return Center(
                  child: Text('nao ha treinos'),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  Widget _workout(int? x) {
    print(exercises);
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        SingleChildScrollView(
          child: Column(
            ////
            children: [
              for (int i = 1; i <= exercises!.length; i++)
                tile(Icons.fitness_center, exercises!['$i'], 10, i),
            ],
          ),
        )
      ],
    );
  }

  Widget tile(IconData icon, String name, int number, int i) {
    final border =
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0));
    List exerciseNameAndReps = name.split('/');
    return SizedBox(
      // alignment: Alignment.center,
      // width: MediaQuery.of(context).size.width,
      height: 100,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          // vertical: 20,
          horizontal: 20,
        ),
        child: InkWell(
          customBorder: border,
          onTap: () {
            context.read<DatabaseManager>().exerciseID = i;
            context.read<DatabaseManager>().exerciseNameAndReps =
                exerciseNameAndReps;
            print(context.read<DatabaseManager>().exerciseNameAndReps![0]);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Exercise()));
          },
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
                      exerciseNameAndReps[0],
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                // SizedBox(width: MediaQuery.of(context).size.width * 0.2),
                Row(
                  children: [
                    Text(
                      exerciseNameAndReps[1],
                      style: TextStyle(fontSize: 17),
                    ),
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
