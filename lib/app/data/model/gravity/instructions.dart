import 'package:flutter/foundation.dart';

class Instructions {
  String name,id;
  String instructions;
  Instructions(this.id,this.name,this.instructions);

  factory Instructions.fromJSON(Map<String,dynamic> json)
  {
    if (kDebugMode) {
      print(json);
    }
    return Instructions(json['_id'],json['name'],json['instructions']);
  }

  @override
  String toString()
  {
    return name;
  }
}
