// import 'package:flutter/foundation.dart';
// import 'package:getx/app/data/model/gravity/chapter_wise_tests.dart';
// import 'package:getx/app/data/model/gravity/module.dart';
// import 'package:getx/app/data/model/gravity/stream.dart';
// import 'package:getx/app/data/model/gravity/test_with_sections.dart';

// import 'academic_file.dart';
// import 'branch.dart';
// import 'file.dart';
// import 'lecture.dart';
// //golu
// import 'batch_chapter.dart';
// import 'batch_subject.dart';

// class Batch {
//   late String name, id;
//   late GravityStream stream;
//   late Branch branch;
//   List<Lecture> lectures = [];
//   List<AcademicFile> files = [];
//   List<TestWithSections> tests = [];
//   List<TestWithSections> chapterWiseTests = [];

//   List<Module> modules = [];
//   // List<ChapterWiseTest> chapterwisetests = [];

//   // List<String> batchsubjects = [];
//   // List<String> chapterwisetests = [];

//   // Batch(this.name,this.id);
//   // List<BatchChapter> batchchapters = [];
//   // List<BatchSubject> subjects = [];

//   Batch.fromJSON(Map<String, dynamic> json, {bool full = false}) {
//     print('start-batch_chapterwise_test');
//     print(json);

//     // name = json['name'];
//     // id = json["_id"];
//     name = json['name'] != null ? json['name'] : ''; // Assign an empty string if null
// id = json["_id"] != null ? json["_id"] : ''; // Assign an empty string if null

//     stream = GravityStream.fromJSON(json['stream']);
//     branch = Branch.fromJSON(json['branch']);

//     // batchsubjects = List<String>.from(json['batch_subjects']);
//     // chapterwisetests = List<String>.from(json['chapter_wise_tests']);

//     // print("batchsubject:$batchsubjects");

//     if (full) {
//       print("inside full batch");
//       print("building lectures");
//       if (json.containsKey('lectures')) {
//         for (var lecture in json['lectures']) {
//           lectures.add(Lecture.fromJSON(lecture));
//         }
//       }
//       print("building tests");
//       if (json.containsKey('tests')) {
//         for (var test in json['tests']) {
//           tests.add(TestWithSections.fromJSON(test, false));
//         }
//       }

//       print("building modules");
//       if (json.containsKey('modules')) {
//         for (var module in json['modules']) {
//           modules.add(Module.fromJSON(module, full: false));
//         }
//       }
//       print("building files");
//       if (json.containsKey('files')) {
//         for (var file in json['files']) {
//           files.add(AcademicFile.fromJSON(file));
//         }
//       }
//       print("golu-chapterwise_tests");
//       print("chapterwisetest:$chapterWiseTests");
//       print("building chapterwise tests");
//       if (json.containsKey('chapter_wise_tests')) {
//         for (var chapterWiseTest in json['chapter_wise_tests']) {
//           chapterWiseTests
//               .add(TestWithSections.fromJSON(chapterWiseTest, true));
//         }
//       }
//       print("chapterwisetests: $chapterWiseTests");

// //batch_subjects
//       // print("building batch subjects");
//       // if (json.containsKey('batch_subjects')) {
//       //   for (var batchsubject in json['batch_subjects']) {
//       //     batchsubjects.add(BatchSubject.fromJSON(batchsubject));
//       //   }
//       // }
//       //    print("building chapterwise tests");

//       //   if (json.containsKey('chapter_wise_tests')) {
//       //     for (var chapterwisetest in json['chapter_wise_tests']) {
//       //       chapterwisetests.add(ChapterWiseTest.fromJSON(chapterwisetest));
//       //     }
//       //   }
//       // print(chapterwisetests);
//       //   print("building ended");
//     }
//   }

//   @override
//   String toString() {
//     return this.name;
//   }
// }

import 'package:flutter/foundation.dart';

import 'package:getx/app/data/model/gravity/module.dart';
import 'package:getx/app/data/model/gravity/stream.dart';
import 'package:getx/app/data/model/gravity/test_with_sections.dart';
import 'package:getx/app/data/model/gravity/dpp_test_with_sections.dart';

import 'academic_file.dart';
import 'branch.dart';
import 'file.dart';
import 'lecture.dart';
//golu
import 'batch_chapter.dart';
import 'batch_subject.dart';

class Batch {
  late String name, id;
  late GravityStream? stream;
  late Branch? branch;
  List<Lecture> lectures = [];
  List<AcademicFile> files = [];
  List<TestWithSections> tests = [];
  List<TestWithSections> chapterWiseTests = [];
  List<DppTestWithSections> dppTests = [];

  List<Module> modules = [];

  List<BatchSubject> batchsubjects = [];

  // List<dynamic>? testcountes= [];


  Batch.fromJSON(Map<String, dynamic> json, {bool full = false}) {
    print('start-batch_dpp_test');
    print(json);

    // name = json['name'];
    // id = json["_id"];
    name = json['name'] != null
        ? json['name']
        : 'ssddffffffff'; // Assign an empty string if null
    id = json["_id"] != null
        ? json["_id"]
        : 'anbbgfhfghhf'; // Assign an empty string if null

    // stream = GravityStream.fromJSON(json['stream']);
    // branch = Branch.fromJSON(json['branch']);
    stream = json.containsKey('stream') && json['stream'] != null
        ? GravityStream.fromJSON(json['stream'])
        : null;
    branch = json.containsKey('branch') && json['branch'] != null
        ? Branch.fromJSON(json['branch'])
        : null;

    // batchsubjects = List<String>.from(json['batch_subjects']);
    // chapterwisetests = List<String>.from(json['chapter_wise_tests']);
    // testcountes = List<dynamic>.from(json['tests']); //this added for counting tests

    // print("batchsubject:$batchsubjects");

    if (full) {
      print("inside full batch");
      print("building lectures");
      if (json.containsKey('lectures')) {
        for (var lecture in json['lectures']) {
          lectures.add(Lecture.fromJSON(lecture));
        }
      }
      print("building tests");
      if (json.containsKey('tests')) {
        for (var test in json['tests']) {
          tests.add(TestWithSections.fromJSON(test, false));
        }
      }

      print("building modules");
      if (json.containsKey('modules')) {
        for (var module in json['modules']) {
          modules.add(Module.fromJSON(module, full: false));
        }
      }
      print("building files");
      if (json.containsKey('files')) {
        for (var file in json['files']) {
          files.add(AcademicFile.fromJSON(file));
        }
      }
      print("golu-chapterwise_tests");
      print("chapterwisetest:$chapterWiseTests");
      print("building chapterwise tests");
      if (json.containsKey('chapter_wise_tests')) {
        for (var chapterWiseTest in json['chapter_wise_tests']) {
          chapterWiseTests
              .add(TestWithSections.fromJSON(chapterWiseTest, false));
        }
      }
      print("chapterwisetests: $chapterWiseTests");

      print("building dpp tests");
      if (json.containsKey('dpp_tests')) {
        for (var dppTest in json['dpp_tests']) {
          dppTests.add(DppTestWithSections.fromJSON(dppTest, false));
        }
      }
      print("dpptests: $dppTests");
      print("dppTests length: ${dppTests.length}");

// batch_subjects
      print("building batch subjects");
      if (json.containsKey('batch_subjects')) {
        for (var batchsubject in json['batch_subjects']) {
          batchsubjects.add(BatchSubject.fromJSON(batchsubject));
        }
      }
      //    print("building chapterwise tests");

      print("building ended");
    }
  }

  @override
  String toString() {
    return this.name;
  }
}
