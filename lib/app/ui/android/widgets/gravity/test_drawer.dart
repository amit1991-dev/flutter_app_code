



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controller/gravity/test_series/test_state_controller.dart';
import '../../../../data/constants/miscellaneous.dart';
import '../../../../data/model/gravity/test_with_sections.dart';
import 'test_subject_menu_widgets.dart';

import '../miscellaneous.dart';

import 'dart:convert' as convert;
import 'package:flutter_tex/flutter_tex.dart'; // Import for TeXView

convert.Codec<String, String> stringToBase64 =
    convert.utf8.fuse(convert.base64);

Widget getSideMenuPortrait(final TestWithSections test,BuildContext context)
{

    final TeXViewRenderingEngine renderingEngine =
      const TeXViewRenderingEngine.mathjax();

  // print(test.)
  return Container(
      width:Get.width * 0.8,
      decoration: BoxDecoration(color: Colors.white),
      child:DefaultTabController(
        length: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: clumsyTextLabel("Test Status"),
            ),
            TestClockWidget(),
            TestStatusReport(),
            legends(),
            TabBar(
              // automaticIndicatorColorAdjustment: false,
              // indicator: BoxDecoration(shape: BoxShape.circle),
              indicatorPadding: EdgeInsets.all(8.0),
              tabs: [
                Tab(
                  child: Text("Questions",style: TextStyle(color:Colors.grey),),
                ),
                Tab(
                  child: Text("Instruction",style: TextStyle(color: Colors.grey),),
                  
                )
              ],
              indicatorColor:appColors["primary"]!,
            ),
            Expanded(
              flex: 1,
              child: TabBarView(

                  children: [
                    Column(
                      children: [
                        Expanded(
                          flex:1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [

                                // Divider(color: Colors.black,),
                                getSubjectSelectionBar(test,context),
                                SubjectWiseTestQuestions(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
            
              // ... (Questions tab content) ...
             
                    Column(
                      children: [
                        Expanded(
                          flex:1,
                          child:Padding( // Directly display instructions using TeXView
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: TeXView(
                    renderingEngine: renderingEngine,
                    child: TeXViewDocument(
                      stringToBase64.decode(test.instructions),
                      style: TeXViewStyle(
                        backgroundColor: appColors["white"]!,
                        padding: TeXViewPadding.all(10),
                      ),
                    ),
                  ),
                ),
              ),
                        )
                      ],
                    ),
                 
                  ]),
            ),


          ],
        ),
      )
  );
}

Widget getSubjectSelectionBar(final TestWithSections test,BuildContext context)
{
  List<Widget> subjectTitles;

    subjectTitles = List.generate(test.subjectWise!.keys.length, (index) {
        return Obx(
          () {
               return Container(
                margin: EdgeInsets.all(2.0),
                padding: EdgeInsets.all(0.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Get
                        .find<TestStateController>()
                        .currentSubject
                        .value == test.subjectWise!.keys.elementAt(index)
                        ? appColors["primary"]
                        : appColors["white"]),
                child: InkWell(
                  child: Container(padding: EdgeInsets.all(8.0),
                      child: Text(
                          test.subjectWise!.keys.elementAt(index).toUpperCase(),
                          style: TextStyle(color: Get
                              .find<TestStateController>()
                              .currentSubject
                              .value == test.subjectWise!.keys.elementAt(index)
                              ? Colors.white
                              : appColors['primary'], fontSize: 10.0)
                              )
                              ),
                  onTap: () {
                    Get.find<TestStateController>().setCurrentSubject(test.subjectWise!.keys.elementAt(index));
                    // Provider.of<JeeMainsStateProvider>(context,listen: false).setCurrentSubject(test.subjectWise.keys.elementAt(index));
                  },
                ),
              );
            }
        );
      });
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Row(
        children: [
          Spacer(),
          ...subjectTitles,
          Spacer()
        ],
      ),
    );
}