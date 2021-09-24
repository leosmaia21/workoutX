import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout/screen/homescreen.dart';
import 'package:workout/screen/loginscreen.dart';
import 'package:workout/services/authservice.dart';
import 'package:workout/utilities/loading.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fbApp,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print('You have an error!');
          return Text('Alguma coisa deu erro');
        } else if (snapshot.hasData) {
          return MultiProvider(
            providers: [
              Provider<AuthService>(
                create: (_) => AuthService(FirebaseAuth.instance),
              ),
              StreamProvider(
                create: (context) =>
                    context.read<AuthService>().authStateChanges,
                initialData: null,
              ),
            ],
            child: MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData.dark(),
              home: Wrapper(),
            ),
          );
        } else {
          return const Center(
            child: Image(
            image: AssetImage('lib/assets/images/cara_moniz_gif.gif'),
          ),
          );
        }
      },
    );
  }
}


class Wrapper extends StatelessWidget {
   Wrapper({Key? key}) : super(key: key);
  var first=true;

  @override
  Widget build(BuildContext context) {
   // buildLoading(context);
    
    var _firebaseUser =  context.watch<User?>();
    if (_firebaseUser != null) {
     // Navigator.of(context).pop();
      return HomeScreen();
      
    }
  // Navigator.of(context).pop();
    return LoginScreen();
    
  }
}
