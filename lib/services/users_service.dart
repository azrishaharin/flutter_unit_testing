import 'package:flutter_unit_test_tutorial/models/user.dart';

class UserService {
  List<User> users = [];

  Future<List<User>> getUsers() async {
    await Future.delayed(const Duration(seconds: 3));
    return users;
  }

  //fetch one user by name and password
  Future<User?> getUser(String name, String password) async {
    await Future.delayed(const Duration(seconds: 3));
    for (final user in users) {
      if (user.name == name && user.password == password) {
        return user;
      }
    }
    return null;
  }
}
