
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
              image: AssetImage('lib/assets/images/cara_moniz_gif1.gif'),
            ),
          );
        }
      },
    );
  }
}

class Wrapper extends StatefulWidget {
  Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  var first;
  Future? x;
  
  

  Future _getU() async {
    await FirebaseAuth.instance.currentUser?.reload();
    return FirebaseAuth.instance.currentUser;

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    x = _getU();
    first = true;

  }

  @override
  Widget build(BuildContext context) {
    // buildLoading(context);
    var _firebaseUser = context.watch<User?>();
    if (first) {
      return FutureBuilder(
          future: x,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (FirebaseAuth.instance.currentUser != null) {
                first = false;
                return HomeScreen();
              } else {
                first = false;
                return LoginScreen();
              }
            } else {
              return const Center(
                child:  Image(
                  image:AssetImage('lib/assets/images/cara_moniz_gif1.gif')
                ),
              );
            }
          });
    } else {
      if (_firebaseUser != null) {
        // Navigator.of(context).pop();
        return HomeScreen();
      }
      // Navigator.of(context).pop();
      return LoginScreen();
    }
  }
}
