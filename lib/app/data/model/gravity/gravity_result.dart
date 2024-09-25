import 'package:flutter/foundation.dart';

class GravityResult {
  String name,id,url;
  GravityResult(this.name,this.id,this.url);

  factory GravityResult.fromJSON(Map<String,dynamic> json)
  {
    print("Subject");
    return GravityResult(json['name'],json['_id'],json['url']);
  }

  @override
  String toString()
  {
    return name;
  }
}
