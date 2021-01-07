import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:habit_tracker_app/widgets/app_drawer.dart';
import '../../providers/activity_provider.dart';
import '../../widgets/activities_overview_grid.dart';

enum FilterOptions { YourActivities, AllActivities }

class ActivityOverviewScreen extends StatefulWidget {
  static const routeName = '/activitiy-overview';

  @override
  _ActivityOverviewScreenState createState() => _ActivityOverviewScreenState();
}

class _ActivityOverviewScreenState extends State<ActivityOverviewScreen> {
  var _showYourActivities = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ActivityProvider>(context).fetchAndSetActivity().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activity Overview Page'),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.YourActivities) {
                  _showYourActivities = true;
                } else {
                  _showYourActivities = false;
                }
              });
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Your Activites'),
                value: FilterOptions.YourActivities,
              ),
              PopupMenuItem(
                child: Text('All Activities'),
                value: FilterOptions.AllActivities,
              ),
            ],
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ActivityOverviewGrid(_showYourActivities),
    );
  }
}
