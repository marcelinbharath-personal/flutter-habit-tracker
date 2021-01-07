import 'package:flutter/material.dart';
import 'package:habit_tracker_app/models/user.dart';

class UserItemCard extends StatelessWidget {
  final User user;

  UserItemCard(this.user);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          user.firstName + ' ' + user.lastName,
          textAlign: TextAlign.left,
        ),
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColorLight,
        ),
        trailing: Container(
          width: 100,
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () =>
                    print('${user.isActiveUser}****${user.activities}'),
                color: Theme.of(context).primaryColor,
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {},
                color: Theme.of(context).errorColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
