import 'package:flutter/foundation.dart';

class Package {
  String name,id;
  Package(this.name,this.id);

  factory Package.fromJSON(Map<String,dynamic> json)
  {
    print(json['name']);
    print(json['_id']);

    return Package(json['name'],json['_id']);
  }

  @override
  String toString()
  {
    return this.name;
  }
}
