import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workout/databasemanager/databasemanager.dart';
import 'package:workout/screen/homescreen.dart';
import 'package:workout/utilities/toast.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;

  AuthService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Future<String?> getUser() async{
  // final User user = await FirebaseAuth.instance.currentUser();
  //   final String uid = user.uid.toString();
  // return uid;
  // }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String?> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "agora deu";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        toast("Email nao registrado");
      } else if (e.code == 'wrong-password') {
        toast('Palavra-passe errada');
      }
    }
  }

  Future<bool?> signUp(
      {required String email,
      required String password,
      required String name,
      required String age,
      required String phone}) async {
    try {
      final user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      String? uid = user.user?.uid.toString();
      await DatabaseManager().insertUser(
          name: name,
          email: email,
          phone: int.parse(phone),
          age: int.parse(age),
          uid: uid!);

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        toast("Email já usado");
        return false;
      }
    }
  }
}
