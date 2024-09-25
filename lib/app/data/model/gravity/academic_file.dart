import 'package:flutter/foundation.dart';
import 'package:getx/app/data/model/gravity/module.dart';
import 'package:getx/app/data/model/gravity/stream.dart';
import 'package:getx/app/data/model/gravity/test_with_sections.dart';

import 'branch.dart';
import 'file.dart';
import 'lecture.dart';

class AcademicFile {
  late String name,id,contentType;
  late GravityFile file;
  // Batch(this.name,this.id);

  AcademicFile.fromJSON(Map<String,dynamic> json)
  {
    print(json);
    name= json['name']??"-";
    id= json["_id"];
    print(1);
    // url = json['url'];
    contentType = json['content_type'];
    print(1);
    if(json.containsKey("file")){
      file = GravityFile.fromJSON(json['file']);
    }
   //  stream =GravityStream.fromJSON( json['stream']);
   //  branch =Branch.fromJSON( json['branch']);
   // if(full){
   //   print("inside full batch");
   //   print("building lectures");
   //   if(json.containsKey('lectures')){
   //     for(var lecture in json['lectures']){
   //       lectures.add(Lecture.fromJSON(lecture));
   //     }
   //   }
   //   print("building tests");
   //   if(json.containsKey('tests')){
   //     for(var test in json['tests']){
   //       tests.add(TestWithSections.fromJSON(test,false));
   //     }
   //   }
   //
   //   print("building modules");
   //   if(json.containsKey('modules')){
   //     for(var module in json['modules']){
   //       modules.add(Module.fromJSON(module,full: false));
   //     }
   //   }
   //   print("building files");
   //   if(json.containsKey('files')){
   //     for(var file in json['files']){
   //       files.add(GravityFile.fromJSON(file));
   //     }
   //   }
   // }

  }

  @override
  String toString()
  {
    return name;
  }
}
