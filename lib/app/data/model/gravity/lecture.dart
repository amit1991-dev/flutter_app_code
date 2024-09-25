import 'package:flutter/foundation.dart';
import 'package:getx/app/data/model/gravity/academic_file.dart';

import 'file.dart';

class Lecture {
  late String name, id, mediaURL, channelID, faculties, timestamp, description;
  String? liveLecturePath, livePlaybackPath, cloudflareLiveInputId;
  bool classTerminated = false, liveStatus = false;
  List<AcademicFile> files = [];
  List<Lecture> lectures = [];
  List<AcademicFile> module_files = [];


  // Lecture(this.name,this.id);

  Lecture.fromJSON(Map<String, dynamic> json) {
    print("building LECTURE started");
    name = json['name'] ?? "NULL";
    print(1);
    print('kya hai name $name ');
    id = json["_id"];
    print(id);
    print(12);
    mediaURL = json['media'] ?? "NULL";
    print(mediaURL);
    channelID = json['channel'] ?? "NULL";
    print(channelID);
    print(13);
    faculties = json['faculties'] ?? "NULL";
    print(faculties);
    print(14);
    timestamp = json['timestamp'] ?? "";
    print(15);
    description = json['description'] ?? "";
    print(16);

    liveLecturePath = json['live_lecture_path'];
    print(1);

    livePlaybackPath = json['live_play_back_path'];
    print(1);

    liveStatus = json['live_status'] ?? false;

    classTerminated = json['class_terminated'] ?? false;
    // cloudflareLiveInputId = json["cloudflare_live_input_id"];

    print("golu-files");
    if (json.containsKey('files')) {
      for (var file in json['files']) {
        files.add(AcademicFile.fromJSON(file));
      }
    }
print("golu-lectures");
    if (json.containsKey('lectures')) {
      for (var lecture in json['lectures']) {
        lectures.add(Lecture.fromJSON(lecture));
      }
    }
        print("golu-module-files");
    if (json.containsKey('module_files')) {
      for (var module_file in json['module_files']) {
        module_files.add(AcademicFile.fromJSON(module_file));
      }
    }

    print("building ended");
  }

  @override
  String toString() {
    return name;
  }
}
