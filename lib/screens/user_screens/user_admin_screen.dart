import 'package:flutter/material.dart';
import 'package:habit_tracker_app/models/user.dart';
import 'package:provider/provider.dart';
import 'package:habit_tracker_app/widgets/user_item_card.dart';
import '../../providers/user_provider.dart';

class UserAdminScreen extends StatefulWidget {
  static const routeName = '/user-admin';
  @override
  _UserAdminCardState createState() => _UserAdminCardState();
}

class _UserAdminCardState extends State<UserAdminScreen> {
  var _isInit = true;
  List<User> userList = [];

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<UserProvider>(context).fetchAndSetUsers();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('User Admin Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: users.items.length,
          itemBuilder: (_, i) {
            return ChangeNotifierProvider.value(
                value: users.items[i],
                child: UserItemCard(
                  users.items[i],
                ));
          },
        ),
      ),
    );
  }
}
