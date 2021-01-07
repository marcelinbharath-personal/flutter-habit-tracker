import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker_app/models/activity.dart';

class UserActivity {
  // final String id;
  // final List<Activity> activities;
  // final Datetime datetime;
  // final int duration;
}

class UserActivityProvider with ChangeNotifier {
  Map<String, Activity> _activityItems;

  Map<String, Activity> get getActivityItems {
    return {..._activityItems};
  }

  void addActivityItem(String userId, Activity activity) {
    if (_activityItems.containsKey(userId)) {
      _activityItems.update(userId, (existingActivity) => activity);
      // uncomment below if needed
      // _activityItems.update(
      //     userId,
      //     (existingActivity) => Activity(
      //         id: existingActivity.id,
      //         name: existingActivity.name,
      //         desc: existingActivity.desc));
    } else {
      _activityItems.putIfAbsent(userId, () => activity);
    }
  }
}
