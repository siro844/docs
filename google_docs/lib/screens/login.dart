import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_docs/colors.dart';
import 'package:google_docs/repository/auth_repository.dart';
import 'package:google_docs/screens/home.dart';
import 'package:routemaster/routemaster.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  void signInwithGoogle(WidgetRef ref,BuildContext context) async {
    final sMessenger=ScaffoldMessenger.of(context);
    final navigator = Routemaster.of(context);
   final errorModel=  await ref.read(authRepositoryProvider).signInWithGoogle();
  if(errorModel.error==null){
   ref.read(userProvider.notifier).update((state) => errorModel.data);
  navigator.replace(
   '/'
     );
  }
  else{
    sMessenger.showSnackBar(
      SnackBar(
        content: Text(errorModel.error!),

    ));
  }
 
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
          signInwithGoogle(ref,context);
        },
       icon: Image.asset("assets/google_logo.png",height: 30,width: 30,), 
       label:const Text("Sign in with Google",style: TextStyle(color: black),), ),
     ),
    );
  }
}