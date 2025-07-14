import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    super.id,
    required super.username,
    required super.password,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      username: map['username'],
      password: map['password'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
    };
  }
}
