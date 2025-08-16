import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/user_entitiy.dart';

class UserModel extends UserEntity {
  const UserModel({required String uid, String? email}) : super(uid: uid, email: email);

  factory UserModel.fromFirebase(User user) {
    return UserModel(uid: user.uid, email: user.email);
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(uid: map['uid'], email: map['email']);
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(uid: entity.uid, email: entity.email);
  }

  Map<String, dynamic> toMap() {
    return {'uid': uid, 'email': email};
  }

  UserEntity toEntity() {
    return UserEntity(uid: uid, email: email);
  }
}