import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/user_entitiy.dart';

class UserModel extends UserEntity {
  const UserModel({required super.uid, super.email});

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
    };
  }

  static UserModel fromFirebase(User user) {
    return UserModel(
      uid: user.uid,
      email: user.email,
    );
  }

  static UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      email: map['email'] as String?,
    );
  }
}