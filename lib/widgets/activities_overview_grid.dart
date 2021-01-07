import 'package:flutter/material.dart';
import 'package:habit_tracker_app/widgets/manage_activity_item_card.dart';
import 'package:provider/provider.dart';
import '../providers/activity_provider.dart';

class ActivityOverviewGrid extends StatelessWidget {
  final bool showYourActivities;

  ActivityOverviewGrid(this.showYourActivities);

  @override
  Widget build(BuildContext context) {
    final activityData = Provider.of<ActivityProvider>(context);
    final activities = showYourActivities ? null : activityData.activities;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: activities.length,
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: activities[i],
          child: ManageActivityItemCard(), //Text(activities[i].name),
        ),
      ),
    );
  }
}
