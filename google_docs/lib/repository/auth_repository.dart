// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:google_docs/constants.dart';
import 'package:google_docs/models/error_model.dart';
import 'package:google_docs/repository/local_storage_repository.dart';
import 'package:http/http.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_docs/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

final  authRepositoryProvider=Provider((ref) =>
 AuthRepository(googleSignIn: GoogleSignIn(),
 client: Client(),
 localStorageRepository: LocalStorageRepository(),
 ),
 );

 final userProvider= StateProvider<UserModel?>((ref) => null);

class AuthRepository {
  final GoogleSignIn _googleSignIn;
  final Client _client;
  final LocalStorageRepository _localStorageRepository;
  AuthRepository({
    required GoogleSignIn googleSignIn,
    required Client client,
    required LocalStorageRepository localStorageRepository,
  }):_googleSignIn=googleSignIn,
  _client=client,
  _localStorageRepository=localStorageRepository;


  Future<ErrorModel> signInWithGoogle() async {
    ErrorModel error = ErrorModel(error: 'Some Error occurred', data: null);
    try{
     final user = await  _googleSignIn.signIn();
      if(user!=null){
      final userAcc=UserModel(
        profilePic:user.photoUrl??'' , 
       name: user.displayName ?? '',
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
         switch(res.statusCode){
          case 200:
          final newUser=userAcc.copyWith(
            uid: jsonDecode(res.body)['user']['_id'],
            token : jsonDecode(res.body)['token'],
          );
          error = ErrorModel(error: null, data:newUser);
          _localStorageRepository.setToken(newUser.token);
          break;
         }
      }
    }
    catch(e){
       error = ErrorModel(error: e.toString(), data:null);
    }
    return error;
  }

Future<ErrorModel> getUserData() async {
    ErrorModel error = ErrorModel(error: 'Some Error occurred', data: null);
    try{
      String? token = await _localStorageRepository.getToken();
       if(token!=null){
           var res = await  _client.get(
          Uri.parse('$host/'),
         headers: {
          'Content-Type':'application/json; charset=UTF-8',
          'x-auth-token':token,
         }
         );
          switch(res.statusCode){
          case 200:
         final newUser=UserModel.fromJson(jsonEncode(
          jsonDecode(res.body)['user'],),
          ).copyWith(token: token);

          error = ErrorModel(error: null, data:newUser);
          _localStorageRepository.setToken(newUser.token);
          break;
         }
       }
    }
    catch(e){
       error = ErrorModel(error: e.toString(), data:null);
    }
    return error;
  }

  void signOut() async{
    await _googleSignIn.signOut();
    _localStorageRepository.setToken('');
  }
}

