import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout/databasemanager/databasemanager.dart';
import 'package:workout/screen/workout/diary.dart';
import 'package:workout/screen/workout/info.dart';

class Exercise extends StatefulWidget {
  Exercise({Key? key}) : super(key: key);

  @override
  _ExerciseState createState() => _ExerciseState();
}

class _ExerciseState extends State<Exercise> {
  int _selectedPage = 0;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }

  final screens = [Diary(), Info()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.read<DatabaseManager>().exerciseNameAndReps![0]! +"  "+
            context.read<DatabaseManager>().exerciseNameAndReps![1]),
        centerTitle: true,
      ),
      body: IndexedStack(index: _selectedPage, children: screens),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Diário',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_sharp),
            label: 'Instruções',
          ),
        ],
        currentIndex: _selectedPage,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: null,
        onTap: (int index) {
          setState(() {
            _selectedPage = index;
          });
        },
      ),
    );
  }
}
