import 'package:flutter/foundation.dart';
import 'package:getx/app/data/model/gravity/module.dart';
import 'package:getx/app/data/model/gravity/stream.dart';

import 'academic_file.dart';
import 'branch.dart';
import 'file.dart';
import 'lecture.dart';
//golu
// import 'batch_chapter.dart';
import 'batch_subject.dart';
import 'lecture.dart';


// class BatchChapter {
//   late String id;
//   late String chapterId;
//   // List<String> lectures;
//   // List<String> files;
//   // List<String> moduleFiles;
//   List<Lecture> lectures = [];
//   List<AcademicFile> files = [];
//   List<AcademicFile> moduleFiles = [];

//   BatchChapter({
//     required this.id,
//     required this.chapterId,
//     required this.lectures,
//     required this.files,
//     required this.moduleFiles,
//   });

//   factory BatchChapter.fromJSON(Map<String, dynamic> json) {
//     return BatchChapter(
//       id:json["_id"],
//       chapterId: json['chapterId'],
//       lectures: List<Lecture>.from(json['lectures'] ?? []),
//       files: List<AcademicFile>.from(json['files'] ?? []),
//       moduleFiles: List<AcademicFile>.from(json['module_files'] ?? []),
//     );
//   }
// }

class BatchChapter {
  late String id;
  late String chapterId;
late String name;
  // List<String> lectures;
  // List<String> files;
  // List<String> moduleFiles;
  // List<Lecture> lectures = [];
  // List<AcademicFile> files = [];
  // List<AcademicFile> moduleFiles = [];


  // BatchChapter({
  //   required this.id,
  //   required this.chapterId,
  //   required this.lectures,
  //   required this.files,
  //   required this.moduleFiles,
  // });

  // BatchChapter.fromJSON(Map<String, dynamic> json, {bool full = false}) {
  BatchChapter.fromJSON(Map<String, dynamic> json) {

    id = json["_id"];
    chapterId = json['chapterId']["_id"];
    name=json['chapterId']['name'];

    // if (full) {
    //   print("inside full batch");
    //   print("building lectures");
    //   if (json.containsKey('lectures')) {
    //     for (var lecture in json['lectures']) {
    //       lectures.add(Lecture.fromJSON(lecture));
    //     }
    //   }
    

    //   print("building modules");
    //   if (json.containsKey('modules')) {
    //     for (var module in json['modules']) {
    //       moduleFiles.add(AcademicFile.fromJSON(module));
    //     }
    //   }
    
    

      
    // }
    // lectures = List<Lecture>.from(json['lectures'] ?? []);
    // files = List<AcademicFile>.from(json['files'] ?? []);
    // moduleFiles = List<AcademicFile>.from(json['module_files'] ?? []);
  }
}
