import 'package:flutter/material.dart';
import 'package:habit_tracker_app/models/activity.dart';
import 'package:habit_tracker_app/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:habit_tracker_app/providers/activity_provider.dart';
import 'package:habit_tracker_app/providers/user_activity_provider.dart';
import 'package:habit_tracker_app/screens/activity_screens/manage_activity_screen.dart';
import './screens/my_home_page_screen.dart';
import 'screens/activity_screens/edit_activity_screen.dart';
import 'screens/activity_screens/activity_overview_screen.dart';
import 'screens/user_screens/subscribe_user_activity_screen.dart';
import 'screens/user_screens/register_user_screen.dart';
import 'screens/user_screens/temp_screen.dart';
import 'screens/user_screens/user_admin_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ActivityProvider>(
          create: (context) => ActivityProvider('', []),
        ),
        ChangeNotifierProvider<UserProvider>(
            create: (context) => UserProvider('', [])),
        ChangeNotifierProvider<UserActivityProvider>(
            create: (context) => UserActivityProvider()),
      ],
      child: MaterialApp(
        title: 'Habit Tracking',
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
          accentColor: Colors.deepOrange,
          errorColor: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePageScreen(),
        routes: {
          MyHomePageScreen.routeName: (ctx) => MyHomePageScreen(),
          ManageActivityScreen.routeName: (ctx) => ManageActivityScreen(),
          EditActivityScreen.routeName: (ctx) => EditActivityScreen(),
          ActivityOverviewScreen.routeName: (ctx) => ActivityOverviewScreen(),
          SubscribeUserActivityScreen.routeName: (ctx) =>
              SubscribeUserActivityScreen(
                isSelected: false,
                onSelectedActivity: null,
              ),
          RegisterUserScreen.routeName: (ctx) => RegisterUserScreen(),
          TempScreen.routeName: (ctx) => TempScreen(),
          UserAdminScreen.routeName: (ctx) => UserAdminScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
