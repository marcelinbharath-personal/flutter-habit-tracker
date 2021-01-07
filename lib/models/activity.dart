import 'package:flutter/foundation.dart';

class Activity extends ChangeNotifier {
  String id;
  String name;
  String desc;

  Activity({
    this.id,
    this.name,
    this.desc,
  });

  void toggleUserActivity(String userId) async {}

// This is basically jsonEncoding i.e Serialization, converting map to activity instance.
// Here a map is converted to an activity object
  Activity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    desc = json['desc'];
  }

  Map toJson() => {
        'id': id,
        'name': name,
        'desc': desc,
      };

  @override
  String toString() {
    return ('Id: $id , Name: $name, Description: $desc');
  }
}
