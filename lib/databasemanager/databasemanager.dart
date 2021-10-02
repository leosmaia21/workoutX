import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class DatabaseManager {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  String? _userName;
  String? _userUID;
  File? imageFile; // fotografia do drawer
  String? urlImage;
  var image;
  bool hasPhoto = false;
  //String? imagePath;

  Future<String?> getProfileImage() async {
    String uid = _auth.currentUser!.uid.toString();
    try {
      String url = await _storage.ref('users_photos/' + uid).getDownloadURL();
      urlImage = url;
      image = NetworkImage(url);
      hasPhoto = true;
      return url;
    } catch (e) {
      print('foto NAO buscada na storage');
      print(e.toString());
      return null;
    }
  }

  Future init() async {
    User? user = _auth.currentUser;

    _userUID = user!.uid.toString();
    print('Utilizador!!!!  ' + _userUID!);
    DocumentSnapshot x = await users.doc(_userUID).get();
    var data = x.data() as Map;
    print(data['name']);
    _userName = data['name'];

    String uid = _auth.currentUser!.uid.toString();
    try {
      String url = await _storage.ref('users_photos/' + uid).getDownloadURL();
      urlImage = url;
      image = NetworkImage(url);
      hasPhoto = true;
    } catch (e) {
      print('foto NAO buscada na storage');
      print(e.toString());
    }
  }

  Future<Map> getWorkouts() async {
    String uid = _auth.currentUser!.uid.toString();
    try {
      DocumentSnapshot x =
          await _firestore.collection('workouts').doc(uid).get();
      var xx = x.data() as Map;
      print('treinos:');
      print(xx);
      return xx;
    } catch (e) {
      print('não há treinos');
      return {};
    }
  }

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
    User? user = _auth.currentUser;

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

  void setLogOut() {
    _userName = null;
    _userUID = null;
    imageFile = null; // fotografia do drawer
    urlImage = null;
    image = null;
    hasPhoto = false;
  }
}
