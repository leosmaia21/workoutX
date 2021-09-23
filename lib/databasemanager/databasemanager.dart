import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> insertUser(
      {required String name,
      required String email,
      required int phone,
      required int age,
      required String uid}) async {
    await users.doc(uid).set(
      {'name': name, 'email': email, 'phone': phone, 'age': age,'uid':uid},
    ).then((value) => print('user ADDED'));
  }
}
