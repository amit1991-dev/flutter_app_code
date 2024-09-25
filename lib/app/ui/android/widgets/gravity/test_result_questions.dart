import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'subject_wise_questions_widget.dart';

import '../../../../data/model/gravity/question_marking.dart';



class TestResultQuestions extends StatefulWidget {
  Map<String,List<QuestionMarking>> subjectWiseMarking;
  TestResultQuestions(this.subjectWiseMarking,{Key? key}) : super(key: key);

  @override
  _TestResultQuestionsState createState() => _TestResultQuestionsState();
}

class _TestResultQuestionsState extends State<TestResultQuestions> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.white),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("View Questions and Solutions",style: TextStyle(fontSize: 20,
                      color: Colors.grey,
                      // fontWeight: FontWeight.bold
                      )
                      ,),
                    ),

                  ],
                ),
              ),
            ),
            Column(
              children: List.generate(widget.subjectWiseMarking.keys.length, (index){

                return SubjectWiseQuestions(widget.subjectWiseMarking.keys.elementAt(index), widget.subjectWiseMarking[widget.subjectWiseMarking.keys.elementAt(index)]!);
              }),
            )







          ],
        ),
      ),
    );
  }
}