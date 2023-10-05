import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';
import 'components.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _nameError = '';
  String _emailError = '';
  String _passwordError = '';

  void _signUpWithEmailAndPassword() async {
    // Reset any previous error messages
    setState(() {
      _nameError = '';
      _emailError = '';
      _passwordError = '';
    });

    try {
      final UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      final User? user = userCredential.user;

      if (user != null) {
        await user.updateDisplayName(_nameController.text.trim());

        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => LoginPage(),
        ));
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'email-already-in-use') {
          setState(() {
            _emailError = 'Email already in use';
          });
        } else {
          setState(() {
            _emailError = 'Sign-up failed';
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SIGN UP',
          style: TextStyle(
            color: Colors.white, // Set text color to white
          ),
        ),
        backgroundColor: primaryColor,
        centerTitle: true,// Use primaryColor for the app bar background color
      ),
      body: commonBackground(
        color: secondaryColor, // Use secondaryColor for the background color
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: Image.asset(
                      'assets/images/signup.png',
                      height: 300,
                      width: 300,
                    ),
                  ),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      fillColor: Colors.white, // Use white as the text field background color
                      filled: true,
                      errorText: _nameError.isNotEmpty ? _nameError : null,
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      fillColor: Colors.white, // Use white as the text field background color
                      filled: true,
                      errorText: _emailError.isNotEmpty ? _emailError : null,
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      fillColor: Colors.white, // Use white as the text field background color
                      filled: true,
                      errorText: _passwordError.isNotEmpty ? _passwordError : null,
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _signUpWithEmailAndPassword,
                    style: commonButtonStyle, // Use commonButtonStyle for the button
                    child: Text(
                      'Sign Up',
                      style: buttonTextStyle, // Use buttonTextStyle for button text
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}