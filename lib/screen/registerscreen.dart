// ignore_for_file: prefer_const_constructors

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/src/provider.dart';
import 'package:workout/screen/homescreen.dart';
import 'package:workout/services/authservice.dart';

//import 'package:cloud_firestore/cloud_firestore.dart';
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();

  String? email;
  String? password;
  String? phone;
  String? age;
  String? name;

  Widget _email() {
    return Stack(
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.yellow[200],
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        TextFormField(
          validator: (value) => EmailValidator.validate(value!)
              ? null
              : "Por amor de deus, mete um mail em condições!!",

          onSaved: (val) => email = val,

          obscureText: false,
          keyboardType: TextInputType.emailAddress,
          //controller: _controllerUsername,
          autocorrect: false,
          decoration: const InputDecoration(
            errorStyle: TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
            errorMaxLines: 2,
            hintText: 'Mete o crl do mail',
            border: InputBorder.none,
            // focusedBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.all(Radius.circular(30.0)),
            //   borderSide: BorderSide(color: Colors.blue),
            // ),
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          ),
        ),
      ],
    );
  }

  Widget _password() {
    return Stack(
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.yellow[200],
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        TextFormField(
          validator: (value) =>
              value!.length < 6 ? "Pass igual a tua piça, CURTA!!" : null,

          onSaved: (val) => password = val,

          obscureText: true,
          keyboardType: TextInputType.name,
          //controller: _controllerUsername,
          autocorrect: false,
          decoration: const InputDecoration(
            errorStyle: TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
            errorMaxLines: 2,
            hintText: 'É bom que metas uma pass boa',
            border: InputBorder.none,
            // focusedBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.all(Radius.circular(30.0)),
            //   borderSide: BorderSide(color: Colors.blue),
            // ),
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          ),
        ),
      ],
    );
  }

  Widget _phone() {
    return Stack(
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.yellow[200],
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        TextFormField(
          validator: (value) => value!.length < 9 ? "9 digitos" : null,

          onSaved: (val) => phone = val,

          obscureText: false,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
          keyboardType: TextInputType.number,
          //controller: _controllerUsername,
          autocorrect: false,
          decoration: const InputDecoration(
            errorStyle: TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
            errorMaxLines: 2,
            hintText: 'Telemóvel',
            border: InputBorder.none,
            // focusedBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.all(Radius.circular(30.0)),
            //   borderSide: BorderSide(color: Colors.blue),
            // ),
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          ),
        ),
      ],
    );
  }

  Widget _name() {
    return Stack(
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.yellow[200],
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        TextFormField(
          validator: (value) => value!.isEmpty ? "Insira nome" : null,

          onSaved: (val) => name = val,
          //controller: _nameController,
          obscureText: false,
          keyboardType: TextInputType.name,
          //controller: _controllerUsername,
          autocorrect: false,
          decoration: const InputDecoration(
            errorStyle: TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
            errorMaxLines: 2,
            hintText: 'Nome',
            border: InputBorder.none,
            // focusedBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.all(Radius.circular(30.0)),
            //   borderSide: BorderSide(color: Colors.blue),
            // ),
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          ),
        ),
      ],
    );
  }

  Widget _age() {
    return Stack(
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.yellow[200],
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        TextFormField(
          validator: (value) => value!.isEmpty ? "Idade..." : null,

          onSaved: (val) => age = val,
          //controller: _ageController,
          obscureText: false,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
          keyboardType: TextInputType.number,
          //controller: _controllerUsername,
          autocorrect: false,
          decoration: const InputDecoration(
            errorStyle: TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
            errorMaxLines: 2,
            hintText: 'Idade',
            border: InputBorder.none,
            // focusedBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.all(Radius.circular(30.0)),
            //   borderSide: BorderSide(color: Colors.blue),
            // ),
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          ),
        ),
      ],
    );
  }

  //CollectionReference users = FirebaseFirestore.instance.collection('users');
  Widget _buttonLogin(BuildContext context1) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 40,
        horizontal: 0,
      ),

      //alignment: Alignment.center,
      height: 50,
      width: 100,
      // margin: EdgeInsets.symmetric(
      //   //vertical: 30,
      //   horizontal: 0,
      // ),

      //height: 20,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
        ),
        onPressed: () async {
          //users.add({'name':'Leoanrdo','Funciona':'sim'}).then((value) => print('user ADDED'));
          await submit();
        },
        child: const Text(
          "Criar",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Future<void> submit() async {
    final form = formKey.currentState!;
    form.save();
    if (form.validate()) {
      await context.read<AuthService>().signUp(
          email: email!,
          password: password!,
          name: name!,
          age: age!,
          phone: phone!);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 40.0,
            vertical: 0,
          ),
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFF46404),
                Color(0xFFE0740F),
                Color(0xFFC08043),
                Color(0xFFDB9F89),
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 20.0,
                  ),
                  child: const Text(
                    "Sign Up",
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
                _name(),
                SizedBox(height: 20.0),
                _phone(),
                SizedBox(height: 20.0),
                _age(),
                SizedBox(height: 20.0),
                _email(),
                SizedBox(height: 20.0),
                _password(),
                SizedBox(height: 20),

                _buttonLogin(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
