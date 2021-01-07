import 'package:flutter/material.dart';
import 'package:habit_tracker_app/models/activity.dart';

class SubscribeUserActivityItemCard extends StatelessWidget {
  final Activity activity;
  bool isSelected = false;
  final Function(Activity) onSelectedActivity;
  SubscribeUserActivityItemCard(
      {@required this.activity,
      @required this.onSelectedActivity,
      this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: CheckboxListTile(
            activeColor: Colors.pink[600],
            checkColor: Colors.yellow,
            selected: isSelected,
            dense: true,
            title: Text(
              activity.name,
              textAlign: TextAlign.left,
            ),
            subtitle: Text(activity.desc),
            secondary: Icon(Icons.access_time),
            value: isSelected,
            onChanged: (value) {
              print("$activity **In  card widget: $value");
              onSelectedActivity(activity);
            }));
  }
}
