import 'package:expensetrackerapp/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'signup.dart';
import 'components.dart'; // Import the components.dart file

// Create a new widget class for error messages
class ErrorMessages extends StatelessWidget {
  final String emailError;
  final String passwordError;

  ErrorMessages({required this.emailError, required this.passwordError});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (emailError.isNotEmpty)
          Text(
            emailError,
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        if (passwordError.isNotEmpty)
          Text(
            passwordError,
            style: TextStyle(
              color: Colors.red,
            ),
          ),
      ],
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _emailError = '';
  String _passwordError = '';

  Future<void> _signInWithEmailAndPassword() async {
    // Reset any previous error messages
    setState(() {
      _emailError = '';
      _passwordError = '';
    });

    // Check if email and password fields are empty
    if (_emailController.text.isEmpty) {
      setState(() {
        _emailError = 'Email cannot be empty';
      });
      return;
    }
    if (_passwordController.text.isEmpty) {
      setState(() {
        _passwordError = 'Password cannot be empty';
      });
      return;
    }
    // Check if email address is valid
    if (!RegExp(r'^.+@[a-zA-Z]+\.[a-zA-Z]+$').hasMatch(_emailController.text)) {
      setState(() {
        _emailError = 'Invalid email address';
      });
      return;
    }

    try {
      // Sign the user in
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // If sign-in is successful, navigate to the next screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
              HomePage(), // Replace with the screen to navigate to
        ),
      );
    } catch (e) {
      // Handle authentication errors here
      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found' || e.code == 'wrong-password') {
          setState(() {
            _emailError = 'Invalid credentials';
            _passwordError = 'Invalid credentials';
          });
        } else {
          // Handle other types of authentication errors here
          // For example, you can set a generic error message
          setState(() {
            _emailError = 'Authentication failed';
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'LOGIN PAGE',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        centerTitle: true,
      ),
      body: commonBackground(
        color: secondaryColor,
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: Image.asset(
                    'assets/images/login.png',
                    height: 300,
                    width: 300,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        obscureText: true,
                      ),
                      SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: _signInWithEmailAndPassword,
                        style: commonButtonStyle,
                        child: Text('Sign In', style: buttonTextStyle),
                      ),
                      SizedBox(height: 16),
                      Column(
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SignUpPage(),
                                ),
                              );
                            },
                            child: Text(
                              'Don\'t have an account? Sign Up',
                              style: TextStyle(
                                color: primaryColor,
                              ),
                            ),
                          ),
                          ErrorMessages(
                            emailError: _emailError,
                            passwordError: _passwordError,
                          ),
                        ],
                      ),
                      SizedBox(height: 8), // Add some spacing
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
