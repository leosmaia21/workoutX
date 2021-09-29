import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseManager {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  String? _userName;
  String? _userUID;
  File? imageFile;   // fotografia do drawer 
  String? imagePath;
  Future<void> insertUser(
      {required String name,
      required String email,
      required int phone,
      required int age,
      required String uid}) async {
    await users.doc(uid).set(
      {'name': name, 'email': email, 'phone': phone, 'age': age, 'uid': uid},
    ).then((value) => print('user ADDED'));
  }

  Future<void> Name() async {
    // FirebaseAuth.instance.currentUser.reload();
    User? user = FirebaseAuth.instance.currentUser;

    _userUID = user!.uid.toString();
    print('Utilizador!!!!  ' + _userUID!);
    DocumentSnapshot x = await users.doc(_userUID).get();
    var data = x.data() as Map;
    print(data['name']);
    _userName = data['name'];
  }

  String? getName() {
    return _userName;
  }
}
