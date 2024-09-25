// TODO Implement this library.
import 'dpp_question_marking.dart';


class DppResult{
  String id,testId,studentId;
  int total,maxMarks,duration,attemptNumber=0;
  IntInfo resultInfo=IntInfo();
  List<QuestionMarking> qml;
  String? declarationTime;
  Map<String,List<QuestionMarking>> subjectWiseMarking ={};
  Map<String,IntInfo> subjectWiseinfo ={};

  DppResult(this.id,this.studentId,this.testId,this.total,this.maxMarks,this.qml,this.duration,this.attemptNumber,{this.declarationTime}) {
    print("duration:"+duration.toString());
    for (var element in qml) {
      print("almost done constructing the result object");
      resultInfo.a += 1;
      resultInfo.b += element.attempted?1:0;
      resultInfo.c += element.correctly_marked?1:0;
      resultInfo.d += element.correctly_marked?0:1;
      resultInfo.e += element.marksObtainted;
      resultInfo.f += element.attempted?0:1;
      resultInfo.g += element.visited?1:0;
      resultInfo.h += element.visited?0:1;
      print("almost done constructing the result object");
      if(subjectWiseMarking.containsKey(element.subject))
      {
        subjectWiseMarking[element.subject]!.add(element);
      }
      else{
        subjectWiseMarking[element.subject] = [element];
      }

      if(subjectWiseinfo.containsKey(element.subject))
      {
        IntInfo temp =subjectWiseinfo[element.subject]!;
        temp.a += 1;
        temp.b += element.attempted?1:0;
        temp.c += element.correctly_marked?1:0;//correct
        temp.d += element.correctly_marked?0:1;//incorrect
        temp.e += element.marksObtainted;
        temp.f += element.attempted?0:1;//not attempted
        temp.g += element.visited?1:0;
        temp.h += element.visited?0:1;// not visited
        subjectWiseinfo[element.subject] = temp;
      }
      else{
        subjectWiseinfo[element.subject] = IntInfo(a:1,b:element.attempted?1:0,c:element.correctly_marked?1:0,d:element.correctly_marked?0:1,e:element.marksObtainted);
      }
    }
  }

  factory DppResult.fromJson(Map<String,dynamic> json)
  {
    List<QuestionMarking> qml =[];
    List marked = json['marked'];
    // attemptNumber = json['attempt_number']??0;
    for(int i =0;i<marked.length;i++)
      {
        print("creating question Marking");
        qml.add(QuestionMarking.fromJSON(marked[i]));
      }
    print("creating result object");
    print(json['duration']);
    return DppResult(json['_id'],json['student'],json['test'],json['total'],json['max_marks'],qml,json['duration'],json['attempt_number']??0,declarationTime: json['declaration_time']);
  }

  @override
  String toString() {
    // TODO: implement toString
    StringBuffer sb = StringBuffer();
    sb.write(testId+","+studentId+"\n");
    for (var element in qml) {
      sb.write(element.toString()+"\n");
    }
    return sb.toString();
  }


}


class IntInfo{
  int a=0,b=0,c=0,d=0,e=0,f=0,g=0,h=0;
  // a: total questions
  // b: total attempted
  // c: total correct
  // d: total wrong
  // e: total marks
  // f: not attempted
  // g: visited
  // h: not visited
  IntInfo({this.a=0,this.b=0,this.c=0,this.d=0,this.e=0,this.f=0,this.g=0,this.h=0});
}