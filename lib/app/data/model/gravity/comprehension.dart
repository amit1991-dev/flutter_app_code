import 'package:flutter/foundation.dart';

class Comprehension {
  String name,id,content;
  Comprehension(this.name,this.id,this.content);

  factory Comprehension.fromJSON(Map<String,dynamic> json)
  {
    print(json['name']);
    print(json['_id']);

    return Comprehension(json['name'],json['_id'],json['content']);
  }

  @override
  String toString()
  {
    return name;
  }
}
