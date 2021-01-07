import 'package:flutter/material.dart';
import 'package:habit_tracker_app/providers/user_provider.dart';

import 'package:habit_tracker_app/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import '../../widgets/user_found_card.dart';
import '../../widgets/user_not_found_card.dart';

class User extends ChangeNotifier {
  String id;
  String name;
  String desc;
  bool isActive;

  User({
    this.id,
    this.name,
    this.desc,
    this.isActive = false,
  });
}

class TempScreen extends StatefulWidget {
  static const routeName = '/temp_acitivity';

  @override
  _TempScreenState createState() => _TempScreenState();
}

class _TempScreenState extends State<TempScreen> {
  List<User> userList = [];
  // List<User> userList = [
  //   User(id: '101', name: 'Marcelin', desc: 'Flutter'),
  //   User(id: '102', name: 'Vishruth', desc: 'Python'),
  //   User(id: '103', name: 'Harshita', desc: 'playing team sports'),
  //   User(id: '104', name: 'Bharath', desc: 'playing team sports'),
  // ];

  final userNameController = TextEditingController();
  bool _visible = false;
  Map<String, User> userMap = {};

  bool findByName(String inputName) {
    if (userMap.isEmpty) {
      userList.forEach((user) {
        userMap.putIfAbsent(user.name, () => user);
      });
    }
    return checkName(inputName);
  }

  bool checkName(String s1) {
    var result = false;
    if ((s1.length == 1) &&
        (userMap.containsKey(s1) || userMap.containsKey(s1[0].toUpperCase()))) {
      result = true;
    }
    if (s1.length > 1) {
      var t = s1[0].toUpperCase() + s1.substring(1, (s1.length));
      print(t);
      if (userMap.containsKey(s1) || userMap.containsKey(t)) {
        result = true;
      }
    }
    return result;
  }

  @override
  void dispose() {
    this.userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userList = Provider.of<UserProvider>(context).fetchAndSetUsers();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account Page'),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Name'),
              controller: userNameController,
            ),
            RaisedButton(
              child: Text('Find User'),
              color: Theme.of(context).primaryColorLight,
              onPressed: () {
                setState(() {
                  if (userNameController.text.isNotEmpty &&
                      findByName(userNameController.text)) {
                    _visible = true;
                  } else {
                    _visible = false;
                  }
                });
              },
            ),
            _visible
                ? UserFoundCard(userNameController.text)
                : UserNotFoundCard(userNameController.text),
          ],
        ),
      ),
    );
  }
}

// actions: [
//           IconButton(
//               icon: const Icon(Icons.done),
//               onPressed: () {
//                 print(selctedItem);
//                 // Navigator.pop(context);
//               })
//         ],

// child: ListView.builder(
//           itemCount: activityList.length,
//           itemBuilder: (_, i) {
//             return Card(
//                 child: CheckboxListTile(
//                     activeColor: Colors.pink[600],
//                     checkColor: Colors.yellow,
//                     selected: activityList[i].isActive,
//                     dense: true,
//                     title: Text(
//                       activityList[i].name,
//                       textAlign: TextAlign.left,
//                     ),
//                     subtitle: Text(activityList[i].desc),
//                     secondary: Icon(Icons.web),
//                     value: activityList[i].isActive,
//                     onChanged: (value) {
//                       print("object ${value}");
//                       setState(() {
//                         activityList[i].isActive = value;
//                         if (value) {
//                           selctedItem.add(activityList[i].id);
//                         } else {
//                           selctedItem.remove(activityList[i].id);
//                         }
//                       });
//                       print(activityList[i].name);
//                     }));
//           },
//         ),
