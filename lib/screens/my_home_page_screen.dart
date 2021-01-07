import 'package:flutter/material.dart';
import 'package:habit_tracker_app/widgets/app_drawer.dart';

class MyHomePageScreen extends StatelessWidget {
  static const routeName = '/home_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Habit Tracker Home Page'),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Text(
          'Welcome to Habit Tracker!',
          style: Theme.of(context).textTheme.headline4,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
