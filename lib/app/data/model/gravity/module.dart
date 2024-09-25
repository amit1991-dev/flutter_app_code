import 'package:flutter/foundation.dart';
import 'package:getx/app/data/model/gravity/stream.dart';
import 'package:getx/app/data/model/gravity/subject.dart';
import 'package:getx/app/data/model/gravity/test_with_sections.dart';

import 'branch.dart';
import 'file.dart';
import 'lecture.dart';
import 'module_chapter.dart';

class Module {
  late String name,id,classNumber;
  late Subject subject;
  List<ModuleChapter> moduleChapters=[];

  Module.fromJSON(Map<String,dynamic> json,{bool full = false})
  {
    print("creating modules");
    name= json['name'];
    id= json["_id"];
    if(json.containsKey("chapters")){
      print("Creating module chapters");
      for(var i in json['chapters']){
        moduleChapters.add(ModuleChapter.fromJSON(i,full:full));
      }
    }
   }

  @override
  String toString()
  {
    return this.name;
  }
}
