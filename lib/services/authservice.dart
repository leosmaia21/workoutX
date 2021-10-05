import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:workout/databasemanager/databasemanager.dart';
import 'package:workout/utilities/toast.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;

  AuthService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  User? getUser() {
    //await _firebaseAuth.currentUser?.reload();
    return _firebaseAuth.currentUser;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String?> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      print("erro singIn: " + e.code);
      if (e.code == 'user-not-found') {
        return e.code;
      } else if (e.code == 'wrong-password') {
        return e.code;
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
      print('ole:'+e.code);
      if (e.code == 'email-already-in-use') {
        // toast("Email já usado");
        return false;
      }
    }
  }
}
