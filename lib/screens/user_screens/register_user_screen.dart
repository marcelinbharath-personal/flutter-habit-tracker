import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:habit_tracker_app/models/activity.dart';
import 'package:habit_tracker_app/providers/activity_provider.dart';
import 'package:habit_tracker_app/providers/user_provider.dart';
import 'package:habit_tracker_app/screens/user_screens/subscribe_user_activity_screen.dart';
import 'package:habit_tracker_app/widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import '../../models/user.dart';

class RegisterUserScreen extends StatefulWidget {
  static const routeName = 'register-user';

  @override
  _RegisterUserScreenState createState() => _RegisterUserScreenState();
}

class _RegisterUserScreenState extends State<RegisterUserScreen> {
  final _regUserForm = GlobalKey<FormState>();
  final _firstNameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();
  final _ageFocusNode = FocusNode();
  final _userNameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  var _editedUser = User(id: null, firstName: '', lastName: '', activities: []);

  var _newUser = {
    'id': null,
    'firstName': '',
    'lastName': '',
    'age': 0,
    'username': '',
    'password': '',
    'activities': [],
    'isActiveUser': false
  };

  @override
  void dispose() {
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _ageFocusNode.dispose();
    _userNameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _saveForm() async {
    _regUserForm.currentState.save();
    print('Inside save form firstName: ${_editedUser.firstName} ');
    print('Inside save form lastName: ${_editedUser.lastName} ');
    print('Inside save form activities: ${_editedUser.activities}, ');
    try {
      await Provider.of<UserProvider>(context, listen: false)
          .addUser(_editedUser);
    } catch (error) {
      print('Error adding User');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register User Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveForm();
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Form(
                key: _regUserForm,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Firstname',
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a first name.';
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_lastNameFocusNode);
                      },
                      onSaved: (value) {
                        _editedUser = User(
                            id: _editedUser.id,
                            firstName: value,
                            lastName: _editedUser.lastName,
                            age: _editedUser.age,
                            username: _editedUser.username,
                            activities: _editedUser.activities,
                            isActiveUser: _editedUser.isActiveUser);
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Lastname',
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a last name.';
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_ageFocusNode);
                      },
                      onSaved: (value) {
                        _editedUser = User(
                            id: _editedUser.id,
                            firstName: _editedUser.firstName,
                            lastName: value,
                            age: _editedUser.age,
                            username: _editedUser.username,
                            activities: _editedUser.activities,
                            isActiveUser: _editedUser.isActiveUser);
                      },
                    ),
                  ],
                ),
              ),
              RaisedButton(
                child: Text('Subscribe User Activities'),
                color: Theme.of(context).primaryColorLight,
                onPressed: () async {
                  final result = await Navigator.of(context)
                      .pushNamed(SubscribeUserActivityScreen.routeName);
                  print('In Reg user: ' + result.toString());
                  _editedUser = User(
                      id: _editedUser.id,
                      firstName: _editedUser.firstName,
                      lastName: _editedUser.lastName,
                      age: _editedUser.age,
                      username: _editedUser.username,
                      activities: result,
                      isActiveUser: _editedUser.isActiveUser);
                },
              ),
            ],
          )),
    );
  }
}
