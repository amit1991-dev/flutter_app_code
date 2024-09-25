import 'package:flutter/foundation.dart';
import 'package:getx/app/data/model/gravity/question.dart';
import 'package:getx/app/data/model/gravity/stream.dart';
import 'package:getx/app/data/model/gravity/subject.dart';
import 'package:getx/app/data/model/gravity/test_with_sections.dart';

import 'branch.dart';
import 'file.dart';
import 'lecture.dart';

class ModuleChapter {
  late String name,id;
  List<Question> level_1 = [];
  List<Question> level_2 = [];
  List<Question> level_3 = [];

  ModuleChapter.fromJSON(Map<String,dynamic> json,{bool full = false})
  {
    name= json['name'];
    id= json["_id"];
    if(full){
      if(json.containsKey("level_1")){
        for(var i in json['level_1']){
          level_1.add(Question.fullFromJSON(i));
        }
      }

      if(json.containsKey("level_2")){
        for(var i in json['level_2']){
          level_2.add(Question.fullFromJSON(i));
        }
      }

      if(json.containsKey("level_3")){
        for(var i in json['level_3']){
          level_3.add(Question.fullFromJSON(i));
        }
      }
    }
   }

  @override
  String toString()
  {
    return name;
  }
}
