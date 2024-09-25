import 'dart:convert';

import 'package:get/get.dart';
import 'package:getx/app/data/model/gravity/batch.dart';
import 'package:getx/app/data/model/gravity/batch_chapter.dart';
import 'package:getx/app/data/model/gravity/batch_subject.dart';

import 'package:getx/app/data/model/gravity/lecture.dart';
import 'package:getx/app/data/model/gravity/question.dart';
import 'package:getx/app/data/model/gravity/result.dart';
import 'package:getx/app/data/model/gravity/test_report.dart';
import 'package:getx/app/data/model/gravity/test_context.dart';
import 'package:getx/app/data/model/gravity/test_with_sections.dart';
import 'package:getx/app/ui/android/home/gravity/batch_subject_chapter_page.dart';
import 'package:getx/app/ui/android/home/gravity/test_report_page.dart';
import '../../../controller/home/home_controller.dart';
import '../../constants/errors.dart';
import '../../constants/miscellaneous.dart';
import '../../model/api_response.dart';
import '../../model/city_state.dart';
import '../../model/gravity/academic_file.dart';
import '../../model/gravity/chapter.dart';
import '../../model/gravity/dpp_question.dart';
import '../../model/gravity/dpp_result.dart';
import '../../model/gravity/dpp_test_context.dart';
import '../../model/gravity/dpp_test_report.dart';
import '../../model/gravity/exam.dart';
import '../../model/gravity/gravity_result.dart';
import '../../model/gravity/module.dart';
import '../../model/gravity/module_chapter.dart';
import '../../model/gravity/subject.dart';
import '../../model/gravity/test.dart';
import '../../model/gravity/stream.dart';
import '../../model/request_response.dart';
import '../../../controller/authentication/authentication.dart';
import '../../../controller/networking/networking.dart';
import '../../constants/request_paths.dart';
import '../../model/booking.dart';
import '../../model/event.dart';
import '../../model/notification.dart';

class StudentsAPIProvider {
  late Authentication auth;
  late Networking networking;

  StudentsAPIProvider() {
    auth = Get.find<Authentication>();
    networking = Get.find<Networking>();
  }

  Future<APIResponse> getStreams() async {
    if (!auth.isLoggedIn.value) {
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    print("auth.token");
    print(auth.token);
    var headers = {
      'authorization': 'Bearer ${auth.token}',
    };
    Map<String, dynamic> query = {};
    print(query.toString());
    try {
      RequestResponse res = await networking.get(
          RequestPaths.GET_STUDENT_STREAMS,
          headers: headers,
          query: query);
      // print(res);

      if (res.status == TextMessages.SUCCESS) {
        List<GravityStream> streams = [];
        List<dynamic> evs = res.data as List;
        for (var element in evs) {
          streams.add(GravityStream.fromJSON(element));
        }
        return Future.value(
            APIResponse.fromSuccess(hasData: true, data: streams));
      } else {
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }

  Future<APIResponse> updateUserdata(Map<String, dynamic> data) async {
    if (!auth.isLoggedIn.value) {
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    var headers = {
      'authorization': 'Bearer ${auth.token}',
      // 'Content-Type':'application/json'
    };

    try {
      RequestResponse res = await networking.post(
          RequestPaths.POST_UPDATE_USER_DETAILS,
          headers: headers,
          data: data);

      if (res.status == TextMessages.SUCCESS) {
        return Future.value(APIResponse.fromSuccess(hasData: false));
      } else {
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }

  Future<APIResponse> getBatches() async {
    if (!auth.isLoggedIn.value) {
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    var headers = {
      'authorization': 'Bearer ${auth.token}',
    };
    Map<String, dynamic> query = {};
    try {
      RequestResponse res = await networking.get(
          RequestPaths.GET_STUDENT_BATCHES,
          headers: headers,
          query: query);
      print(res);

      if (res.status == TextMessages.SUCCESS) // "success"
      {
        List<Batch> batches = [];
        List<dynamic> evs = res.data as List;
        for (var element in evs) {
          batches.add(Batch.fromJSON(element));
        }
        return Future.value(
            APIResponse.fromSuccess(hasData: true, data: batches));
      } else {
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }

  Future<APIResponse> getBatchSubjectsForModules(String batchId) async {
    if (!auth.isLoggedIn.value) {
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    var headers = {
      'authorization': 'Bearer ${auth.token}',
    };
    Map<String, dynamic> query = {};
    try {
      RequestResponse res = await networking.get(
          "${RequestPaths.GET_STUDENT_MODULES}/subjects/$batchId",
          headers: headers,
          query: query);

      if (res.status == TextMessages.SUCCESS) {
        List<Subject> subjects = [];
        List<dynamic> evs = res.data as List;
        for (var element in evs) {
          subjects.add(Subject.fromJSON(element));
        }
        return Future.value(
            APIResponse.fromSuccess(hasData: true, data: subjects));
      } else {
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }

  // Future<APIResponse> getBatchModulesForSubjects(
  //     String batchId, String subjectId) async {
  //   if (!auth.isLoggedIn.value) {
  //     return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
  //   }
  //   var headers = {
  //     'authorization': 'Bearer ${auth.token}',
  //   };
  //   Map<String, dynamic> query = {};
  //   try {
  //     RequestResponse res = await networking.get(
  //         "${RequestPaths.GET_STUDENT_MODULES}/for_subject/$subjectId/$batchId",
  //         headers: headers,
  //         query: query);

  //     if (res.status == TextMessages.SUCCESS) {
  //       List<Module> modules = [];
  //       List<dynamic> evs = res.data as List;
  //       for (var element in evs) {
  //         modules.add(Module.fromJSON(element));
  //       }
  //       return Future.value(
  //           APIResponse.fromSuccess(hasData: true, data: modules));
  //     } else {
  //       print(res.message);
  //       return Future.value(APIResponse.fromFailed(info: res.message));
  //     }
  //   } catch (err) {
  //     print(err.toString());
  //     return Future.value(APIResponse.fromFailed(info: err.toString()));
  //   }
  // }

  // Future<APIResponse> getModule(String moduleId) async {
  //   if (!auth.isLoggedIn.value) {
  //     return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
  //   }
  //   var headers = {
  //     'authorization': 'Bearer ${auth.token}',
  //   };
  //   Map<String, dynamic> query = {};
  //   try {
  //     RequestResponse res = await networking.get(
  //         "${RequestPaths.GET_STUDENT_MODULES}/single/$moduleId",
  //         headers: headers,
  //         query: query);
  //     print(res);

  //     if (res.status == TextMessages.SUCCESS) {
  //       Module module = Module.fromJSON(res.data);
  //       return Future.value(
  //           APIResponse.fromSuccess(hasData: true, data: module));
  //     } else {
  //       return Future.value(APIResponse.fromFailed(info: res.message));
  //     }
  //   } catch (err) {
  //     return Future.value(APIResponse.fromFailed(info: err.toString()));
  //   }
  // }

  Future<APIResponse> getModuleChapter(String moduleChapterId) async {
    if (!auth.isLoggedIn.value) {
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    var headers = {
      'authorization': 'Bearer ${auth.token}',
    };
    Map<String, dynamic> query = {};
    try {
      RequestResponse res = await networking.get(
          "${RequestPaths.GET_STUDENT_MODULES}/module_chapter/$moduleChapterId",
          headers: headers,
          query: query);
      print(res);

      if (res.status == TextMessages.SUCCESS) {
        ModuleChapter moduleChapter =
            ModuleChapter.fromJSON(res.data, full: true);
        return Future.value(
            APIResponse.fromSuccess(hasData: true, data: moduleChapter));
      } else {
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }

// LECTURES API
//   getSubjectsForLectures

  Future<APIResponse> getChapterLectures(
      String batchId, String subjectId, String chapterId) async {
    if (!auth.isLoggedIn.value) {
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    var headers = {
      'authorization': 'Bearer ${auth.token}',
    };
    Map<String, dynamic> query = {};
    try {
      RequestResponse res = await networking.get(
          "${RequestPaths.GET_STUDENT_LECTURES}/lectures_specific/$batchId/$subjectId/$chapterId",
          headers: headers,
          query: query);
      print(res);

      if (res.status == TextMessages.SUCCESS) {
        List<dynamic> lecturesJson = res.data as List<dynamic>;
        List<Lecture> lectures = [];
        for (var lectureJson in lecturesJson) {
          lectures.add(Lecture.fromJSON(lectureJson));
        }
        return Future.value(
            APIResponse.fromSuccess(hasData: true, data: lectures));
      } else {
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }

  Future<APIResponse> getLecture(String lectureId) async {
    if (!auth.isLoggedIn.value) {
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    var headers = {
      'authorization': 'Bearer ${auth.token}',
    };
    Map<String, dynamic> query = {};
    try {
      RequestResponse res = await networking.get(
          "${RequestPaths.GET_STUDENT_LECTURES}/lecture_get/$lectureId",
          headers: headers,
          query: query);
      print(res);

      if (res.status == TextMessages.SUCCESS) {
        Lecture lecture = Lecture.fromJSON(res.data);
        return Future.value(
            APIResponse.fromSuccess(hasData: true, data: lecture));
      } else {
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }

  Future<APIResponse> getSubjectsForLectures(String batchId) async {
    if (!auth.isLoggedIn.value) {
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    var headers = {
      'authorization': 'Bearer ${auth.token}',
    };
    Map<String, dynamic> query = {};
    try {
      RequestResponse res = await networking.get(
          "${RequestPaths.GET_STUDENT_LECTURES}/lecture_subjects/$batchId",
          headers: headers,
          query: query);

      if (res.status == TextMessages.SUCCESS) {
        List<Subject> subjects = [];
        List<dynamic> evs = res.data as List;
        for (var element in evs) {
          subjects.add(Subject.fromJSON(element));
        }
        return Future.value(
            APIResponse.fromSuccess(hasData: true, data: subjects));
      } else {
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }

  Future<APIResponse> getLectureChaptersForSubject(
      String batchId, String subjectId) async {
    if (!auth.isLoggedIn.value) {
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    var headers = {
      'authorization': 'Bearer ${auth.token}',
    };
    Map<String, dynamic> query = {};
    try {
      RequestResponse res = await networking.get(
          "${RequestPaths.GET_STUDENT_LECTURES}/lecture_subject_chapters/$batchId/$subjectId",
          headers: headers,
          query: query);

      if (res.status == TextMessages.SUCCESS) {
        List<Chapter> chapters = [];
        List<dynamic> evs = res.data as List;
        for (var element in evs) {
          chapters.add(Chapter.fromJSON(element));
        }
        return Future.value(
            APIResponse.fromSuccess(hasData: true, data: chapters));
      } else {
        print(res.message);
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      print(err.toString());
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }

  //LECTURES END

  //PYQ section
  // Future<APIResponse> getPYQSubjects(String examId) async {
  //   if(!auth.isLoggedIn.value)
  //   {
  //     return Future.value(APIResponse.fromFailed(info:ErrorMessages.NLI));
  //   }
  //   var headers = {'authorization':'Bearer ${auth.token}',
  //   };
  //   Map<String,dynamic> query={};
  //   try{
  //     RequestResponse res = await networking.get("${RequestPaths.}/lecture_subjects/$batchId",headers: headers,query:query );
  //
  //     if(res.status == TextMessages.SUCCESS)
  //     {
  //       List<Subject> subjects = [];
  //       List<dynamic> evs=res.data as List;
  //       for (var element in evs) {
  //         subjects.add(Subject.fromJSON(element));
  //       }
  //       return Future.value(APIResponse.fromSuccess(hasData: true,data:subjects));
  //     }
  //     else {
  //       return Future.value(APIResponse.fromFailed(info:res.message));
  //     }
  //   }
  //   catch(err) {
  //     return Future.value(APIResponse.fromFailed(info:err.toString()));
  //   }
  // }
  //
  // Future<APIResponse> getLectureChaptersForSubject(String batchId,String subjectId) async {
  //   if(!auth.isLoggedIn.value)
  //   {
  //     return Future.value(APIResponse.fromFailed(info:ErrorMessages.NLI));
  //   }
  //   var headers = {'authorization':'Bearer ${auth.token}',
  //   };
  //   Map<String,dynamic> query={};
  //   try{
  //     RequestResponse res = await networking.get("${RequestPaths.GET_STUDENT_LECTURES}/lecture_subject_chapters/$batchId/$subjectId",headers: headers,query:query );
  //
  //     if(res.status == TextMessages.SUCCESS)
  //     {
  //       List<Chapter> chapters = [];
  //       List<dynamic> evs=res.data as List;
  //       for (var element in evs) {
  //         chapters.add(Chapter.fromJSON(element));
  //       }
  //       return Future.value(APIResponse.fromSuccess(hasData: true,data:chapters));
  //     }
  //     else {
  //       print(res.message);
  //       return Future.value(APIResponse.fromFailed(info:res.message));
  //     }
  //   }
  //   catch(err) {
  //     print(err.toString());
  //     return Future.value(APIResponse.fromFailed(info:err.toString()));
  //   }
  // }

  //PYQ ends

  // Files API
//   getSubjectsForLectures

  Future<APIResponse> getChapterFiles(
      String batchId, String subjectId, String chapterId) async {
    if (!auth.isLoggedIn.value) {
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    var headers = {
      'authorization': 'Bearer ${auth.token}',
    };
    Map<String, dynamic> query = {};
    try {
      RequestResponse res = await networking.get(
          "${RequestPaths.GET_STUDENT_FILES}/academic_files_specific/$batchId/$subjectId/$chapterId",
          headers: headers,
          query: query);
      print(res);

      if (res.status == TextMessages.SUCCESS) {
        List<dynamic> filesJson = res.data as List<dynamic>;
        List<AcademicFile> files = [];
        for (var fileJson in filesJson) {
          files.add(AcademicFile.fromJSON(fileJson));
        }
        return Future.value(
            APIResponse.fromSuccess(hasData: true, data: files));
      } else {
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }

  Future<APIResponse> getFile(String fileId) async {
    if (!auth.isLoggedIn.value) {
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    var headers = {'authorization': 'Bearer ${auth.token}'};
    Map<String, dynamic> query = {};
    try {
      RequestResponse res = await networking.get(
          "${RequestPaths.GET_STUDENT_FILES}/academic_file/$fileId",
          headers: headers,
          query: query);
      print(res);

      if (res.status == TextMessages.SUCCESS) {
        AcademicFile file = AcademicFile.fromJSON(res.data);
        return Future.value(APIResponse.fromSuccess(hasData: true, data: file));
      } else {
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }

  Future<APIResponse> getSubjectsForFiles(String batchId) async {
    if (!auth.isLoggedIn.value) {
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    var headers = {
      'authorization': 'Bearer ${auth.token}',
    };
    Map<String, dynamic> query = {};
    try {
      RequestResponse res = await networking.get(
          "${RequestPaths.GET_STUDENT_FILES}/academic_file_subjects/$batchId",
          headers: headers,
          query: query);
      print(res);

      if (res.status == TextMessages.SUCCESS) {
        List<Subject> subjects = [];
        List<dynamic> evs = res.data as List;
        for (var element in evs) {
          subjects.add(Subject.fromJSON(element));
        }
        return Future.value(
            APIResponse.fromSuccess(hasData: true, data: subjects));
      } else {
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }

  Future<APIResponse> getFilesChaptersForSubject(
      String batchId, String subjectId) async {
    if (!auth.isLoggedIn.value) {
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    var headers = {
      'authorization': 'Bearer ${auth.token}',
    };
    Map<String, dynamic> query = {};
    try {
      RequestResponse res = await networking.get(
          "${RequestPaths.GET_STUDENT_FILES}/academic_subject_chapters/$batchId/$subjectId",
          headers: headers,
          query: query);

      if (res.status == TextMessages.SUCCESS) {
        List<Chapter> chapters = [];
        List<dynamic> evs = res.data as List;
        for (var element in evs) {
          chapters.add(Chapter.fromJSON(element));
        }
        return Future.value(
            APIResponse.fromSuccess(hasData: true, data: chapters));
      } else {
        print(res.message);
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      print(err.toString());
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }

  //Files END

//2 batch api

  Future<APIResponse> getBatch(String batchId) async {
    if (!auth.isLoggedIn.value) {
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    var headers = {
      'authorization': 'Bearer ${auth.token}',
    };
    Map<String, dynamic> query = {};
    try {
      RequestResponse res = await networking.get(
          "${RequestPaths.GET_STUDENT_BATCHES}/batch_get/$batchId",
          headers: headers,
          query: query);
      print("res1");
      print(res);
      print("res1");

      if (res.status == TextMessages.SUCCESS) {
        Batch batch = Batch.fromJSON(res.data, full: true);
        return Future.value(
            APIResponse.fromSuccess(hasData: true, data: batch));
      } else {
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }

  Future<APIResponse> getMyBatch() async {
    if (!auth.isLoggedIn.value) {
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    var headers = {
      'authorization': 'Bearer ${auth.token}',
    };
    // Map<String,dynamic> query={};
    try {
      RequestResponse res = await networking.get(
          "${RequestPaths.GET_STUDENT_BATCHES}/student_batch_get",
          headers: headers);
      print(res);

      if (res.status == TextMessages.SUCCESS) {
        Batch batch = Batch.fromJSON(res.data);
        return Future.value(
            APIResponse.fromSuccess(hasData: true, data: batch));
      } else {
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }

// batch 1 api

  Future<APIResponse> getMyBatches() async {
    if (!auth.isLoggedIn.value) {
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    var headers = {
      'authorization': 'Bearer ${auth.token}',
    };
    String studentId = Get.find<Authentication>().user!.id;
    // Map<String,dynamic> query={};
    try {
      RequestResponse res = await networking.get(
          "${RequestPaths.GET_STUDENT_BATCHES}/student_batches/$studentId",
          headers: headers);
      print(res);

      if (res.status == TextMessages.SUCCESS) {
        // Batch batch = Batch.fromJSON(res.data);
        List<Batch> batches = [];
        var bs = res.data as List;
        for (var i in bs) {
          batches.add(Batch.fromJSON(i));
        }
        return Future.value(
            APIResponse.fromSuccess(hasData: true, data: batches));
      } else {
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }

//golu lectures api subject-chapterwise start

//ist
 Future<APIResponse> getBatchSubject(String batchId) async {
    if (!auth.isLoggedIn.value) {
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    var headers = {
      'authorization': 'Bearer ${auth.token}',
    };
    Map<String, dynamic> query = {};
    try {
      RequestResponse res = await networking.get(
          "${RequestPaths.GET_STUDENT_BATCHES}/batch_get_subject/$batchId",
          headers: headers,
          query: query);
      print(res);

      if (res.status == TextMessages.SUCCESS) {
        
        Batch batch = Batch.fromJSON(res.data,);
        // return Future.value(APIResponse.fromSuccess(hasData: true,data:subjects));
        // print(res.data);
        // Batch batch = Batch.fromJSON(res.data, full: true);
        // print("GOLU-GET-SUBJECTS");
        // print(batch);
        // print("GOLU-GET-SUBJECTS");
        // print(batch);

        return Future.value(
            APIResponse.fromSuccess(hasData: true, data: batch));
      } else {
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }

  // Future<APIResponse> getBatchSubject(String batchId) async {
  //   if (!auth.isLoggedIn.value) {
  //     return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
  //   }
  //   var headers = {
  //     'authorization': 'Bearer ${auth.token}',
  //   };
  //   Map<String, dynamic> query = {};
  //   try {
  //     RequestResponse res = await networking.get(
  //         "${RequestPaths.GET_STUDENT_BATCHES}/batch_get_subject/$batchId",
  //         headers: headers,
  //         query: query);
  //     print(res);

  //     if (res.status == TextMessages.SUCCESS) {
  //       List<BatchSubject> subjects = [];
  //       var bs = res.data as List;
  //       for (var i in bs) {
  //         print(3232222);
  //         print(i.runtimeType);
  //         print(3232222);
  //         subjects.add(BatchSubject.fromJSON(i));
  //       }
  //       // // Batch batch = Batch.fromJSON(res.data,full: true);
  //       // return Future.value(APIResponse.fromSuccess(hasData: true,data:subjects));
  //       // print(res.data);
  //       // Batch batch = Batch.fromJSON(res.data, full: true);
  //       // print("GOLU-GET-SUBJECTS");
  //       // print(batch);
  //       // print("GOLU-GET-SUBJECTS");
  //       // print(batch);

  //       return Future.value(
  //           APIResponse.fromSuccess(hasData: true, data: subjects));
  //     } else {
  //       return Future.value(APIResponse.fromFailed(info: res.message));
  //     }
  //   } catch (err) {
  //     return Future.value(APIResponse.fromFailed(info: err.toString()));
  //   }
  // }

//   Future<APIResponse> getBatchSubject(String batchId) async {
//     if(!auth.isLoggedIn.value)
//     {
//       return Future.value(APIResponse.fromFailed(info:ErrorMessages.NLI));
//     }
//     var headers = {'authorization':'Bearer ${auth.token}',
//     };
//     Map<String,dynamic> query={};
//     try{
//       RequestResponse res = await networking.get("${RequestPaths.GET_STUDENT_BATCHES}/batch_get_subject/$batchId",headers: headers,query:query );
//       print(res);
// if(res.status == TextMessages.SUCCESS) {
//   // Check if the data is a list and not empty, then take the first item
//   if (res.data is List && res.data.isNotEmpty) {
//     Batch batch = Batch.fromJSON(res.data[0], full: true);
//     return Future.value(APIResponse.fromSuccess(hasData: true, data: batch));
//   } else if (res.data is Map<String, dynamic>) {
//     Batch batch = Batch.fromJSON(res.data, full: true);
//     return Future.value(APIResponse.fromSuccess(hasData: true, data: batch));
//   } else {
//     return Future.value(APIResponse.fromFailed(info: "Unexpected data format"));
//   }
// } else {
//   return Future.value(APIResponse.fromFailed(info: res.message));
// }

//     }
//     catch(err) {
//       return Future.value(APIResponse.fromFailed(info:err.toString()));
//     }
//   }

// Future<APIResponse> getBatchSubject(String batchId) async {
//   if (!auth.isLoggedIn.value) {
//     return APIResponse.fromFailed(info: ErrorMessages.NLI);
//   }
//   final headers = {'authorization': 'Bearer ${auth.token}'};
//   final Map<String, dynamic> query = {};
//   try {
//     final RequestResponse res = await networking.get("${RequestPaths.GET_STUDENT_BATCHES}/batch_get_subject/$batchId", headers: headers, query: query);
//     // Consider using a logging framework or utility for better log management
//     // For example: logger.info(res);

//     if (res.status == TextMessages.SUCCESS) {
//       final Batch batch = Batch.fromJSON(res.data, full: true);
//       return APIResponse.fromSuccess(hasData: true, data: batch);
//     } else {
//       return APIResponse.fromFailed(info: res.message);
//     }
//   } catch (err) {
//     // Consider more specific error handling if applicable
//     // For example, if (err is SomeSpecificError) { ... }
//     return APIResponse.fromFailed(info: err.toString());
//   }
// }

//2nd golu

  Future<APIResponse> getBatchSubjectChapter(String batchSubjectId) async {
    if (!auth.isLoggedIn.value) {
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    var headers = {
      'authorization': 'Bearer ${auth.token}',
    };
    Map<String, dynamic> query = {};
    try {
      RequestResponse res = await networking.get(
          "${RequestPaths.GET_STUDENT_BATCHES}/subject_get_chapter/$batchSubjectId",
          headers: headers,
          query: query);
      print("res");
      print(res.data);
      print("res");

      if (res.status == TextMessages.SUCCESS) {
        List<BatchChapter> chapters = [];
        var bs = res.data as List;
        for (var i in bs) {
          print(3232222);
          print(i.runtimeType);
          print(3232222);
          chapters.add(BatchChapter.fromJSON(i));
        }
        // Batch batch = Batch.fromJSON(res.data, full: true);
        return Future.value(
            APIResponse.fromSuccess(hasData: true, data: chapters));
      } else {
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }

//3rd golu

  Future<APIResponse> getBatchSubjectChapterLecture(
      String batchChapterId) async {
    if (!auth.isLoggedIn.value) {
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    var headers = {
      'authorization': 'Bearer ${auth.token}',
    };
    Map<String, dynamic> query = {};
    try {
      RequestResponse res = await networking.get(
          "${RequestPaths.GET_STUDENT_BATCHES}/chapter_get_content/$batchChapterId",
          headers: headers,
          query: query);
      print(res);
      if (res.status == TextMessages.SUCCESS) {
        Lecture lecture = Lecture.fromJSON(res.data);
        return Future.value(
            APIResponse.fromSuccess(hasData: true, data: lecture));
      } else {
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }
//golu lectures api subject-chapterwise end

  // Future<APIResponse> getBatchSubjectChapterLecture(
  //     String batchChapterId) async {
  //   if (!auth.isLoggedIn.value) {
  //     return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
  //   }
  //   var headers = {
  //     'authorization': 'Bearer ${auth.token}',
  //   };
  //   Map<String, dynamic> query = {};
  //   try {
  //     RequestResponse res = await networking.get(
  //         "${RequestPaths.GET_STUDENT_BATCHES}/chapter_get_content/$batchChapterId",
  //         headers: headers,
  //         query: query);
  //     print(res);
  //     print("golu1");
  //     print(res.data);
  //     print("golu2");
  //     if (res.status == TextMessages.SUCCESS) {
  //       Lecture lecture = Lecture.fromJSON(res.data);

  //       // List<Lecture> lectures = [];
  //       // List<dynamic> bs = res.data as List<dynamic>;

  //       // var bs = res.data.lectures as List;
  //       // for (var i in bs) {
  //       //   print(4442222);
  //       //   print(i.runtimeType);
  //       //   print(4442222);
  //       //   lectures.add(Lecture.fromJSON(i));
  //       // }
  //       return Future.value(
  //           APIResponse.fromSuccess(hasData: true, data: lecture));
  //     } else {
  //       return Future.value(APIResponse.fromFailed(info: res.message));
  //     }
  //   } catch (err) {
  //     return Future.value(APIResponse.fromFailed(info: err.toString()));
  //   }
  // }

//golu chapterwise tests api start

  // Future<APIResponse> getBatchSubjectCwTests(String batchId) async {
  //   if (!auth.isLoggedIn.value) {
  //     return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
  //   }
  //   var headers = {
  //     'authorization': 'Bearer ${auth.token}',
  //   };
  //   Map<String, dynamic> query = {};
  //   try {
  //     RequestResponse res = await networking.get(
  //         "${RequestPaths.GET_STUDENT_BATCHES}/batch_get_subject/$batchId",
  //         headers: headers,
  //         query: query);
  //     print(res);

  //     if (res.status == TextMessages.SUCCESS) {
  //       List<BatchSubject> subjects = [];
  //       var bs = res.data as List;
  //       for (var i in bs) {
  //         print(3232222);
  //         print(i.runtimeType);
  //         print(3232222);
  //         subjects.add(BatchSubject.fromJSON(i));
  //       }
    
  //       return Future.value(
  //           APIResponse.fromSuccess(hasData: true, data: subjects));
  //     } else {
  //       return Future.value(APIResponse.fromFailed(info: res.message));
  //     }
  //   } catch (err) {
  //     return Future.value(APIResponse.fromFailed(info: err.toString()));
  //   }
  // }

 Future<APIResponse> getBatchSubjectCwTests(String batchId) async {
    if (!auth.isLoggedIn.value) {
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    var headers = {
      'authorization': 'Bearer ${auth.token}',
    };
    Map<String, dynamic> query = {};
    try {
      RequestResponse res = await networking.get(
          "${RequestPaths.GET_STUDENT_BATCHES}/batch_get_subject/$batchId",
          headers: headers,
          query: query);
      print(res);

      if (res.status == TextMessages.SUCCESS) {
        Batch batch = Batch.fromJSON(res.data,);
        
    
        return Future.value(
            APIResponse.fromSuccess(hasData: true, data: batch));
      } else {
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }


  Future<APIResponse> getBatchSubjectContentCwTests(
      String batchSubjectId) async {
    if (!auth.isLoggedIn.value) {
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    var headers = {
      'authorization': 'Bearer ${auth.token}',
    };
    Map<String, dynamic> query = {};
    try {
      RequestResponse res = await networking.get(
          "${RequestPaths.GET_STUDENT_BATCHES}/subject_get_test/$batchSubjectId",
          headers: headers,
          query: query);
      print(res);
        print("golu");
        print("tinku");


      if (res.status == TextMessages.SUCCESS) {
        Batch batch = Batch.fromJSON(res.data,full: true);
        // print(chapterWiseTest);
        print("golu");

        return Future.value(
          APIResponse.fromSuccess(hasData: true, data: batch),
        );
      } else {
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }

//golu chapterwise tests end

//golu dpp tests api start

  // Future<APIResponse> getBatchSubjectDppTests(String batchId) async {
  //   if (!auth.isLoggedIn.value) {
  //     return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
  //   }
  //   var headers = {
  //     'authorization': 'Bearer ${auth.token}',
  //   };
  //   Map<String, dynamic> query = {};
  //   try {
  //     RequestResponse res = await networking.get(
  //         "${RequestPaths.GET_STUDENT_BATCHES}/batch_get_subject/$batchId",
  //         headers: headers,
  //         query: query);
  //     print(res);

  //     if (res.status == TextMessages.SUCCESS) {
  //       List<BatchSubject> subjects = [];
  //       var bs = res.data as List;
  //       for (var i in bs) {
  //         print(3232222);
  //         print(i.runtimeType);
  //         print(3232222);
  //         subjects.add(BatchSubject.fromJSON(i));
  //       }
  //       // // Batch batch = Batch.fromJSON(res.data,full: true);
  //       // return Future.value(APIResponse.fromSuccess(hasData: true,data:subjects));
  //       // print(res.data);
  //       // Batch batch = Batch.fromJSON(res.data, full: true);
  //       // print("GOLU-GET-SUBJECTS");
  //       // print(batch);
  //       // print("GOLU-GET-SUBJECTS");
  //       // print(batch);

  //       return Future.value(
  //           APIResponse.fromSuccess(hasData: true, data: subjects));
  //     } else {
  //       return Future.value(APIResponse.fromFailed(info: res.message));
  //     }
  //   } catch (err) {
  //     return Future.value(APIResponse.fromFailed(info: err.toString()));
  //   }
  // }

 Future<APIResponse> getBatchSubjectDppTests(String batchId) async {
    if (!auth.isLoggedIn.value) {
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    var headers = {
      'authorization': 'Bearer ${auth.token}',
    };
    Map<String, dynamic> query = {};
    try {
      RequestResponse res = await networking.get(
          "${RequestPaths.GET_STUDENT_BATCHES}/batch_get_subject/$batchId",
          headers: headers,
          query: query);
      print(res);

      if (res.status == TextMessages.SUCCESS) {
      
        Batch batch = Batch.fromJSON(res.data);
      

        return Future.value(
            APIResponse.fromSuccess(hasData: true, data: batch));
      } else {
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }


  Future<APIResponse> getBatchSubjectChapterDppTests(
      String batchSubjectId) async {
    if (!auth.isLoggedIn.value) {
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    var headers = {
      'authorization': 'Bearer ${auth.token}',
    };
    Map<String, dynamic> query = {};
    try {
      RequestResponse res = await networking.get(
          "${RequestPaths.GET_STUDENT_BATCHES}/subject_get_chapter/$batchSubjectId",
          headers: headers,
          query: query);
      print("res");
      print(res.data);
      print("res");

      if (res.status == TextMessages.SUCCESS) {
        List<BatchChapter> chapters = [];
        var bs = res.data as List;
        for (var i in bs) {
          print(3232222);
          print(i.runtimeType);
          print(3232222);
          chapters.add(BatchChapter.fromJSON(i));
        }
        // Batch batch = Batch.fromJSON(res.data, full: true);
        return Future.value(
            APIResponse.fromSuccess(hasData: true, data: chapters));
      } else {
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }

 Future<APIResponse> getBatchSubjectChapterContentDppTests(
      String batchChapterId) async {
    if (!auth.isLoggedIn.value) {
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    var headers = {
      'authorization': 'Bearer ${auth.token}',
    };
    Map<String, dynamic> query = {};
    try {
      RequestResponse res = await networking.get(
          "${RequestPaths.GET_STUDENT_BATCHES}/chapter_get_content/$batchChapterId",
          headers: headers,
          query: query);
             print("golu");
        print("tinku");
      print(res.data['dpp_tests']);
        print("golu");
        print("tinku");


      if (res.status == TextMessages.SUCCESS) {
        Batch batch = Batch.fromJSON(res.data,full: true);
      
        print("golu");

        return Future.value(
          APIResponse.fromSuccess(hasData: true, data: batch),
        );
      } else {
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }

 Future<APIResponse> getDppTestReport(String testId) async {
    if (!auth.isLoggedIn.value) {
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    var headers = {'authorization': 'Bearer ${auth.token}'};
    try {
      RequestResponse res = await networking.get(
          "${RequestPaths.GET_STUDENT_STREAM_DPP_TESTINFO}/$testId",
          headers: headers);
      if (res.status == TextMessages.SUCCESS) {
        var data = DppTestReport.fromJson(res.data);
        return Future.value(APIResponse.fromSuccess(hasData: true, data: data));
      } else {
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }

    Future<APIResponse> getDppTestState(String testStateId, bool questions) async {
    if (!auth.isLoggedIn.value) {
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    var headers = {
      'authorization': 'Bearer ${auth.token}',
      // 'Content-Type':'application/json'
    };
    Map<String, dynamic> query = {};
    // if(Get.find<HomeController>().cityState.value!.city != CityState.defaultCity().city)
    //   {
    //     query = {"city":Get.find<HomeController>().cityState.value!.city};
    //   }

    // print(query.toString());

    try {
      RequestResponse res = await networking.get(
          "${RequestPaths.GET_STUDENT_DPP_TEST_STATE}/$testStateId",
          headers: headers,
          query: query);
      // print(res.data);

      if (res.status == TextMessages.SUCCESS) {
        print(res.data);
        print("res.data");
        // Map<String,dynamic> respData = res.data as Map<String,dynamic>;
        print(questions);
        DppTestContext data = DppTestContext.fromJson(res.data, questions: questions);
        print("getting test state");
        return Future.value(APIResponse.fromSuccess(hasData: true, data: data));
      } else {
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      print(err);
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }


  Future<APIResponse> createNewDppTestState(String testId, String batchId) async {
    if (!auth.isLoggedIn.value) {
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    var headers = {
      'authorization': 'Bearer ${auth.token}',
      // 'Content-Type':'application/json'
    };
    Map<String, dynamic> query = {};
    // if(Get.find<HomeController>().cityState.value!.city != CityState.defaultCity().city)
    //   {
    //     query = {"city":Get.find<HomeController>().cityState.value!.city};
    //   }

    print(query.toString());
    Map<String, dynamic> data = {'batch_id': batchId};

    try {
      RequestResponse res = await networking.post(
          "${RequestPaths.POST_CREATE_DPP_TEST_ATTEMPT}/$testId",
          headers: headers,
          query: query,
          data: data);
      print("Printing response");
      print(res.status);

      if (res.status == TextMessages.SUCCESS) {
        print("Successfully created attempt");
        print(res.data);

        String testContextId = res.data as String;
        return Future.value(
            APIResponse.fromSuccess(hasData: true, data: testContextId));
      } else {
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }

 Future<APIResponse> updateDppTestState(DppTestContext testContext) async {
    if (!auth.isLoggedIn.value) {
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    var headers = {
      'authorization': 'Bearer ${auth.token}',
      'Content-Type': 'application/json'
    };
    var data = {"data": testContext.lqs, "time_left": testContext.timeLeft};
    try {
      RequestResponse res = await networking.post(
          "${RequestPaths.POST_SAVE_DPP_TEST_STATE}/${testContext.id}",
          headers: headers,
          data: data);
      print("${res.message}: Message from response save upadte test");
      if (res.status == TextMessages.SUCCESS) {
        return Future.value(
            APIResponse.fromSuccess(hasData: true, data: res.data));
      } else {
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }

 Future<APIResponse> submitDppTestState(DppTestContext testContext) async {
    if (!auth.isLoggedIn.value) {
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    var headers = {
      'authorization': 'Bearer ${auth.token}',
      'Content-Type': 'application/json'
    };
    // var data = {"data":jsonEncode(testContext.lqs)};
    try {
      RequestResponse res = await networking.post(
          "${RequestPaths.POST_SUBMIT_DPP_TEST}/${testContext.id}",
          headers: headers);
      if (res.status == TextMessages.SUCCESS) {
        String resultId = res.data;
        return Future.value(
            APIResponse.fromSuccess(hasData: true, data: resultId));
      } else {
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }

 Future<APIResponse> getDppTestQuestion(String questionId) async {
    if (!auth.isLoggedIn.value) {
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    var headers = {
      'authorization': 'Bearer ${auth.token}',
      // 'Content-Type':'application/json'
    };
    Map<String, dynamic> query = {};
    print(query.toString());

    try {
      RequestResponse res = await networking.get(
          "${RequestPaths.GET_STUDENT_DPP_QUESTION}/$questionId",
          headers: headers,
          query: query);
      print(res.data);

      if (res.status == TextMessages.SUCCESS) {
        // Map<String,dynamic> respData = res.data as Map<String,dynamic>;
        var data = DppQuestion.fullFromJSON(res.data);
        return Future.value(APIResponse.fromSuccess(hasData: true, data: data));
      } else {
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }

 Future<APIResponse> getDppTestResult(String testResultId) async {
    if (!auth.isLoggedIn.value) {
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    var headers = {
      'authorization': 'Bearer ${auth.token}',
      // 'Content-Type':'application/json'
    };
    Map<String, dynamic> query = {};
    print(query.toString());

    try {
      RequestResponse res = await networking.get(
          "${RequestPaths.GET_STUDENT_DPP_TEST_RESULT}/$testResultId",
          headers: headers,
          query: query);
      print(res.data);

      if (res.status == TextMessages.SUCCESS) {
        // Map<String,dynamic> respData = res.data as Map<String,dynamic>;
        var data = DppResult.fromJson(res.data);
        return Future.value(APIResponse.fromSuccess(hasData: true, data: data));
      } else {
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }


//golu dpp tests api end

  // getExamQuestions(String examId,String subjectId,String chapterId)
  Future<APIResponse> getExamSubjects(String examId) async {
    if (!auth.isLoggedIn.value) {
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    var headers = {
      'authorization': 'Bearer ${auth.token}',
    };
    Map<String, dynamic> query = {};
    try {
      RequestResponse res = await networking.get(
          "${RequestPaths.GET_STUDENT_EXAMS}/previous_year_questions_subjects/$examId",
          headers: headers,
          query: query);
      // print(res);

      if (res.status == TextMessages.SUCCESS) {
        List<dynamic> subjectsJson = res.data as List<dynamic>;
        List<Subject> subjects = [];
        for (var subjectJson in subjectsJson) {
          subjects.add(Subject.fromJSON(subjectJson));
        }
        // Lecture lecture = Lecture.fromJSON(res.data);
        return Future.value(
            APIResponse.fromSuccess(hasData: true, data: subjects));
      } else {
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }

  Future<APIResponse> getExamSubjectChapters(
      String examId, String subjectId) async {
    if (!auth.isLoggedIn.value) {
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    var headers = {
      'authorization': 'Bearer ${auth.token}',
    };
    Map<String, dynamic> query = {};
    try {
      RequestResponse res = await networking.get(
          "${RequestPaths.GET_STUDENT_EXAMS}/previous_year_questions_subject_chapters/$examId/$subjectId",
          headers: headers,
          query: query);
      // print(res);

      if (res.status == TextMessages.SUCCESS) {
        List<dynamic> chaptersJson = res.data as List<dynamic>;
        List<Chapter> chapters = [];
        for (var chapterJson in chaptersJson) {
          chapters.add(Chapter.fromJSON(chapterJson));
        }
        // Lecture lecture = Lecture.fromJSON(res.data);
        return Future.value(
            APIResponse.fromSuccess(hasData: true, data: chapters));
      } else {
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }

  Future<APIResponse> getExamQuestions(
      String examId, String subjectId, String chapterId) async {
    if (!auth.isLoggedIn.value) {
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    var headers = {
      'authorization': 'Bearer ${auth.token}',
    };
    Map<String, dynamic> query = {};
    try {
      RequestResponse res = await networking.get(
          "${RequestPaths.GET_STUDENT_EXAMS}/previous_year_questions_specific/$examId/$subjectId/$chapterId",
          headers: headers,
          query: query);
      print(res);

      if (res.status == TextMessages.SUCCESS) {
        List<dynamic> questionsJson = res.data as List<dynamic>;
        List<Question> questions = [];
        for (var questionJson in questionsJson) {
          questions.add(Question.minimalFromJSON(questionJson));
        }
        // Lecture lecture = Lecture.fromJSON(res.data);
        return Future.value(
            APIResponse.fromSuccess(hasData: true, data: questions));
      } else {
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }

  Future<APIResponse> getGravityResults() async {
    if (!auth.isLoggedIn.value) {
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    var headers = {
      'authorization': 'Bearer ${auth.token}',
      // 'Content-Type':'application/json'
    };

    List<GravityResult> results = [];
    List<int> evs = [1, 2, 3, 4, 5];

    for (var element in evs) {
      results.add(GravityResult(element.toString(), element.toString(), ""));
    }
    print("results");
    print(results);
    return Future.value(APIResponse.fromSuccess(hasData: true, data: results));

    try {
      RequestResponse res = await networking
          .get(RequestPaths.GET_GRAVITY_RESULTS, headers: headers);
      print(res.data);

      if (res.status == TextMessages.SUCCESS) {
        List<GravityResult> results = [];
        List<dynamic> evs = res.data as List;

        for (var element in evs) {
          print("ASd");
          results.add(GravityResult.fromJSON(element));
        }
        return Future.value(
            APIResponse.fromSuccess(hasData: true, data: results));
      } else {
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }

  Future<APIResponse> getStream(String streamId) async {
    if (!auth.isLoggedIn.value) {
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    print(auth.token);
    var headers = {
      'authorization': 'Bearer ${auth.token}',
    };
    Map<String, dynamic> query = {};
    print(query.toString());
    try {
      RequestResponse res = await networking.get(
          RequestPaths.GET_STUDENT_STREAMS,
          headers: headers,
          query: query);
      print(res.data);

      if (res.status == TextMessages.SUCCESS) {
        List<GravityStream> streams = [];
        List<dynamic> evs = res.data as List;
        for (var element in evs) {
          streams.add(GravityStream.fromJSON(element));
        }
        return Future.value(
            APIResponse.fromSuccess(hasData: true, data: streams));
      } else {
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }

  Future<APIResponse> getExams() async {
    if (!auth.isLoggedIn.value) {
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    print(auth.token);
    var headers = {
      'authorization': 'Bearer ${auth.token}',
    };
    Map<String, dynamic> query = {};
    print(query.toString());
    try {
      RequestResponse res = await networking.get(RequestPaths.GET_STUDENT_EXAMS,
          headers: headers, query: query);
      print(res.data);

      if (res.status == TextMessages.SUCCESS) {
        List<Exam> exams = [];
        List<dynamic> evs = res.data as List;
        for (var element in evs) {
          exams.add(Exam.fromJSON(element, hasQuestions: false));
        }
        return Future.value(
            APIResponse.fromSuccess(hasData: true, data: exams));
      } else {
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }

  Future<APIResponse> getExam(
      String examId, String subjectId, String chapterId) async {
    if (!auth.isLoggedIn.value) {
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    print(auth.token);
    var headers = {
      'authorization': 'Bearer ${auth.token}',
    };
    Map<String, dynamic> query = {};
    print(query.toString());
    try {
      RequestResponse res = await networking.get(
          "${RequestPaths.GET_STUDENT_EXAMS}/previous_year_questions_specific/$examId/$subjectId/$chapterId",
          headers: headers,
          query: query);
      print(res.data);

      if (res.status == TextMessages.SUCCESS) {
        // Exam exam = Exam.fromJSON(res.data,hasQuestions: true);
        List<dynamic> data = res.data as List;
        List<Question> questions = [];
        for (var d in data) {
          questions.add(Question.minimalFromJSON(d));
        }
        return Future.value(
            APIResponse.fromSuccess(hasData: true, data: questions));
      } else {
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }

  //search or find events
  Future<APIResponse> getTestsForStream(String stream) async {
    if (!auth.isLoggedIn.value) {
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    var headers = {
      'authorization': 'Bearer ${auth.token}',
      // 'Content-Type':'application/json'
    };
    Map<String, dynamic> query = {};
    print(
        "stream: $stream"); // if(Get.find<HomeController>().cityState.value!.city != CityState.defaultCity().city)
    //   {
    //     query = {"city":Get.find<HomeController>().cityState.value!.city};
    //   }

    // print(query.toString());

    try {
      RequestResponse res = await networking.get(
          "${RequestPaths.GET_STUDENT_STREAM_TESTS}/$stream",
          headers: headers,
          query: query);
      print(res.data);

      if (res.status == TextMessages.SUCCESS) {
        List<TestWithSections> tests = [];
        List<dynamic> evs = res.data as List;
        var num = 0;
        for (var element in evs) {
          print(num);
          tests.add(TestWithSections.fromJSON(element, false));
        }
        return Future.value(
            APIResponse.fromSuccess(hasData: true, data: tests));
      } else {
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      print(err);
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }

  Future<APIResponse> getTestQuestion(String questionId) async {
    if (!auth.isLoggedIn.value) {
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    var headers = {
      'authorization': 'Bearer ${auth.token}',
      // 'Content-Type':'application/json'
    };
    Map<String, dynamic> query = {};
    print(query.toString());

    try {
      RequestResponse res = await networking.get(
          "${RequestPaths.GET_STUDENT_QUESTION}/$questionId",
          headers: headers,
          query: query);
      print(res.data);

      if (res.status == TextMessages.SUCCESS) {
        // Map<String,dynamic> respData = res.data as Map<String,dynamic>;
        var data = Question.fullFromJSON(res.data);
        return Future.value(APIResponse.fromSuccess(hasData: true, data: data));
      } else {
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }

  Future<APIResponse> getTestReport(String testId) async {
    if (!auth.isLoggedIn.value) {
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    var headers = {'authorization': 'Bearer ${auth.token}'};
    try {
      RequestResponse res = await networking.get(
          "${RequestPaths.GET_STUDENT_STREAM_TESTINFO}/$testId",
          headers: headers);
      if (res.status == TextMessages.SUCCESS) {
        var data = TestReport.fromJson(res.data);
        return Future.value(APIResponse.fromSuccess(hasData: true, data: data));
      } else {
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }

  Future<APIResponse> getTestResult(String testResultId) async {
    if (!auth.isLoggedIn.value) {
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    var headers = {
      'authorization': 'Bearer ${auth.token}',
      // 'Content-Type':'application/json'
    };
    Map<String, dynamic> query = {};
    print(query.toString());

    try {
      RequestResponse res = await networking.get(
          "${RequestPaths.GET_STUDENT_TEST_RESULT}/$testResultId",
          headers: headers,
          query: query);
      print(res.data);

      if (res.status == TextMessages.SUCCESS) {
        // Map<String,dynamic> respData = res.data as Map<String,dynamic>;
        var data = Result.fromJson(res.data);
        return Future.value(APIResponse.fromSuccess(hasData: true, data: data));
      } else {
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }

//  Future<APIResponse> getTestResult(String testResultId) async {
//     if (!auth.isLoggedIn.value) {
//       return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
//     }
//     var headers = {
//       'authorization': 'Bearer ${auth.token}',
//       // 'Content-Type':'application/json'
//     };
//     Map<String, dynamic> query = {};
//     print(query.toString());

//     try {
//       RequestResponse res = await networking.get(
//           "${RequestPaths.GET_STUDENT_TEST_RESULT_QUESTIONS}/$testResultId",
//           headers: headers,
//           query: query);
//       print(res.data);

//       if (res.status == TextMessages.SUCCESS) {
//         // Map<String,dynamic> respData = res.data as Map<String,dynamic>;
//         var data = Result.fromJson(res.data);
//         return Future.value(APIResponse.fromSuccess(hasData: true, data: data));
//       } else {
//         return Future.value(APIResponse.fromFailed(info: res.message));
//       }
//     } catch (err) {
//       return Future.value(APIResponse.fromFailed(info: err.toString()));
//     }
//   }


  Future<APIResponse> getTestState(String testStateId, bool questions) async {
    if (!auth.isLoggedIn.value) {
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    var headers = {
      'authorization': 'Bearer ${auth.token}',
      // 'Content-Type':'application/json'
    };
    Map<String, dynamic> query = {};
    // if(Get.find<HomeController>().cityState.value!.city != CityState.defaultCity().city)
    //   {
    //     query = {"city":Get.find<HomeController>().cityState.value!.city};
    //   }

    // print(query.toString());

    try {
      RequestResponse res = await networking.get(
          "${RequestPaths.GET_STUDENT_TEST_STATE}/$testStateId",
          headers: headers,
          query: query);
      // print(res.data);

      if (res.status == TextMessages.SUCCESS) {
        print(res.data);
        print("res.data");
        // Map<String,dynamic> respData = res.data as Map<String,dynamic>;
        print(questions);
        TestContext data = TestContext.fromJson(res.data, questions: questions);
        print("getting test state");
        return Future.value(APIResponse.fromSuccess(hasData: true, data: data));
      } else {
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      print(err);
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }

  Future<APIResponse> createNewTestState(String testId, String batchId) async {
    if (!auth.isLoggedIn.value) {
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    var headers = {
      'authorization': 'Bearer ${auth.token}',
      // 'Content-Type':'application/json'
    };
    Map<String, dynamic> query = {};
    // if(Get.find<HomeController>().cityState.value!.city != CityState.defaultCity().city)
    //   {
    //     query = {"city":Get.find<HomeController>().cityState.value!.city};
    //   }

    print(query.toString());
    Map<String, dynamic> data = {'batch_id': batchId};

    try {
      RequestResponse res = await networking.post(
          "${RequestPaths.POST_CREATE_TEST_ATTEMPT}/$testId",
          headers: headers,
          query: query,
          data: data);
      print("Printing response");
      print(res.status);

      if (res.status == TextMessages.SUCCESS) {
        print("Successfully created attempt");
        print(res.data);

        String testContextId = res.data as String;
        return Future.value(
            APIResponse.fromSuccess(hasData: true, data: testContextId));
      } else {
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }

  Future<APIResponse> updateTestState(TestContext testContext) async {
    if (!auth.isLoggedIn.value) {
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    var headers = {
      'authorization': 'Bearer ${auth.token}',
      'Content-Type': 'application/json'
    };
    var data = {"data": testContext.lqs, "time_left": testContext.timeLeft};
    try {
      RequestResponse res = await networking.post(
          "${RequestPaths.POST_SAVE_TEST_STATE}/${testContext.id}",
          headers: headers,
          data: data);
      print("${res.message}: Message from response save upadte test");
      if (res.status == TextMessages.SUCCESS) {
        return Future.value(
            APIResponse.fromSuccess(hasData: true, data: res.data));
      } else {
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }

  Future<APIResponse> submitTestState(TestContext testContext) async {
    if (!auth.isLoggedIn.value) {
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    var headers = {
      'authorization': 'Bearer ${auth.token}',
      'Content-Type': 'application/json'
    };
    // var data = {"data":jsonEncode(testContext.lqs)};
    try {
      RequestResponse res = await networking.post(
          "${RequestPaths.POST_SUBMIT_TEST}/${testContext.id}",
          headers: headers);
      if (res.status == TextMessages.SUCCESS) {
        String resultId = res.data;
        return Future.value(
            APIResponse.fromSuccess(hasData: true, data: resultId));
      } else {
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }

  Future<APIResponse> getTest(String testId, {bool expanded = false}) async {
    if (!auth.isLoggedIn.value) {
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    var headers = {
      'authorization': 'Bearer ${auth.token}',
      // 'Content-Type':'application/json'
    };
    Map<String, dynamic> query = {};
    print(query.toString());

    try {
      RequestResponse res = await networking.get(
          "${RequestPaths.GET_STUDENT_TESTS}/$testId",
          headers: headers,
          query: query);
      print(res.data);

      if (res.status == TextMessages.SUCCESS) {
        TestWithSections test = TestWithSections.fromJSON(res.data, expanded);
        return Future.value(APIResponse.fromSuccess(hasData: true, data: test));
      } else {
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }

  // Future<APIResponse> getTestState(String testStateId,{bool expanded=true}) async {
  //   if(!auth.isLoggedIn.value)
  //   {
  //     return Future.value(APIResponse.fromFailed(info:ErrorMessages.NLI));
  //   }
  //   var headers = {'authorization':'Bearer ${auth.token}',
  //     // 'Content-Type':'application/json'
  //   };
  //   Map<String,dynamic> query={};
  //   print(query.toString());
  //
  //   try{
  //     RequestResponse res = await networking.get("${RequestPaths.GET_STUDENT_TEST_STATE}/$testStateId",headers: headers,query:query );
  //     print(res.data);
  //
  //     if(res.status == TextMessages.SUCCESS)
  //     {
  //       TestState test=TestWithSections.fromJSON(res.data,expanded);
  //       return Future.value(APIResponse.fromSuccess(hasData: true,data:test));
  //     }
  //     else {
  //       return Future.value(APIResponse.fromFailed(info:res.message));
  //     }
  //   }
  //   catch(err) {
  //     return Future.value(APIResponse.fromFailed(info:err.toString()));
  //   }
  // }

  Future<APIResponse> search(String searchString) async {
    if (!auth.isLoggedIn.value) {
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    var headers = {
      'authorization': 'Bearer ${auth.token}',
      // 'Content-Type':'application/json'
    };
    var query;
    print("query");
    print(query);
    print(searchString);

    try {
      RequestResponse res = await networking.get(
          "${RequestPaths.GET_EVENTS_SEARCH}/$searchString",
          headers: headers,
          query: query);
      print(res.data);

      if (res.status == TextMessages.SUCCESS) {
        List<Event> events = [];
        List<dynamic> evs = res.data as List;

        for (var element in evs) {
          events.add(Event.fromJson(element));
        }
        return Future.value(
            APIResponse.fromSuccess(hasData: true, data: events));
      } else {
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }

  Future<APIResponse> getNotifications() async {
    if (!auth.isLoggedIn.value) {
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    var headers = {
      'authorization': 'Bearer ${auth.token}',
      // 'Content-Type':'application/json'
    };

    try {
      RequestResponse res = await networking
          .get(RequestPaths.GET_STUDENT_NOTIFICATIONS, headers: headers);
      print(res.data);

      if (res.status == TextMessages.SUCCESS) {
        List<Notification> notifications = [];
        List<dynamic> evs = res.data as List;

        for (var element in evs) {
          notifications.add(Notification.fromJson(element));
        }
        return Future.value(
            APIResponse.fromSuccess(hasData: true, data: notifications));
      } else {
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }

  Future<APIResponse> saveUserEmail(String email) async {
    if (!auth.isLoggedIn.value) {
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    var headers = {
      'authorization': 'Bearer ${auth.token}',
      // 'Content-Type':'application/json'
    };

    Map<String, dynamic> data = {"email": email};

    try {
      RequestResponse res = await networking.post(RequestPaths.POST_SAVE_EMAIL,
          headers: headers, data: data);

      if (res.status == TextMessages.SUCCESS) {
        return Future.value(APIResponse.fromSuccess(hasData: false));
      } else {
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }

  Future<APIResponse> submitAI(String query) async {
    if (!auth.isLoggedIn.value) {
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    if (query.isEmpty) {
      return Future.value(APIResponse.fromSuccess(hasData: true, data: ""));
    }

    if (query.length < 10) {
      return Future.value(APIResponse.fromFailed(
          info:
              "Question is too short to disturb the AI, At-least 10Characters are needed"));
    }
    var headers = {
      'authorization': 'Bearer ${auth.token}',
      // 'Content-Type':'application/json'
    };

    Map<String, dynamic> data = {"query": query};

    try {
      RequestResponse res = await networking.post(RequestPaths.POST_QUERY_AI,
          headers: headers, data: data);

      if (res.status == TextMessages.SUCCESS) {
        String response = res.data as String;
        return Future.value(
            APIResponse.fromSuccess(hasData: true, data: response));
      } else {
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }

  Future<APIResponse> switchToHost() async {
    if (!auth.isLoggedIn.value) {
      //please go to the LOGIN page from here after return!
      return Future.value(APIResponse.fromFailed(info: ErrorMessages.NLI));
    }
    var headers = {
      'authorization': 'Bearer ${auth.token}',
      // 'Content-Type':'application/json'
    };

    try {
      RequestResponse res = await networking
          .post(RequestPaths.POST_USER_SWITCH_TO_CLIENT, headers: headers);
      // print("Phase from host api");
      if (res.status == TextMessages.SUCCESS) {
        String token = res.data as String;
        return Future.value(
            APIResponse.fromSuccess(hasData: true, data: token));
      } else {
        print("Request failed");
        print(res.message);
        return Future.value(APIResponse.fromFailed(info: res.message));
      }
    } catch (err) {
      print("Somethign went wrong");
      print(err);
      return Future.value(APIResponse.fromFailed(info: err.toString()));
    }
  }
//
//   Future<APIResponse> getEventsByTypes(String eventType) async {
//     if(!auth.isLoggedIn.value)
//     {
//       return Future.value(APIResponse.fromFailed(info:ErrorMessages.NLI));
//     }
//     var headers = {'authorization':'Bearer ${auth.token}',
//       // 'Content-Type':'application/json'
//     };
//
//     try{
//       Map<String,dynamic> query = {"category":eventType};
//       RequestResponse res = await networking.get(RequestPaths.GET_EVENTS,query:query,headers: headers);
//       print(res.data);
//
//       if(res.status == TextMessages.SUCCESS)
//       {
//         List<Event> events = [];
//         List<dynamic> evs=res.data as List;
//
//         for (var element in evs) {
//           events.add(Event.fromJson(element));
//         }
//         return Future.value(APIResponse.fromSuccess(hasData: true,data:events));
//       }
//       else {
//         return Future.value(APIResponse.fromFailed(info:res.message));
//       }
//     }
//     catch(err) {
//       return Future.value(APIResponse.fromFailed(info:err.toString()));
//     }
//   }
//
//   Future<APIResponse> getcategoricalEvents(String category) async {
//     if(!auth.isLoggedIn.value)
//     {
//       return Future.value(APIResponse.fromFailed(info:ErrorMessages.NLI));
//     }
//     var headers = {'authorization':'Bearer ${auth.token}',
//       // 'Content-Type':'application/json'
//     };
//
//     try{
//       RequestResponse res = await networking.get("${RequestPaths.GET_EVENTS_CATEGORY}/${category}",headers: headers);
//
//       if(res.status == TextMessages.SUCCESS)
//       {
//         List<Event> events = [];
//         List<dynamic> evs=res.data as List;
//
//         for (var element in evs) {
//           events.add(Event.fromJson(element));
//         }
//         return Future.value(APIResponse.fromSuccess(hasData: true,data:events));
//       }
//       else {
//         return Future.value(APIResponse.fromFailed(info:res.message));
//       }
//     }
//     catch(err) {
//       return Future.value(APIResponse.fromFailed(info:err.toString()));
//     }
//   }
//
//   Future<APIResponse> getEvent(String eventId) async {
//     if(!auth.isLoggedIn.value)
//     {
//       return Future.value(APIResponse.fromFailed(info:ErrorMessages.NLI));
//     }
//     var headers = {'authorization':'Bearer ${auth.token}',
//       // 'Content-Type':'application/json'
//     };
//
//     try{
//       RequestResponse res = await networking.get("${RequestPaths.GET_EVENT}/$eventId",headers: headers);
//
//       if(res.status == TextMessages.SUCCESS)
//       {
//         print("evensss");
//         Event e=Event.fromJson(res.data);
//         print("evensss");
//         print(e.phases);
//         return Future.value(APIResponse.fromSuccess(hasData: true,data:e));
//       }
//       else {
//         return Future.value(APIResponse.fromFailed(info:res.message));
//       }
//     }
//     catch(err) {
//       return Future.value(APIResponse.fromFailed(info:err.toString()));
//     }
//   }
//
//   Future<APIResponse> getBookings() async {
//     if(!auth.isLoggedIn.value)
//     {
//       return Future.value(APIResponse.fromFailed(info:ErrorMessages.NLI));
//     }
//     var headers = {'authorization':'Bearer ${auth.token}',
//       // 'Content-Type':'application/json'
//     };
//
//     try{
//       RequestResponse res = await networking.get(RequestPaths.GET_BOOKINGS,headers: headers);
//
//       if(res.status == TextMessages.SUCCESS)
//       {
//         List<Booking> bookings = [];
//         List<dynamic> evs=res.data as List;
//
//         for (var element in evs) {
//           bookings.add(Booking.fromJson(element));
//         }
//         return Future.value(APIResponse.fromSuccess(hasData: true,data:bookings));
//       }
//       else {
//         return Future.value(APIResponse.fromFailed(info:res.message));
//       }
//     }
//     catch(err) {
//       return Future.value(APIResponse.fromFailed(info:err.toString()));
//     }
//   }
//
//   Future<APIResponse> getBooking(String bookingId) async {
//     if(!auth.isLoggedIn.value)
//     {
//       return Future.value(APIResponse.fromFailed(info:ErrorMessages.NLI));
//     }
//     var headers = {'authorization':'Bearer ${auth.token}',
//       // 'Content-Type':'application/json'
//     };
//
//     try{
//       RequestResponse res = await networking.get("${RequestPaths.GET_BOOKING}/$bookingId",headers: headers);
//
//       if(res.status == TextMessages.SUCCESS)
//       {
//         Booking booking=Booking.fromJson(res.data);
//         print(res.data);
//         return Future.value(APIResponse.fromSuccess(hasData: true,data:booking));
//       }
//       else {
//         return Future.value(APIResponse.fromFailed(info:res.message));
//       }
//     }
//     catch(err) {
//       return Future.value(APIResponse.fromFailed(info:err.toString()));
//     }
//   }
//
//
// // not tried and tested!
//   Future<APIResponse> createOrder(Map<String,dynamic> data) async {
//     try{
//       var headers = {'authorization':'Bearer ${auth.token}',
//         // 'Content-Type':'application/json'
//       };
//       RequestResponse res = await networking.post(RequestPaths.CREATE_ORDER,data:data,headers: headers);
//
//       if(res.status == TextMessages.SUCCESS)
//       {
//         String orderId = res.data as String;
//         return Future.value(APIResponse.fromSuccess(hasData: true,data:orderId));
//       }
//       else {
//         return Future.value(APIResponse.fromFailed(info:res.message));
//       }
//     }
//     catch(err) {
//       return Future.value(APIResponse.fromFailed(info:err.toString()));
//     }
//   }
//
//   Future<APIResponse> bookEvent(Map<String,int> tickets,) async {
//     try{
//       RequestResponse res = await networking.post(RequestPaths.LOGIN,data:{"tickets":tickets});
//
//       if(res.status == TextMessages.SUCCESS)
//       {
//         String otpId = res.data as String;
//         return Future.value(APIResponse.fromSuccess(hasData: true,data:otpId));
//       }
//       else {
//         return Future.value(APIResponse.fromFailed(info:res.message));
//       }
//     }
//     catch(err) {
//       return Future.value(APIResponse.fromFailed(info:err.toString()));
//     }
//   }
}
