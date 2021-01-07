import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker_app/models/activity.dart';
import 'package:habit_tracker_app/providers/user_activity_provider.dart';

import 'package:http/http.dart' as http;
import 'package:habit_tracker_app/models/user.dart';

class UserProvider with ChangeNotifier {
  List<User> items = [];
  List<Activity> _activityList = new List();

  final String userId;
  UserProvider(this.userId, this._activityList);

  List<User> get getUsers {
    return [...items];
  }

  List<Activity> get getUserActivities {
    return [..._activityList];
  }

  List<User> get getActiveUsers {
    return items.where((user) => user.isActiveUser).toList();
  }

  int get itemCount {
    return items.length;
  }

  User findById(String id) {
    return items.firstWhere((user) => user.id == id);
  }

  Future<void> fetchAndSetUsers() async {
    const url =
        'https://newhabittracking-default-rtdb.firebaseio.com/user.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print(extractedData);
      if (extractedData == null) {
        return null;
      }
      final List<User> loadedUsers = [];
      extractedData.forEach((userId, userData) {
        List<Activity> userActivityList = [];
        final userActivityData =
            json.decode(userData['activities']) as List<dynamic>;
        print('User Activity Data======== $userActivityData');
        userActivityData.forEach((activity) {
          userActivityList.add(Activity(
            id: activity['id'],
            name: activity['name'],
            desc: activity['desc'],
          ));
        });
        print('User Activitiy List======== $userActivityList');
        loadedUsers.add(User(
          id: userId,
          firstName: userData['firstName'],
          lastName: userData['lastName'],
          activities: userActivityList,
          isActiveUser: userData['isActiveUser'],
        ));
        print('List of loaded users: $loadedUsers');
      });
      items = loadedUsers;

      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addUser(User user) async {
    const url =
        'https://newhabittracking-default-rtdb.firebaseio.com/user.json';
    try {
      final response = await http.post(url,
          body: json.encode({
            'firstName': user.firstName,
            'lastName': user.lastName,
            'age': user.age,
            'username': user.username,
            'password': user.password,
            'activities': jsonEncode(user.activities),
            'isActiveUser': user.isActiveUser
          }));
      final newUser = User(
          id: json.decode(response.body)['name'],
          firstName: user.firstName,
          lastName: user.lastName,
          age: user.age,
          username: user.username,
          password: user.password,
          activities: user.activities,
          isActiveUser: user.isActiveUser);
      items.add(newUser);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateUser(String id, User newUser) async {
    try {
      final oldUserIndex = items.indexWhere((user) => user.id == id);
      if (oldUserIndex >= 0) {
        final url =
            'https://newhabittracking-default-rtdb.firebaseio.com/user/$id.json';
        await http.patch(url,
            body: json.encode({
              'firstName': newUser.firstName,
              'lastName': newUser.lastName,
              'age': newUser.age,
              'username': newUser.username,
              'password': newUser.password,
            }));
        items[oldUserIndex] = newUser;
        notifyListeners();
      }
    } catch (error) {
      print(error);
      throw error;
    }
  }

  void deleteUser(String id) async {
    final url =
        'https://newhabittracking-default-rtdb.firebaseio.com/user/$id.json';
    final existingUserIndex = items.indexWhere((user) => user.id == id);
    var existingUser = items[existingUserIndex];
    items.removeAt(existingUserIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      items.insert(existingUserIndex, existingUser);
      notifyListeners();
      throw Exception('Could not delete User!');
    }
    existingUser = null;
  }
}
