import 'package:firebase_auth/firebase_auth.dart';
import 'package:workout/databasemanager/databasemanager.dart';
import 'package:workout/utilities/toast.dart';

class AuthService{
  final FirebaseAuth _firebaseAuth;

  AuthService(this._firebaseAuth);

Stream <User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String?> signIn(String email,String password) async{
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return "agora deu";

    }on FirebaseAuthException catch(e){
      return e.message;
    }
  }

  Future<String?> signUp( {required String email,required String password,required String name,required String age,required String phone}) async{
    try{
     final user= await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
     String? uid=user.user?.uid.toString();
      DatabaseManager().insertUser(name: name, email: email, phone: int.parse(phone), age: int.parse(age),uid: uid!);
      //return "agora deu";

    }on FirebaseAuthException catch(e){
      return e.message;
    }
  }




}