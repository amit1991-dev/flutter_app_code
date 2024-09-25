import 'dart:async';
import 'package:get/get.dart';
import '../../../data/constants/miscellaneous.dart';

import '../../../routes/app_pages.dart';
import '../../../data/provider/gravity/student_api.dart';
import '../../../data/model/gravity/dpp_question_status.dart';
import '../../../data/model/gravity/dpp_test_question.dart';
import '../../../data/model/gravity/dpp_test_context.dart';
import '../../../data/model/gravity/dpp_test_with_sections.dart';
import '../../../data/constants/request_paths.dart';
import '../../../data/model/api_response.dart';
import '../../../ui/android/widgets/miscellaneous.dart';

class DppTestStateController extends GetxController {
  late DppTestContext testContext;
  late final StudentsAPIProvider studentsAPIProvider;
  late DppTestWithSections testWithSections;
  late Timer testTimer;
  late List<DppQuestionStatus> selected;//initialize this one
  late Rx<String> currentSubject;
  late List<DppTestQuestion> questions;
  int timeLimit=0,totalQuestions=0;
  Rx<int> currentQuestion=0.obs,time=0.obs;
  TimeState timeState = TimeState.ALOT;
  TestState testState = TestState.STARTED;

  DppTestStateController({required this.testContext}){
    testWithSections = testContext.testWithSections!;
    timeLimit = testWithSections.duration*60;
    time.value = testContext.timeLeft;
    questions = testWithSections.lq!;
    currentSubject=testWithSections.lq![currentQuestion.value].subject.name.obs;
    studentsAPIProvider = StudentsAPIProvider();
    selected = testContext.lqs;
    timerFunction();
  }
  Future<APIResponse> resume() async {
    return await studentsAPIProvider.getTestsForStream(RequestPaths.GET_STUDENT_STREAMS);
  }

  Future<APIResponse> getNotifications() async {
    return await studentsAPIProvider.getNotifications();
  }

  void timerFunction() async{
    // print("timer started");
    await decrementTime();
    if(testState == TestState.STARTED)
    {
      // print(testState);
      if(time.value%10==0){
        syncServer();
      }
      testTimer=Timer(Duration(seconds: 1),timerFunction);
    }
    else
    {
      testTimer.cancel();
      // print("completed timer now2");
      if(testState != TestState.FINISHED)
      {
        print("stopping success timer");}
      else{
          print("stopping failed timer");
      }
    }
  }

  Future<void> decrementTime() async
  {
    selected.elementAt(currentQuestion.value).incrementTimeSpent();
    // print(time.toString());
    if(time.value>0 && !(testState==TestState.FINISHED || testState == TestState.SUBMITTED || testState==TestState.ERROR_SUBMITTING) )
    {
      // print(time.value);
      time.value-=1;
      if((timeLimit-time.value) > timeLimit-10*60 && timeState!=TimeState.DANGER){
        timeState = TimeState.DANGER;
      }
      else if((timeLimit-time.value) > timeLimit/2 && timeState!=TimeState.HALFWAY){
        timeState = TimeState.HALFWAY;
      }
    }
    else
    {
      if(time.value==0)
      {
        Get.snackbar("Time's Up", "Submitting Test");
        timeState = TimeState.UP;
      }
      await submitTest();
      // TODO: submit result and move on to the results page!
    }
  }


  void setCurrentSubject(String str) {
    print("setting current subject to this");
    currentSubject.value = str;
  }

  void setCurrentQuestion(int index) {
    currentQuestion.value = index;
    selected[currentQuestion.value].vstate.value=VisitState.VISITED;
    // selected[currentQuestion.value].setAnswer(answer)
    currentSubject.value = questions[index].subject.name;
  }

  Future<bool> submitTest() async {
    if(testState != TestState.FINISHED){
      print("Stopping the test");
      testTimer.cancel();

      if(await syncServer()){
        print("test state updated successfully");
        APIResponse res=await studentsAPIProvider.submitDppTestState(testContext);

        if(res.status == TextMessages.SUCCESS){
          print("test result created successfully");
          showSnackbar("Result Saved", "Successfully");
          testState = TestState.SUBMITTED;
          // Get.back();
          Get.toNamed(Routes.POST_DPP_TEST_PAGE,arguments:{"test_state_id":testContext.id,"result_id":res.data});
          print("done saving result");
          testState = TestState.FINISHED;
          dispose();

          return true;
        }
        else{
          print("some error has occurred");
          print(res.info!);
          showSnackbar("Error",res.info!);
          testState = TestState.ERROR_SUBMITTING;
          return false;
        }


      }
      else{
        print("some error has occured");
        testState = TestState.ERROR_SUBMITTING;
        return false;
      }

    }
    else{
      print("entered again!!");
    }
    return true;

  }

  Future<bool> syncServer() async {
    print("Calling syncServer");
    testContext.timeLeft = time.value;
    APIResponse res=await studentsAPIProvider.updateDppTestState(testContext);
    if(res.status == TextMessages.SUCCESS){
      print("time remainig${res.data}");
      time.value = res.data;
      return true;
    }
    else{

      return false;
    }
  }

}