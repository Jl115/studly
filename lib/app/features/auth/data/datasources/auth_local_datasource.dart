import 'package:crypto/crypto.dart';
import 'package:studly/app/core/database/controller/database.controller.dart';
import 'dart:convert';
import '../models/user.model.dart';

abstract class AuthLocalDataSource {
  Future<UserModel?> login(String username, String password);
  Future<bool> register(String username, String password);
  Future<bool> logout();
  Future<UserModel?> getCurrentUser();
  Future<bool> isLoggedIn();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl();

  final _databaseController = DatabaseController();

  String _hashPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  @override
  Future<UserModel?> login(String username, String password) async {
    final hashedPassword = _hashPassword(password);

    final result = await _databaseController.findOne(
      table: 'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, hashedPassword],
    );

    if (result == null) return null;

    final user = UserModel.fromMap(result);
    await _databaseController.saveCurrentUserId(user.id!);
    return user;
  }

  @override
  Future<bool> register(String username, String password) async {
    final existing = await _databaseController.findOne(table: 'users', where: 'username = ?', whereArgs: [username]);

    if (existing != null) return false;

    final hashedPassword = _hashPassword(password);

    final result = await _databaseController.create(
      table: 'users',
      data: {'username': username, 'password': hashedPassword},
    );

    return result > 0;
  }

  @override
  Future<bool> logout() async {
    await _databaseController.removeCurrentUserId();
    return true;
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final userId = await _databaseController.getCurrentUserId();

    if (userId == null) return null;

    final result = await _databaseController.findOne(table: 'users', where: 'id = ?', whereArgs: [userId]);

    if (result == null) return null;
    return UserModel.fromMap(result);
  }

  @override
  Future<bool> isLoggedIn() async {
    final userId = await _databaseController.getCurrentUserId();
    return userId != null;
  }
}
