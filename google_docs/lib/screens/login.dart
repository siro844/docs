import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_docs/colors.dart';
import 'package:google_docs/repository/auth_repository.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});
  void signInwithGoogle(WidgetRef ref){
    ref.read(authRepositoryProvider).signInWithGoogle();
  }

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    ref.watch(authRepositoryProvider).signInWithGoogle();
    return Scaffold(
     body: Center(
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(150, 50),
          backgroundColor: white,
        ),
        onPressed: (){
          signInwithGoogle(ref);
        },
       icon: Image.asset("assets/google_logo.png",height: 30,width: 30,), 
       label:const Text("Sign in with Google",style: TextStyle(color: black),), ),
     ),
    );
  }
}