import 'package:getx/app/data/model/gravity/test_with_sections.dart';

import 'result.dart';
import 'test_context.dart';

class TestReport{
  List<TestContext> testStates =[];
  List<Result> results = [];
  late TestWithSections test;

  TestReport({required this.results,required this.testStates,required this.test});

  TestReport.fromJson(Map<String,dynamic> json,{bool questions = false}){
    print(1);
    var testStatusList = json['test_states'];
    for(var testState in testStatusList){
      testStates.add(TestContext.fromJson(testState,questions: questions));
    }
    print(2);
    var testResultList = json['test_results'];
    for(var testResult in testResultList){
      print(testResult);
      print("testResult");
      results.add(Result.fromJson(testResult));
    }
    test = TestWithSections.fromJSON(json['test'], questions);
  }
}


