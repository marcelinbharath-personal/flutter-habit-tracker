import 'package:flutter/material.dart';

class UserNotFoundCard extends StatelessWidget {
  final String userName;

  UserNotFoundCard(this.userName);

  @override
  Widget build(BuildContext context) {
    return Card(child: Text('$userName NOT Found!!!'));
  }
}
