import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:habit_tracker_app/models/activity.dart';
import 'package:habit_tracker_app/models/user.dart';
import 'package:provider/provider.dart';
import '../../providers/activity_provider.dart';
import '../../widgets/subscribe_user_activity_item_card.dart';

class SubscribeUserActivityScreen extends StatefulWidget {
  static const routeName = '/subscribe-user-activity';

  SubscribeUserActivityScreen({@required onSelectedActivity, isSelected});

  @override
  _SubscribeUserActivityScreenState createState() =>
      _SubscribeUserActivityScreenState();
}

class _SubscribeUserActivityScreenState
    extends State<SubscribeUserActivityScreen> {
  bool isSelected = false;
  Set<Activity> selectedActivities = Set();

  void onSelectedActivity(Activity activity) {
    setState(() {
      if (selectedActivities.contains(activity)) {
        selectedActivities.remove(activity);
      } else {
        selectedActivities.add(activity);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final activityData = Provider.of<ActivityProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscribe for activities'),
        actions: [
          IconButton(
              icon: const Icon(Icons.done),
              onPressed: () {
                List<Activity> selectedAct = selectedActivities.toList();
                print(
                    'In subscriberActivityScreen selectedAct tostring${selectedAct.toString()}');
                Navigator.pop(context, selectedAct);
              })
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: activityData.activities.length,
          itemBuilder: (_, i) {
            return ChangeNotifierProvider.value(
                value: activityData.activities[i],
                child: SubscribeUserActivityItemCard(
                  activity: activityData.activities[i],
                  onSelectedActivity: onSelectedActivity,
                  isSelected:
                      selectedActivities.contains(activityData.activities[i]),
                ));
          },
        ),
      ),
    );
  }
}
