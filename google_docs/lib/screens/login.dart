import 'package:flutter/material.dart';
import 'package:google_docs/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Center(
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(150, 50),
          backgroundColor: white,
        ),
        onPressed: (){},
       icon: Image.asset("assets/google_logo.png",height: 30,width: 30,), 
       label:const Text("Sign in with Google",style: TextStyle(color: black),), ),
     ),
    );
  }
}