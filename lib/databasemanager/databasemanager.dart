import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseManager {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  String? _userName;
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
    String user = FirebaseAuth.instance.currentUser!.uid.toString();
    print('Utilizador!!!!  ' + user);
    DocumentSnapshot x = await users.doc(user).get();
    var data = x.data() as Map;
    print(data['name']);
    _userName = data['name'];
  }

  String? getName() {
    return _userName;
  }
}
