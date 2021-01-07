import 'package:flutter/material.dart';
import 'package:habit_tracker_app/models/activity.dart';

class User extends ChangeNotifier {
  final String id;
  final String firstName;
  final String lastName;
  final int age;
  final String username;
  final String password;
  final List<Activity> activities;
  bool isActiveUser;

  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.age,
      this.username,
      this.password,
      this.activities,
      this.isActiveUser = false});

  void toggleActiveUser() {
    this.isActiveUser = !isActiveUser;
    notifyListeners();
  }

  @override
  String toString() {
    return ('Id: $id , firstName: $firstName, lastName: $lastName');
  }
}
