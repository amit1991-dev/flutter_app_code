import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dpp_subject_wise_questions_widget.dart';

import '../../../../data/model/gravity/dpp_question_marking.dart';



class DppTestResultQuestions extends StatefulWidget {
  Map<String,List<QuestionMarking>> subjectWiseMarking;
  DppTestResultQuestions(this.subjectWiseMarking,{Key? key}) : super(key: key);

  @override
  _DppTestResultQuestionsState createState() => _DppTestResultQuestionsState();
}

class _DppTestResultQuestionsState extends State<DppTestResultQuestions> {
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
                      child: Text("Question Paper"),
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