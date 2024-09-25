import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx/app/data/model/gravity/test_context.dart';
import 'package:getx/app/data/provider/gravity/student_api.dart';
import '../../data/model/city_state.dart';
import '../../data/model/gravity/dpp_test_context.dart';
import '../../data/model/gravity/question_status.dart';
import '../../routes/app_pages.dart';
import '../../data/constants/errors.dart';
import '../../data/constants/miscellaneous.dart';
import '../../data/constants/request_paths.dart';
import '../../data/model/api_response.dart';
import '../../data/model/cart.dart';
import '../../data/model/event.dart';
import '../../data/provider/user_api.dart';

class StudentsController extends GetxController {

  late final StudentsAPIProvider studentsAPIProvider;
  // final Rx<Cart> cart=Cart(body:{}).obs;
  // final Rx<CityState> cityState = CityState.defaultCity().obs;
  
  // Test? cartEvent;

  StudentsController(){
    studentsAPIProvider = StudentsAPIProvider();
  }

  Future<APIResponse> getStreams() async {
    return await studentsAPIProvider.getStreams();
  }

  Future<APIResponse> getBatches() async {
    return await studentsAPIProvider.getBatches();
  }

  Future<APIResponse> getBatch(String batchId) async {
    return await studentsAPIProvider.getBatch(batchId);
  }

  Future<APIResponse> getMyBatch() async {
    return await studentsAPIProvider.getMyBatch();
  }




  Future<APIResponse> getMyBatches() async {
    return await studentsAPIProvider.getMyBatches();
  }

//golu lectures api subject-chapterwise start

  Future<APIResponse> getBatchSubject(String batchId) async {
    return await studentsAPIProvider.getBatchSubject(batchId);
  }

  Future<APIResponse> getBatchSubjectChapter(String batchSubjectId) async {
    return await studentsAPIProvider.getBatchSubjectChapter(batchSubjectId);
  }

  Future<APIResponse> getBatchSubjectChapterLecture(String batchChapterId) async {
    return await studentsAPIProvider.getBatchSubjectChapterLecture(batchChapterId);
  }

//golu lectures api subject-chapterwise end

//golu chapterwise tests api start


   Future<APIResponse> getBatchSubjectCwTests(String batchId) async {
    return await studentsAPIProvider.getBatchSubjectCwTests(batchId);
  }

    Future<APIResponse> getBatchSubjectContentCwTests(String batchSubjectId) async {
    return await studentsAPIProvider.getBatchSubjectContentCwTests(batchSubjectId);
  }

//golu chapterwise tests api end


//golu dpp tests api start


   Future<APIResponse> getBatchSubjectDppTests(String batchId) async {
    return await studentsAPIProvider.getBatchSubjectDppTests(batchId);
  }

 Future<APIResponse> getBatchSubjectChapterDppTests(String batchSubjectId) async {
    return await studentsAPIProvider.getBatchSubjectChapterDppTests(batchSubjectId);
  }

   Future<APIResponse> getBatchSubjectChapterContentDppTests(String batchSubjectId) async {
    return await studentsAPIProvider.getBatchSubjectChapterContentDppTests(batchSubjectId);
  }

  Future<APIResponse> getDppTestReport(String testId) async {
    return await studentsAPIProvider.getDppTestReport(testId);
  }


  Future<APIResponse> getDppTestState(String testStateId,{bool questions=false}) async {
    return await studentsAPIProvider.getDppTestState(testStateId, questions);
  }

  Future<APIResponse> createNewDppTestState(String testId,String batchId) async {
    return await studentsAPIProvider.createNewDppTestState(testId,batchId);
  }

  Future<APIResponse> submitDppTest(DppTestContext tc) async {
    return await studentsAPIProvider.submitDppTestState(tc);
  }

  Future<APIResponse> getDppTestQuestion(String testId) async {
    return await studentsAPIProvider.getDppTestQuestion(testId);
  }

  Future<APIResponse> getDppTestResult(String testResultId) async {
    return await studentsAPIProvider.getDppTestResult(testResultId);
  }

//golu dpp tests api end


  Future<APIResponse> getLecture(String lectureId) async {
    return await studentsAPIProvider.getLecture(lectureId);
  }


  Future<APIResponse> getGravityResults() async {
    return await studentsAPIProvider.getGravityResults();
  }

  // Future<APIResponse> getStream(String streamId) async {
  //   return await studentsAPIProvider.getStreams(streamId);
  // }

  Future<APIResponse> getTest(String testId,{bool expanded=false}) async {
    return await studentsAPIProvider.getTest(testId,expanded: expanded);
  }



  // Future<APIResponse> getStreams() async {
  //   return await studentsAPIProvider.getStudentInformation();
  // }

  Future<APIResponse> getStudentInfo() async {
    return await studentsAPIProvider.getStreams();
  }

  Future<APIResponse> getTests(String streamId) async {
    return await studentsAPIProvider.getTestsForStream(streamId);
  }

  Future<APIResponse> getTestReport(String testId) async {
    return await studentsAPIProvider.getTestReport(testId);
  }

  Future<APIResponse> getTestResult(String testId) async {
    return await studentsAPIProvider.getTestResult(testId);
  }

  Future<APIResponse> getTestQuestion(String testId) async {
    return await studentsAPIProvider.getTestQuestion(testId);
  }

  Future<APIResponse> getTestState(String testStateId,{bool questions=false}) async {
    return await studentsAPIProvider.getTestState(testStateId, questions);
  }

  Future<APIResponse> createNewTestState(String testId,String batchId) async {
    return await studentsAPIProvider.createNewTestState(testId,batchId);
  }

  Future<APIResponse> getNotifications() async {
    return await studentsAPIProvider.getNotifications();
  }

  // Future<APIResponse> submitTest(TestContext tc) async {
  //   return await studentsAPIProvider.submitTestState(tc);
  // }

  Future<APIResponse> submitTestState(TestContext testContext) async {
    return await studentsAPIProvider.submitTestState(testContext);
  }

  Future<APIResponse> submitAI(String query) async {
    return await studentsAPIProvider.submitAI(query);
  }

  //Previous Year Questions == EXAMS API
  Future<APIResponse> getExams() async {
    return await studentsAPIProvider.getExams();
  }
  Future<APIResponse> getExam(String examId,String subjectId,String chapterId) async {
    return await studentsAPIProvider.getExam(examId,subjectId,chapterId);
  }

  Future<APIResponse> getExamQuestions(String examId,String subjectId,String chapterId) async {
    return await studentsAPIProvider.getExamQuestions(examId,subjectId,chapterId);
  }

  Future<APIResponse> getExamSubjectChapters(String examId,String subjectId) async {
    return await studentsAPIProvider.getExamSubjectChapters(examId,subjectId);
  }

  Future<APIResponse> getExamSubjects(String examId,) async {
    return await studentsAPIProvider.getExamSubjects(examId);
  }
  //Previous year questions ends here


  //Modules API

  // Future<APIResponse> getModule(String moduleId) async {
  //   return await studentsAPIProvider.getModule(moduleId);
  // }

  Future<APIResponse> getModuleChapter(String moduleChapterId) async {
    return await studentsAPIProvider.getModuleChapter(moduleChapterId);
  }

  Future<APIResponse> getBatchSubjectsForModules(String batchId) async {
    return await studentsAPIProvider.getBatchSubjectsForModules(batchId);
  }
  // Future<APIResponse> getBatchModulesForSubjects(String batchId,String subjectId) async {
  //   return await studentsAPIProvider.getBatchModulesForSubjects(batchId,subjectId);
  // }

  // Future<APIResponse> getExams() async {
  //   return await studentsAPIProvider.getExams();
  // }
  // Future<APIResponse> getExam(String examId) async {
  //   return await studentsAPIProvider.getExam(examId);
  // }
  //
  // Future<APIResponse> getExamQuestions(String examId,String subjectId,String chapterId) async {
  //   return await studentsAPIProvider.getExamQuestions(examId,subjectId,chapterId);
  // }
  //
  // Future<APIResponse> getExamSubjectChapters(String examId,String subjectId) async {
  //   return await studentsAPIProvider.getExamQuestions(examId,subjectId);
  // }
  //
  // Future<APIResponse> getExamSubjects(String examId,) async {
  //   return await studentsAPIProvider.getExamSubjects(examId);
  // }
  //Modules ends here


  // Lectures API
  // Future<APIResponse> getModule(String moduleId) async {
  //   return await studentsAPIProvider.getModule(moduleId);
  // }
  //
  // Future<APIResponse> getModuleChapter(String moduleChapterId) async {
  //   return await studentsAPIProvider.getModuleChapter(moduleChapterId);
  // }



  Future<APIResponse> getChapterLectures(String batchId,String subjectId, String chapterId) async {
    return await studentsAPIProvider.getChapterLectures(batchId,subjectId, chapterId);
  }


  Future<APIResponse> getSubjectsForLectures(String batchId) async {
    return await studentsAPIProvider.getSubjectsForLectures(batchId);
  }


  Future<APIResponse> getLectureChaptersForSubject(String batchId,String subjectId) async {
    return await studentsAPIProvider.getLectureChaptersForSubject(batchId,subjectId);
  }

  // Lectures API ends


  // Files API start
  Future<APIResponse> getChapterFiles(String batchId,String subjectId, String chapterId) async {
    return await studentsAPIProvider.getChapterFiles(batchId,subjectId, chapterId);
  }


  Future<APIResponse> getSubjectsForFiles(String batchId) async {
    return await studentsAPIProvider.getSubjectsForFiles(batchId);
  }


  Future<APIResponse> getFilesChaptersForSubject(String batchId,String subjectId) async {
    return await studentsAPIProvider.getFilesChaptersForSubject(batchId,subjectId);
  }

  Future<APIResponse> getFile(String fileId) async {
    return await studentsAPIProvider.getFile(fileId);
  }

  // Files end


  //PYQ section
  // Future<APIResponse> getPYQSubjects(String examId) async {
  //   return await studentsAPIProvider.getPYQSubjects(examId);
  // }


  // Future<APIResponse> getSubjectsForFiles(String batchId) async {
  //   return await studentsAPIProvider.getSubjectsForFiles(batchId);
  // }
  //
  //
  // Future<APIResponse> getFilesChaptersForSubject(String batchId,String subjectId) async {
  //   return await studentsAPIProvider.getFilesChaptersForSubject(batchId,subjectId);
  // }
  //
  // Future<APIResponse> getFile(String fileId) async {
  //   return await studentsAPIProvider.getFile(fileId);
  // }

  //PYQ ends

  Map<String,int> evaluateQuestionStatus(List<QuestionStatus> lqs){
    Map<String,int> data = {'visited':0,'unvisited':0,'unanswered':0,'marked_saved':0,'saved':0,'marked':0,'total':lqs.length};
    for(QuestionStatus qs in lqs){
      if(qs.vstate.value==VisitState.VISITED){
        data['visited'] = data['visited']!+1;
        if(qs.astate.value==AnsweredState.ANSWERED_SAVED ){
          data['saved'] = data['saved']!+1;
        }
        if(qs.rstate.value==ReviewState.MARKED){
          data['marked'] = data['marked']!+1;
        }
        if(qs.astate.value==AnsweredState.ANSWERED_SAVED && qs.rstate.value==ReviewState.MARKED){
          data['marked_saved'] = data['marked_saved']!+1;
        }
      }
      else{
        data['unvisited'] = data['unvisited']!+1;
      }
    }
    data['unanswered']=data['total']!-data['saved']!-data['unvisited']!;
    return data;
  }



  Future<APIResponse> updateUser(Map<String,dynamic> data) async{
    APIResponse res ;
    // res = APIResponse(status: "success",data: Event(id: eventId,name:"test Event",phases:[],medias: [],enabled: true,venue: "ventu",artist: "A.k Artist",bookingStatus: "Booking Open",category: "Category",subcategory: "Subcategory",city: "City",state: "State",description: "Description",eventDuration: "Event Duration",eventStatus: "Event Status",eventStatusExtra: "Event Status Extra",eventTimestamp: DateTime.now().toString(),eventType: "Concert",pincode: "243002",recurring: "none",termsConditions: "Terms and Conditions"));
    res =  await studentsAPIProvider.updateUserdata(data);

    if(res.status == TextMessages.SUCCESS)
    {
      return res;
    }
    else
    {
      Get.snackbar("Error", res.info!);
      if(res.info == ErrorMessages.NLI)
      {
        Get.offNamed(Routes.LOGIN);
      }
      return res;
    }
  }

  // Future<APIResponse> switchToHost() async{
  //   APIResponse res ;
  //   res =  await studentsAPIProvider.switchToHost();
  //   return res;
  // }
  //
  // Future<APIResponse> createOrder(Map<String,dynamic> data) async {
  //   return await studentsAPIProvider.createOrder(data);
  // }
  //
  // Future<APIResponse> getEventsFeatured() async {
  //   return await studentsAPIProvider.getEventsForPath(RequestPaths.GET_EVENTS_FEATURED);
  // }
  //
  // Future<APIResponse> getEventsTodays() async {
  //   return await studentsAPIProvider.getEventsForPath(RequestPaths.GET_EVENTS_TODAY);
  // }
  //
  // Future<APIResponse> getEventsUpcoming() async {
  //   return await studentsAPIProvider.getEventsForPath(RequestPaths.GET_EVENTS_UPCOMING);
  // }
  //
  // Future<APIResponse> getEventsByTypes(String eventType) async {
  //   return await studentsAPIProvider.getEventsByTypes(eventType.toLowerCase());
  // }
  //
  // Future<APIResponse> searchEvents(String searchString) async {
  //   return await studentsAPIProvider.searchEvents(searchString);
  // }
  //
  // Future<APIResponse> getEvent(String eventId,{bool test = false}) async{
  //   APIResponse res ;
  //   res =  await studentsAPIProvider.getEvent(eventId);
  //
  //   if(res.status == TextMessages.SUCCESS)
  //   {
  //     return res;
  //   }
  //   else
  //   {
  //     showSnackbar("Error", res.info!);
  //     if(res.info == ErrorMessages.NLI)
  //     {
  //       Get.offNamed(Routes.LOGIN);
  //     }
  //     return res;
  //   }
  // }
  //
  // Future<APIResponse> getBooking(String bookingId,{bool test = false}) async{
  //   APIResponse res ;
  //   // res = APIResponse(status: "success",data: Event(id: eventId,name:"test Event",phases:[],medias: [],enabled: true,venue: "ventu",artist: "A.k Artist",bookingStatus: "Booking Open",category: "Category",subcategory: "Subcategory",city: "City",state: "State",description: "Description",eventDuration: "Event Duration",eventStatus: "Event Status",eventStatusExtra: "Event Status Extra",eventTimestamp: DateTime.now().toString(),eventType: "Concert",pincode: "243002",recurring: "none",termsConditions: "Terms and Conditions"));
  //   res =  await studentsAPIProvider.getBooking(bookingId);
  //
  //   if(res.status == TextMessages.SUCCESS)
  //   {
  //     return res;
  //   }
  //   else
  //   {
  //     showSnackbar("Error", res.info!);
  //     if(res.info == ErrorMessages.NLI)
  //     {
  //       Get.offNamed(Routes.LOGIN);
  //     }
  //     return res;
  //   }
  // }
  //
  // Future<APIResponse> getBookings() async{
  //   APIResponse res ;
  //   // res = APIResponse(status: "success",data: Event(id: eventId,name:"test Event",phases:[],medias: [],enabled: true,venue: "ventu",artist: "A.k Artist",bookingStatus: "Booking Open",category: "Category",subcategory: "Subcategory",city: "City",state: "State",description: "Description",eventDuration: "Event Duration",eventStatus: "Event Status",eventStatusExtra: "Event Status Extra",eventTimestamp: DateTime.now().toString(),eventType: "Concert",pincode: "243002",recurring: "none",termsConditions: "Terms and Conditions"));
  //   res =  await studentsAPIProvider.getBookings();
  //
  //   if(res.status == TextMessages.SUCCESS)
  //   {
  //     print("successfully aquired bookings");
  //     return res;
  //   }
  //   else
  //   {
  //     showSnackbar("Error", res.info!);
  //     if(res.info == ErrorMessages.NLI)
  //     {
  //       Get.offNamed(Routes.LOGIN);
  //     }
  //     return res;
  //   }
  // }
  //
  // Future<APIResponse> setEmail(String email) async{
  //   APIResponse res ;
  //   // res = APIResponse(status: "success",data: Event(id: eventId,name:"test Event",phases:[],medias: [],enabled: true,venue: "ventu",artist: "A.k Artist",bookingStatus: "Booking Open",category: "Category",subcategory: "Subcategory",city: "City",state: "State",description: "Description",eventDuration: "Event Duration",eventStatus: "Event Status",eventStatusExtra: "Event Status Extra",eventTimestamp: DateTime.now().toString(),eventType: "Concert",pincode: "243002",recurring: "none",termsConditions: "Terms and Conditions"));
  //   res =  await studentsAPIProvider.saveUserEmail(email);
  //
  //   if(res.status == TextMessages.SUCCESS)
  //   {
  //     return res;
  //   }
  //   else
  //   {
  //     showSnackbar("Error", res.info!);
  //     if(res.info == ErrorMessages.NLI)
  //     {
  //       Get.offNamed(Routes.LOGIN);
  //     }
  //     return res;
  //   }
  // }
  //
  // Future<APIResponse> getCategoryEvents(String category,{bool test = false}) async{
  //   APIResponse res ;
  //   // res = APIResponse(status: "success",data: Event(id: eventId,name:"test Event",phases:[],medias: [],enabled: true,venue: "ventu",artist: "A.k Artist",bookingStatus: "Booking Open",category: "Category",subcategory: "Subcategory",city: "City",state: "State",description: "Description",eventDuration: "Event Duration",eventStatus: "Event Status",eventStatusExtra: "Event Status Extra",eventTimestamp: DateTime.now().toString(),eventType: "Concert",pincode: "243002",recurring: "none",termsConditions: "Terms and Conditions"));
  //   if(test)
  //   {
  //     var fakeData = [];
  //     fakeData.addAll(List.generate(5, (index) => {Event(id: index.toString(),name:"test Event",phases:[],medias: [],enabled: true,venue: "ventu",artist: "A.k Artist",bookingStatus: "Booking Open",category: "Category",subcategory: "Subcategory",city: "City",state: "State",description: "Description",eventDuration: "Event Duration",eventStatus: "Event Status",eventStatusExtra: "Event Status Extra",eventTimestamp: DateTime.now().toString(),eventType: "Concert",pincode: "243002",recurring: "none",termsConditions: "Terms and Conditions")}));
  //     res = APIResponse(status: "success",data: fakeData);
  //     return res;
  //   }
  //   else{
  //     res =  await studentsAPIProvider.getcategoricalEvents(category);
  //   }
  //   if(res.status == TextMessages.SUCCESS)
  //   {
  //     return res.data;
  //   }
  //   else
  //   {
  //     showSnackbar("Error", res.info!);
  //     if(res.info == ErrorMessages.NLI)
  //     {
  //       Get.offNamed(Routes.LOGIN);
  //     }
  //     return APIResponse.fromFailed(info: res.info);
  //   }
  // }
}