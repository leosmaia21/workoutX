// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:workout/databasemanager/databasemanager.dart';
import 'package:workout/screen/registerscreen.dart';
import 'package:workout/services/authservice.dart';
import 'package:workout/utilities/gowrapper.dart';
import 'package:workout/utilities/loading.dart';
import 'package:flutter/services.dart';
import 'package:workout/utilities/toast.dart';

import '../main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _emailError;
  String? _passwordError;

  Widget _email() {
    return Stack(
      children: [
        Container(
          height: 60,
          decoration: BoxDecoration(
            color: Color(0xFFE60505),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        TextFormField(
          controller: _emailController,
          // validator: (value) =>
          //     value!.length < 6 ? "Mínimo 6 caracteres" : null,

          // onSaved: (val) => password = val,
          style: TextStyle(
            color: Colors.white,
          ),
          obscureText: false,
          keyboardType: TextInputType.emailAddress,
          //controller: _controllerUsername,
          autocorrect: false,
          decoration: InputDecoration(
            errorText: _emailError,
            errorStyle: TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
            prefixIcon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
            errorMaxLines: 2,
            hintText: 'Email',
            hintStyle: TextStyle(color: Colors.white),
            border: InputBorder.none,
            // focusedBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.all(Radius.circular(30.0)),
            //   borderSide: BorderSide(color: Colors.blue),
            // ),
            contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          ),
        ),
      ],
    );
  }

  Widget _password() {
    return Stack(
      children: [
        Container(
          height: 60,
          decoration: BoxDecoration(
            color: Color(0xFFE60505),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        TextFormField(
          controller: _passwordController,
          // validator: (value) =>
          //     value!.length < 6 ? "Mínimo 6 caracteres" : null,

          // onSaved: (val) => password = val,
          style: TextStyle(
            color: Colors.white,
          ),
          obscureText: true,
          keyboardType: TextInputType.name,
          //controller: _controllerUsername,
          autocorrect: false,
          decoration: InputDecoration(
            errorText: _passwordError,
            errorStyle: TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
            prefixIcon: const Icon(
              Icons.lock,
              color: Colors.white,
            ),
            errorMaxLines: 2,
            hintText: 'Palavra-passe',
            hintStyle: TextStyle(color: Colors.white),
            border: InputBorder.none,
            // focusedBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.all(Radius.circular(30.0)),
            //   borderSide: BorderSide(color: Colors.blue),
            // ),
            contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          ),
        ),
      ],
    );
  }

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Widget _buttonLogin(BuildContext context1) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 40,
        horizontal: 0,
      ),
      height: 50,
      width: 100,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
        ),
        onPressed: () async {
          _emailError = null;
          _passwordError = null;
          FocusScope.of(context).unfocus();
          buildLoading(context);
          String? x = await context
              .read<AuthService>()
              .signIn(_emailController.text, _passwordController.text);

          if (EmailValidator.validate(_emailController.text) == false) {
            Navigator.of(context).pop();
            setState(() {
              _emailError = "Email inválido";
            });
          } else if (x == 'user-not-found') {
            Navigator.of(context).pop();
            setState(() {
              _emailError = "Email não encontrado";
            });
          } else if (_passwordController.text.length < 6) {
            Navigator.of(context).pop();
            setState(() {
              _passwordError = "6 caracteres";
            });
          } else if (x == 'wrong-password') {
            Navigator.of(context).pop();
            setState(() {
              _passwordError = "Palavra-passe errada";
            });
          } else if(x==null) {
            await context.read<DatabaseManager>().Name();
            await context.read<DatabaseManager>().getProfileImage();
            Navigator.of(context).pop();
            goWrapper(context);
          }
          print("dialog final");
          //users.add({'name':'Leoanrdo','Funciona':'sim'}).then((value) => print('user ADDED'));
        },
        child: const Text(
          "Login",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget _registerButton() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegisterScreen()),
        );
      },
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Não tens conta? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Criar',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 40.0,
          vertical: 50.0,
        ),
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          // image: DecorationImage(
          //   image: AssetImage('lib/assets/images/moniz_crl.png'),
          //   alignment: Alignment.bottomRight,
          //   fit: BoxFit.cover,
          // ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFA8538),
              Color(0xFFF7B271),
              Color(0xFFF0CCAB),
              Color(0xFFFAEDE8),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 20.0,
                  ),
                  child: const Text(
                    "Login",
                    //textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                //SizedBox(height: 60.0),
                _email(),
                SizedBox(height: 30.0),
                _password(),
                // SizedBox(
                //   width: 40,
                // ),
                _buttonLogin(context),

                _registerButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
