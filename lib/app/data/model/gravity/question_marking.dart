// class QuestionMarking{
//   bool attempted,correctly_marked,visited;

//   String questionId,answer,subject;
//   int marksObtainted;
//   int timeAllotted = 0;
//   QuestionMarking(this.questionId,this.attempted,this.correctly_marked,this.answer,this.subject,this.marksObtainted,this.visited,this.timeAllotted);

//   factory QuestionMarking.fromJSON(Map<String,dynamic> json)
//   {
//     return QuestionMarking(json['question']['question'],json['attempted'],json['correctly_marked'],json['answer_value'],json['subject'],json['marks_obtained']??0,json['visited'],json['time_allotted']);
//   }

//   @override
//   String toString(){
//     return questionId;
//   }
// }

class QuestionMarking {
  bool attempted, correctly_marked, visited;

  String questionId, subject;
  dynamic answer; // Change type to dynamic to handle both string and List<String>
  int marksObtainted;
  int timeAllotted = 0;

  QuestionMarking(this.questionId, this.attempted, this.correctly_marked, this.answer, this.subject, this.marksObtainted,
      this.visited, this.timeAllotted);

  factory QuestionMarking.fromJSON(Map<String, dynamic> json) {
    // Handle potential List<String> for answer
    // dynamic answerValue = json['answer_value'];
    // if (answerValue is List) {
    //   answerValue = answerValue.cast<String>(); // Ensure it's a List<String>
    // }
    return QuestionMarking(
        json['question']['question'],
        json['attempted'],
        json['correctly_marked'],
        json['answer_value'],

        // answerValue, // Use the processed answerValue
        json['subject'],
        json['marks_obtained'] ?? 0,
        json['visited'],
        json['time_allotted']);
  }

  @override
  String toString() {
    return questionId;
  }
}
