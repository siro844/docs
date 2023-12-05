import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Center(
      child: ElevatedButton.icon(
        onPressed: (){},
       icon: Image.asset("assets/google_logo.png",height: 40,width: 40,), 
       label:Text("Sign in with Google"), ),
     ),
    );
  }
}