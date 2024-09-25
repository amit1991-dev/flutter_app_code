import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/app/routes/app_pages.dart';

import '../../../../data/model/gravity/dpp_question_marking.dart';

class SubjectWiseQuestions extends StatelessWidget {
  List<QuestionMarking> lqm;
  String subject;
  Random random = Random();

  late Color c;
  SubjectWiseQuestions(this.subject, this.lqm, {Key? key}) : super(key: key) {
    switch (subject.toLowerCase()) {
      case "chemistry":
        c = Colors.green;
        break;
      case "physics":
        c = Colors.blue;
        break;
      case "mathematics":
        c = Colors.red;
        break;
      case "biology":
        c = Colors.purple;
        break;
      case 'botany':
        c = Colors.deepPurple;
        break;
      default:
        c = Colors.grey;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        margin: EdgeInsets.all(8.0),
        width: double.infinity,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: c,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      topRight: Radius.circular(5.0))),
              child: Padding(
                padding: EdgeInsets.all(0.0),
                child: Column(
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.graphic_eq,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          subject,
                          style: TextStyle(color: Colors.white),
                        ),
                        Spacer(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 6,
              physics: new NeverScrollableScrollPhysics(),
              children: List.generate(lqm.length, (index) {
                String image = "assets/images/saved.png";
                if (lqm.elementAt(index).attempted) {
                  if (lqm.elementAt(index).correctly_marked) {
                    image = "assets/images/saved.png";
                  } else {
                    image = "assets/images/not_saved.png";
                  }
                } else {
                  image = "assets/images/empty.png";
                }

                return Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage(image))),
                      child: Center(
                          child: TextButton(
                              child: Text((index + 1).toString(),
                                  style: TextStyle(color: Colors.white)),
                              onPressed: () {
                                print("Got here!");
                                Get.toNamed(Routes.DPP_TEST_RESULT_QUESTION_PAGE,
                                    arguments: lqm[index]);
                                // Get.toNamed(Routes.TEST_RESULT_QUESTION_PAGE,
                                //     arguments: lqm[index]);
                                // Navigator.push(context,MaterialPageRoute(builder: (context) => TestQuestion(lqm.elementAt(index))));
                              }))),
                );
              }),
            ),
            Divider(
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
