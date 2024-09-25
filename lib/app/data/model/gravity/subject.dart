import 'package:flutter/foundation.dart';

class Subject {
  String name,id;
  Subject(this.name,this.id);

  factory Subject.fromJSON(Map<String,dynamic> json)
  {
    print("Subject");
    return Subject(json['name'],json['_id']);
  }

  @override
  String toString()
  {
    return name;
  }
}
