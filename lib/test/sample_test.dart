import 'package:habit_tracker_app/providers/activity_provider.dart';
import 'package:habit_tracker_app/providers/user_provider.dart';

void main() {
  // UserProvider up = UserProvider('', []);
  // var t = up.fetchAndSetUsers();
  ActivityProvider ap = ActivityProvider('', []);
  var t = ap.fetchAndSetActivity();
  print(t);
}
