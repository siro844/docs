// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:html';
import 'package:google_docs/constants.dart';
import 'package:google_docs/constants.dart';
import 'package:http/http.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_docs/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

final  authRepositoryProvider=Provider((ref) =>
 AuthRepository(googleSignIn: GoogleSignIn(),
 client: Client(),
 ),
 );

class AuthRepository {
  final GoogleSignIn _googleSignIn;
  final Client _client;
  AuthRepository({
    required GoogleSignIn googleSignIn,
    required Client client,
  }):_googleSignIn=googleSignIn,_client=client;


  void signInWithGoogle() async {
    try{
     final user = await  _googleSignIn.signIn();
      if(user!=null){
      final userAcc=UserModel(
        profilePic:user.photoUrl! , 
       name: user.displayName!,
       email: user.email,
       uid:'',
       token: '',
         );
        var res = await  _client.post(
          Uri.parse('$host/api/signup'),
         body: userAcc.toJson(),
         headers: {
          'Content-Type':'application/json; charset=UTF-8',

         }
         );


      }
    }
    catch(e){
      print(e);
    }
  }
}

