import 'package:getx/app/data/model/gravity/dpp_test_with_sections.dart';

import 'dpp_result.dart';
import 'dpp_test_context.dart';

class DppTestReport{
  List<DppTestContext> testStates =[];
  List<DppResult> results = [];
  late DppTestWithSections test;

  DppTestReport({required this.results,required this.testStates,required this.test});

  DppTestReport.fromJson(Map<String,dynamic> json,{bool questions = false}){
    print(1);
    var testStatusList = json['test_states'];
    for(var testState in testStatusList){
      testStates.add(DppTestContext.fromJson(testState,questions: questions));
    }
    print(2);
    var testResultList = json['test_results'];
    for(var testResult in testResultList){
      print(testResult);
      print("testResult");
      results.add(DppResult.fromJson(testResult));
    }
    test = DppTestWithSections.fromJSON(json['test'], questions);
  }
}


