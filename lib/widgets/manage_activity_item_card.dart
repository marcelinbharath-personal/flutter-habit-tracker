import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/activity_provider.dart';
import '../models/activity.dart';
import '../screens/activity_screens/edit_activity_screen.dart';

class ManageActivityItemCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final activityItem = Provider.of<Activity>(context, listen: false);
    return Dismissible(
      key: ValueKey(activityItem.id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 20,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to remove the activity?'),
            actions: [
              FlatButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                  child: Text('Yes'),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  })
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<ActivityProvider>(context, listen: false)
            .deleteActivity(activityItem.id);
      },
      child: Card(
        child: ListTile(
          title: Text(
            activityItem.name,
            textAlign: TextAlign.left,
          ),
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColorLight,
            // backgroundImage: AssetImage('assets/icons8-reading-100.png'),
          ),
          trailing: Container(
            width: 100,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                        EditActivityScreen.routeName,
                        arguments: activityItem.id);
                  },
                  color: Theme.of(context).primaryColor,
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    Provider.of<ActivityProvider>(context, listen: false)
                        .deleteActivity(activityItem.id);
                  },
                  color: Theme.of(context).errorColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
