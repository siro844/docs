import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_docs/models/error_model.dart';
import 'package:google_docs/repository/auth_repository.dart';
import 'package:google_docs/screens/home.dart';
import 'package:google_docs/screens/login.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  // This widget is the root of your application.

  ErrorModel? errorModel;
  @override
  void initState() {
    super.initState();
    getUserData();
  }
  void getUserData() async {
    errorModel=  await ref.read(authRepositoryProvider).getUserData();
  if(errorModel!=null && errorModel!.data != null){
    ref.read(userProvider.notifier).update((state) => errorModel!.data);
  }
  }
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: user==null?  const LoginScreen() : const HomeScreen(),
    );
  }
}



