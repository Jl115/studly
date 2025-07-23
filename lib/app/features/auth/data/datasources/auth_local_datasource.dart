import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:studly/app/core/database/controller/database.controller.dart';
import 'package:studly/app/core/service/go_router.service.dart';
import 'package:studly/app/features/auth/data/models/user.model.dart';
import 'package:uuid/uuid.dart';

class AuthLocalDataSource {
  AuthLocalDataSource();

  final _databaseController = DatabaseController();

  String _hashPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<UserModel?> login(String username, String password) async {
    final hashedPassword = _hashPassword(password);
    final result = await _databaseController.findOne(
      table: 'user',
      where: 'username = ? AND password = ?',
      whereArgs: [username, hashedPassword],
    );

    if (result == null) return null;

    final user = UserModel.fromMap(result);
    await _databaseController.updateValue('user', 'logged_in', 1, 'id', user.id!);
    return user;
  }

  Future<bool> register(String username, String password) async {
    final existing = await _databaseController.findOne(table: 'user', where: 'username = ?', whereArgs: [username]);

    if (existing != null) return false;

    final hashedPassword = _hashPassword(password);

    final id = const Uuid().v4(); // Generate a unique ID for the user
    final result = await _databaseController.create(
      table: 'user',
      data: {'id': id.toString(), 'username': username, 'password': hashedPassword},
    );
    return result > 0;
  }

  Future<bool> logout() async {
    final user = await getCurrentUser();
    if (user == null) return false;
    await _databaseController.updateValue('user', 'logged_in', 0, 'id', user.id);
    GoRouterService().go('/');
    return true;
  }

  Future<UserModel?> getCurrentUser() async {
    final userId = await _databaseController.getCurrentUserId();
    if (userId == null) return null;
    final result = await _databaseController.findOne(table: 'user', where: 'id = ?', whereArgs: [userId]);
    if (result == null) return null;
    return UserModel.fromMap(result);
  }

  Future<bool> isLoggedIn() async {
    final userId = await _databaseController.getCurrentUserId();
    if (userId == null) return false;
    final result = await _databaseController.findOne(
      table: 'user',
      where: 'id = ? AND logged_in = ?',
      whereArgs: [userId, 1],
    );
    return result != null;
  }
}
