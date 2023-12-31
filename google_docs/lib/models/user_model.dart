// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String profilePic;
  final String name;
  final String email;
  final String uid;
  final String token;

  UserModel({
    required this.profilePic, 
  required this.name, 
  required this.email,
   required this.uid,
    required this.token});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'profilePic': profilePic,
      'name': name,
      'email': email,
      'uid': uid,
      'token': token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      profilePic: map['profilePic'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      uid: map['_id'] as String,
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  UserModel copyWith({
    String? profilePic,
    String? name,
    String? email,
    String? uid,
    String? token,
  }) {
    return UserModel(
      profilePic: profilePic ?? this.profilePic,
      name: name ?? this.name,
      email: email ?? this.email,
      uid: uid ?? this.uid,
      token: token ?? this.token,
    );
  }
}
