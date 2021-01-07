import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker_app/widgets/app_drawer.dart';
import '../../providers/activity_provider.dart';
import '../../widgets/manage_activity_item_card.dart';
import 'edit_activity_screen.dart';

class ManageActivityScreen extends StatelessWidget {
  static const routeName = 'manage_activity';
  @override
  Widget build(BuildContext context) {
    final activityData = Provider.of<ActivityProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Activity Screen'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditActivityScreen.routeName);
            },
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: activityData.activities.length,
          itemBuilder: (_, i) {
            //this is model/activity's CNP
            return ChangeNotifierProvider.value(
              value: activityData.activities[i],
              child: ManageActivityItemCard(),
            );
          },
        ),
      ),
    );
  }
}
