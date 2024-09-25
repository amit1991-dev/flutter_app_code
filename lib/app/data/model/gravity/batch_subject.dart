import 'package:flutter/foundation.dart';
import 'package:getx/app/data/model/gravity/academic_file.dart';
import 'package:getx/app/data/model/gravity/batch.dart';

import 'file.dart';

// class Lecture {
//   late String name, id, mediaURL, channelID, faculties, timestamp, description;
//   String? liveLecturePath, livePlaybackPath, cloudflareLiveInputId;
//   bool classTerminated = false, liveStatus = false;
//   List<AcademicFile> files = [];
//   // Lecture(this.name,this.id);

//   Lecture.fromJSON(Map<String, dynamic> json) {
//     print("building started");
//     name = json['name'];
//     print(1);
//     id = json["_id"];
//     print(12);
//     mediaURL = json['media'] ?? "-";
//     channelID = json['channel']??"-";
//     print(13);
//     faculties = json['faculties'];
//     print(14);
//     timestamp = json['timestamp'];
//     print(15);
//     description = json['description'];
//     print(16);

//     liveLecturePath = json['live_lecture_path'];
//     print(1);

//     livePlaybackPath = json['live_play_back_path'];
//     print(1);

//     liveStatus = json['live_status']??false;

//     classTerminated = json['class_terminated']??false;
//     // cloudflareLiveInputId = json["cloudflare_live_input_id"];

//     if (json.containsKey('files')) {
//       for (var file in json['files']) {
//         files.add(AcademicFile.fromJSON(file));
//       }
//     }

//     print("building ended");
//   }

//   @override
//   String toString() {
//     return name;
//   }
// }

// import 'batch_chapter.dart';

// class BatchSubject {
//   late String id;
//   late String subjectId;
//   // List<String> chapters;
//   List<BatchChapter> batchchapters = [];

// BatchSubject({
//   required this.id,
//   required this.subjectId,
//   required this.batchchapters,
// });

//   factory BatchSubject.fromJSON(Map<String, dynamic> json) {
//     return BatchSubject(
//       id: json["_id"],
//       subjectId: json['subjectId'],
//       batchchapters: List<BatchChapter>.from(json['chapters'] ?? []),
//     );
//   }
// }

import 'batch_chapter.dart';


class BatchSubject {
  late String id;
  late String subjectId;
  late String name;
  // List<BatchChapter> chapters = [];
  
  

  // List<String> chaptercounts= [];

  BatchSubject.fromJSON(Map<String, dynamic> json) {
    print('start-batch_subject');
    print(json);
    id = json["_id"];
    subjectId = json['subjectId']['_id'];
    name = json['subjectId']['name'];
    print(name);

 

    
    // print("chapterwisetest:$chapterWiseTests");
    // print("building chapterwise tests");
    // if (json.containsKey('chapter_wise_tests')) {
    //   
    // print("chapterwisetests: $chapterWiseTests");

    // chaptercounts = List<String>.from(json['chapters']);
  // print("building chapters");
  //     if (json.containsKey('chapters')) {
  //       for (var chapter in json['chapters']) {
  //         chapters.add(BatchChapter.fromJSON(chapter));
  //       }
  //     }

    print("building ended");
  }


}
