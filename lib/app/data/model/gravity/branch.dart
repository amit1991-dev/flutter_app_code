import 'package:flutter/foundation.dart';

class Branch {
  String name,id;
  Branch(this.name,this.id);

  factory Branch.fromJSON(Map<String,dynamic> json)
  {
    print(json['name']);
    print(json['_id']);

    return Branch(json['name'],json['_id']);
  }

  @override
  String toString()
  {
    return this.name;
  }
}
