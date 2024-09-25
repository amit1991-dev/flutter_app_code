import 'package:flutter/foundation.dart';

class MarkingScheme {
  String name,id;
  int positiveMarks,negativeMarks;
  MarkingScheme(this.id,this.name,this.positiveMarks,this.negativeMarks);

  factory MarkingScheme.fromJSON(Map<String,dynamic> json)
  {
    return MarkingScheme(json['_id'],json['name'],json['positive_marks'],json['negative_marks']);
  }

  @override
  String toString()
  {
    return name;
  }
}
