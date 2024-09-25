
import "./question.dart";
class Test {
  String name,id,test_type,instructions;
  List<String> subjects;
  List<Question>? lq;
  int duration,max_marks,class_number;

  dynamic? structure;
  Map<String,List<Question>>? subjectWise;

  String? startTime,endTime;

  //Constructors
  Test._minimal(this.id,this.name,this.test_type,this.subjects,this.duration,this.max_marks,this.class_number,this.instructions,{this.startTime,this.endTime});
  Test._withQuestions(this.id,this.name,this.test_type,this.subjects,this.duration,this.max_marks,this.class_number,this.instructions,this.lq,this.subjectWise,this.structure,{this.startTime,this.endTime});

  factory Test.fromJSON(Map<String,dynamic> json,bool questions)
  {

    if(questions)
    {
      List<Question> lq=[];
      List questions = json['questions'];
      Map<String,List<Question>> subjectWise={};
      int i=0;

      for(int j=0; j<questions.length;j++)
        {
          var element = questions[j];
          Question temp= Question.minimalFromJSON(element);
          print("$j : J");
          // i+=1;
          lq.add(temp);
          if(!subjectWise.containsKey(element['subject']))
          {
            subjectWise[element['subject']] = [];
          }
          subjectWise[element['subject']]?.add(temp);
        }

      return Test._withQuestions(json['_id'],json['name'],json['test_type'],getListSubjects(json['subjects']),json['duration'],json['max_marks'],json['class_number'],json['instructions'],lq,subjectWise,json['structure'],startTime: json['start_time'],endTime: json['end_time']);
    }
    return Test._minimal(json['_id'],json['name'],json['test_type'],getListSubjects(json['subjects']),json['duration'],json['max_marks'],int.parse(json['class_number']),'instructions',startTime: json['start_time'],endTime: json['end_time']);
  }

  @override
  String toString()
  {
    StringBuffer sb = StringBuffer();
    if(lq!=null)
      {
        for (var element in lq!) {
          sb.write(element.toString());
        }
      }
    return "$name:${test_type.length} , $sb";
  }


  static List<String> getListSubjects(List<dynamic> data){
    List<String> subjects =[];
    for (var element in data) {
      subjects.add(element.toString());
    }
    return subjects;

  }

}
