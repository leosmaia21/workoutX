// ignore_for_file: prefer_const_constructors

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/src/provider.dart';
import 'package:workout/screen/homescreen.dart';
import 'package:workout/services/authservice.dart';
import 'package:workout/utilities/loading.dart';

import '../main.dart';

//import 'package:cloud_firestore/cloud_firestore.dart';
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  String? _emailError;

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
          validator: (value) =>
              EmailValidator.validate(value!) ? null : "Email inválido ",

          onSaved: (val) => email = val,
          style: TextStyle(
            color: Colors.black,
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
            errorMaxLines: 2,
            hintText: 'Email',
            hintStyle: TextStyle(color: Colors.black),
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
          controller: _passwordController,
          validator: (value) =>
              value!.length < 6 ? "Mínimo 6 caracteres" : null,

          onSaved: (val) => password = val,
          style: TextStyle(
            color: Colors.black,
          ),
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
            hintText: 'Palavra-passe',
            hintStyle: TextStyle(color: Colors.black),
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

  Widget _passwordConfirm() {
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
          controller: _passwordConfirmController,
          validator: (value) {
            if (value!.isEmpty) {
              return "Mínimo 6 caracteres";
            } else {
              if (_passwordController.text != _passwordConfirmController.text) {
                return "Palavras-passe diferentes";
              }
              return null;
            }

            //value!.length < 6 ? "Mínimo 6 caracteres" : null,
          },
          onSaved: (val) => password = val,
          style: TextStyle(
            color: Colors.black,
          ),
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
            hintText: ' Confirmar palavra-passe',
            hintStyle: TextStyle(color: Colors.black),
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
          validator: (value) => value!.length != 9 ? "9 digitos" : null,

          onSaved: (val) => phone = val,
          style: TextStyle(
            color: Colors.black,
          ),
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
            hintStyle: TextStyle(color: Colors.black),
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
          style: TextStyle(
            color: Colors.black,
          ),
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
            hintStyle: TextStyle(color: Colors.black),
            border: InputBorder.none,
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
          validator: (value) => value!.isEmpty ? "Idade inválida" : null,
          onSaved: (val) => age = val,
          style: TextStyle(color: Colors.black),
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
            hintStyle: TextStyle(color: Colors.black),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          ),
        ),
      ],
    );
  }

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
          FocusScope.of(context).unfocus();
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
      buildLoading(context);
      final x = await context.read<AuthService>().signUp(
          email: email!,
          password: password!,
          name: name!,
          age: age!,
          phone: phone!);
      Navigator.of(context).pop();

      if (x == true) {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => Wrapper()), (_) => false);
      }
      if (x == false) {
        setState(() {
          _emailError = "Email já usado";
        });
      }
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
                    "Criar conta",
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
                _passwordConfirm(),
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
