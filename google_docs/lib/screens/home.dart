import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_docs/colors.dart';
import 'package:google_docs/repository/auth_repository.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});


void signOut(WidgetRef ref){
  ref.read(authRepositoryProvider).signOut();
  ref.read(userProvider.notifier).update((state) => null);
}
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        actions: [
          IconButton(onPressed:(){} , icon: const Icon(Icons.add,color: black,)),
          IconButton(onPressed:()=>signOut(ref) , icon: const Icon(Icons.logout,color : Colors.red)),

        ],
      ),
      body:Center(
        child:Text( ref.watch(userProvider)!.uid),
      )
    );
  }
}