import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({ Key? key }) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
 final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Widget _email() {
    return Container(
      height: 60,
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(
        vertical: 20,
        //horizontal: 10,
      ),
      //height: 50,
      decoration: BoxDecoration(
        color: Color(0xFFE60505),
        borderRadius: BorderRadius.circular(50.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 20.0,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        controller: _emailController,
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'OpenSans',
        ),
        decoration: const InputDecoration(
            border: InputBorder.none,
            //contentPadding: EdgeInsets.zero,
            prefixIcon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            hintText: 'Enter your Email',
            hintStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
            )
            //hintStyle: kHintTextStyle,
            ),
      ),
    );
  }

  Widget _password() {
    return Container(
      height: 60,
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        //horizontal: 10,
      ),
      //height: 50,
      decoration: BoxDecoration(
        color: Color(0xFFE60505),
        borderRadius: BorderRadius.circular(50.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 20.0,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: TextField(
        controller: _passwordController,
        obscureText: true,
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'OpenSans',
        ),
        decoration: const InputDecoration(
            border: InputBorder.none,
            //contentPadding: EdgeInsets.only(top: 14.0),
            prefixIcon: Icon(
              Icons.lock,
              color: Colors.white,
            ),
            hintText: 'Enter your password',
            hintStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
            )
            //hintStyle: kHintTextStyle,
            ),
      ),
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
        onPressed: () {},
        child: const Text(
          "Create",
          style: TextStyle(
            fontSize: 20,
          ),
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
              _email(),
              //SizedBox(height: 30.0),
              _password(),
              // SizedBox(
              //   width: 40,
              // ),
              _buttonLogin(context),
        
              
            ],
          ),
        ),
      ),
    );
  }
}
