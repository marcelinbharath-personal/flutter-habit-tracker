import 'package:flutter/material.dart';
import 'package:habit_tracker_app/screens/activity_screens/activity_overview_screen.dart';
import 'package:habit_tracker_app/screens/user_screens/subscribe_user_activity_screen.dart';
import 'package:habit_tracker_app/screens/user_screens/temp_screen.dart';
import '../screens/my_home_page_screen.dart';
import '../screens/activity_screens/manage_activity_screen.dart';
import '../screens/user_screens/register_user_screen.dart';
import '../screens/user_screens/temp_screen.dart';
import '../screens/user_screens/user_admin_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Hello Friend!'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
              leading: Icon(Icons.home),
              title: Text('Home Page'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(MyHomePageScreen.routeName);
                // Navigator.pop(context);
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.person_add),
              title: Text('Register New User'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(RegisterUserScreen.routeName);
                // Navigator.pop(context);
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.local_activity),
              title: Text('Manage All Activities'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(ManageActivityScreen.routeName);
                // Navigator.pop(context);
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.local_activity),
              title: Text('Activity Overview'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(ActivityOverviewScreen.routeName);
                // Navigator.pop(context);
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.screen_lock_landscape),
              title: Text('Temp Screen'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(TempScreen.routeName);
                // Navigator.pop(context);
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.screen_lock_landscape),
              title: Text('User Admin Screen'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(UserAdminScreen.routeName);
                // Navigator.pop(context);
              }),
        ],
      ),
    );
  }
}
