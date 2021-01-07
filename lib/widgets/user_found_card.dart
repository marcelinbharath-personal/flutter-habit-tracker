import 'package:flutter/material.dart';

class UserFoundCard extends StatelessWidget {
  final String userName;

  UserFoundCard(this.userName) {
    print('Insid userfoundcard build: $userName');
  }

  @override
  Widget build(BuildContext context) {
    print('Insid userfoundcard build 2: $userName');
    return Card(
        child: Text(
      '$userName Found ',
      style: TextStyle(fontSize: 28),
      textAlign: TextAlign.center,
    ));
  }
}
