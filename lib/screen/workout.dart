import 'package:flutter/material.dart';

class Workout extends StatefulWidget {
  const Workout({ Key? key }) : super(key: key);

  @override
  _WorkoutState createState() => _WorkoutState();
}

class _WorkoutState extends State<Workout> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
      body:const Center(
        child: Text('ole'),

      )
      
    );
  }
}