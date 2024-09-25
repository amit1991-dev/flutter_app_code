
import "test_question.dart";
import "test_section.dart";
class TestWithSections {
  late String name,id,test_type,instructions;
  late int duration,max_marks;

  Map<String,List<TestQuestion>>? subjectWise;
  List<TestQuestion>? lq;
  List<TestSection>? testSections;

  String? startTime,endTime;

  TestWithSections.fromJSON(Map<String,dynamic> json,bool questions)
  {
    // print(questions);
    print('amit-questions:$questions');

    id = json['_id'];
    name = json['name'];
    print("testwithsections: 1");
    test_type = json['test_type'];
    // print(json['instructions']);
    instructions = json['instructions']??"-";
    duration = json['duration'];
    print(duration);
    print(instructions);
    print("testwithsections: 2");
    // print(json['max_marks']);
    max_marks = json['max_marks']??100;
    print(max_marks);
    print("testwithsections: 1");

    startTime = json['start_time'];
    endTime = json['end_time'];
    print("object4");

    if(questions)
    {
      print("found questions ");
      dynamic structure = json['structure'];
      var sections = structure['sections'];
    print("object5");

      testSections = [];
      for(var section in sections){
        testSections!.add(TestSection.fromJSON(section));
      }
      lq=[];
      subjectWise={};
      int index=0;
      for(var section in testSections!){
        List<TestQuestion> questions = section.sectionQuestions;

        for(TestQuestion question in questions){
          if(!subjectWise!.containsKey(question.subject.name))
          {
            subjectWise![question.subject.name] = [];
          }
          question.testQuestionIndex=index;
          index++;
          subjectWise![question.subject.name]!.add(question);
        }
        lq!.addAll(questions);
      }
    print("object7");

    }
  }

}
