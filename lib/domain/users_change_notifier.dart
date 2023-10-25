import 'package:flutter/material.dart';
import 'package:flutter_unit_test_tutorial/models/user.dart';
import 'package:flutter_unit_test_tutorial/services/users_service.dart';

class UserChangeNotifier extends ChangeNotifier {
  UserChangeNotifier(this.userService);

  final UserService userService;

  List<User> _users = [];

  List<User> get users => _users;

  Future<void> getUsers() async {
    _users = await userService.getUsers();
    notifyListeners();
  }

  Future<User?> getUser(String name, String password) async {
    return userService.getUser(name, password);
  }
}
