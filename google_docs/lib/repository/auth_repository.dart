// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final  authRepositoryProvider=Provider((ref) =>
 AuthRepository(googleSignIn: GoogleSignIn())
 );

class AuthRepository {
  final GoogleSignIn _googleSignIn;
  AuthRepository({
    required GoogleSignIn googleSignIn,
  }):_googleSignIn=googleSignIn;


  void signInWithGoogle() async {
    try{
     final user = await  _googleSignIn.signIn();
      if(user!=null){
        print(user.email);
        print(user.photoUrl);
        print(user.displayName);
      }
    }
    catch(e){
      print(e);
    }
  }
}
