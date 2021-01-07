import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker_app/models/activity.dart';
import 'package:http/http.dart' as http;

class ActivityProvider with ChangeNotifier {
  List<Activity> activities = [];

  final String userId;

  ActivityProvider(this.userId, this.activities);

  List<Activity> get getActivities {
    return [...activities];
  }

  int get itemCount {
    return activities.length;
  }

  Activity findById(String id) {
    return activities.firstWhere((activity) => activity.id == id);
  }

  Future<void> fetchAndSetActivity() async {
    const url =
        'https://newhabittracking-default-rtdb.firebaseio.com/activities.json';
    try {
      final response = await http.get(url);
      print('MB fetchAndSetActivity Results**** ');
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Activity> loadedActivities = [];
      extractedData.forEach((actId, actData) {
        loadedActivities.add(
            Activity(id: actId, name: actData['name'], desc: actData['desc']));
      });
      activities = loadedActivities;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addActivity(Activity activity) async {
    final url =
        'https://newhabittracking-default-rtdb.firebaseio.com/activities.json';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'name': activity.name,
          'desc': activity.desc,
        }),
      );
      final newActivity = Activity(
          id: json.decode(response.body)['name'],
          name: activity.name,
          desc: activity.desc);
      activities.add(newActivity);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateActivity(String id, Activity newActivity) async {
    try {
      final oldActIndex =
          activities.indexWhere((activity) => activity.id == id);
      if (oldActIndex >= 0) {
        final url =
            'https://newhabittracking-default-rtdb.firebaseio.com/activities/$id.json';
        await http.patch(url,
            body: json.encode({
              'name': newActivity.name,
              'desc': newActivity.desc,
            }));
        activities[oldActIndex] = newActivity;
        notifyListeners();
      }
    } catch (error) {
      print(error);
      throw error;
    }
  }

  void deleteActivity(String id) async {
    final url =
        'https://newhabittracking-default-rtdb.firebaseio.com/activities/$id.json';
    final existingActivityIndex =
        activities.indexWhere((activity) => activity.id == id);
    var existingActivity = activities[existingActivityIndex];
    activities.removeAt(existingActivityIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      activities.insert(existingActivityIndex, existingActivity);
      notifyListeners();
      throw Exception('Could not delete Activity!');
    }
    existingActivity = null;
  }
}
