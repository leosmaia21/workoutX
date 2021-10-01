import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout/databasemanager/databasemanager.dart';
import 'package:workout/screen/homescreen.dart';
import 'package:workout/screen/loginscreen.dart';
import 'package:workout/services/authservice.dart';

///
///
///aisdmsak
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
          return const Text('Alguma coisa deu erro');
        } else if (snapshot.hasData) {
          return MultiProvider(
            providers: [
              Provider<AuthService>(
                create: (_) => AuthService(FirebaseAuth.instance),
              ),
              Provider<DatabaseManager>(
                create: (_) => DatabaseManager(),
              ),
              StreamProvider(
                create: (context) =>
                    context.read<AuthService>().authStateChanges,
                initialData: null,
              ),
            ],
            child: MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSwatch(
                  primarySwatch: Colors.blueGrey,
                ),
              ),
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
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  static bool first = true;
  Future? x;
  Future? _name;
  Future<bool> _getU() async {
    await FirebaseAuth.instance.currentUser?.reload();
    if (FirebaseAuth.instance.currentUser == null) {
      return false;
    } else {
      return true;
    }
  }

  @override
  void initState() {
    super.initState();
    x = _getU();
    //first = true;
    // _name = context.read<DatabaseManager>().Name();
  }

  @override
  Widget build(BuildContext context) {
    // buildLoading(context);
    // var _firebaseUser = context.watch<User?>();

    if (first == true) {
      return FutureBuilder(
        future: x,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (FirebaseAuth.instance.currentUser != null) {
              print("current user exist");
              return FutureBuilder(
                future: context.read<DatabaseManager>().init(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    first = false;
                    //  context.read<DatabaseManager>().getProfileImage();
                    return HomeScreen();
                  } else {
                    return const Center(
                      child: Image(
                        image:
                            AssetImage('lib/assets/images/cara_moniz_gif1.gif'),
                      ),
                    );
                  }
                },
              );
            } else {
              first = false;
              print("current user null");
              return const LoginScreen();
            }
          } else {
            return const Center(
              child: Image(
                image: AssetImage('lib/assets/images/cara_moniz_gif1.gif'),
              ),
            );
          }
        },
      );
    } else {
      if (context.read<AuthService>().getUser() != null) {
        // Navigator.of(context).pop();
        // await context.read<DatabaseManager>().Name();
        return const HomeScreen();
      }
      // Navigator.of(context).pop();
      return const LoginScreen();
    }
  }
}
