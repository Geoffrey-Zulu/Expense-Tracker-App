import 'package:expensetrackerapp/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';


class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _signUpWithEmailAndPassword() async {
  try {
  final UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
  email: _emailController.text.trim(),
  password: _passwordController.text.trim(),
  );

  final User? user = userCredential.user; // Use User? to handle potential null value

  if (user != null) {
  // Set the user's display name to the provided name
  await user.updateDisplayName(_nameController.text.trim());

  // User signed up successfully, you can navigate to a different page here.
  // For example, you can use Navigator to go to the home page.
  Navigator.of(context).pushReplacement(MaterialPageRoute(
  builder: (context) => LoginPage(), // Replace with your home page
  ));
  }
  } catch (e) {
  // Handle sign-up errors, e.g., show an error message.
  print('Error during sign-up: $e');
  }
  }


  @override
  Widget build(BuildContext context) {
  return Scaffold(
  appBar: AppBar(
  title: Text('Sign-Up Page'),
  ),
  body: Padding(
  padding: EdgeInsets.all(16.0),
  child: Column(
  children: <Widget>[
  TextField(
  controller: _nameController,
  decoration: InputDecoration(labelText: 'Name'),
  ),
  TextField(
  controller: _emailController,
  decoration: InputDecoration(labelText: 'Email'),
  ),
  TextField(
  controller: _passwordController,
  decoration: InputDecoration(labelText: 'Password'),
  obscureText: true,
  ),
  ElevatedButton(
  onPressed: _signUpWithEmailAndPassword,
  child: Text('Sign Up'),
  ),
  ],
  ),
  ),
  );
  }
  }




