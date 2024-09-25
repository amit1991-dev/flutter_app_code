import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx/app/data/model/gravity/test_with_sections.dart';
import 'package:getx/app/ui/android/widgets/miscellaneous.dart';

import 'dart:convert' as convert;

import '../../../../../controller/gravity/test_series/test_state_controller.dart';
import '../../../../../data/constants/miscellaneous.dart';
import '../../../../../data/model/gravity/question.dart';
import '../../../../../data/model/gravity/question_status.dart';
import '../../../../../data/model/gravity/test_question.dart';
import '../../../../../routes/app_pages.dart';
// import '../../../../data/model/gravity/question_status.dart';
convert.Codec<String, String> stringToBase64 = convert.utf8.fuse(convert.base64);

class QuizQuestionWidget extends StatefulWidget {
  late Question question;


  QuizQuestionWidget({required this.question});

  @override
  _QuizQuestionWidgetState createState() {
    return _QuizQuestionWidgetState();
  }
}

class _QuizQuestionWidgetState extends State<QuizQuestionWidget> {

  bool showingAnswer=false;
  bool isFirst = true;
  String answer="";


  void setAnswer(String answer)
  {
      if(!showingAnswer){
        setState(() {
          showingAnswer=false;
          this.answer = answer;
        });
      }
  }

  void showAnswer(){
    setState(() {
      showingAnswer=true;
    });
  }

  void clearAnswer(){
    setState(() {
      answer = "";
      showingAnswer=false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.question = Get.arguments as Question;
    // refresh();
  }

  @override
  Widget build(BuildContext context) {

    return generateQuestionBody(context);
  }


  refresh() async{
    await Future.delayed(const Duration(seconds: 1));
    print("building body again");
    setState(() {

    });
  }


  Widget generateQuestionBody(BuildContext context,){
    TeXViewRenderingEngine renderingEngine;
    // if(isFirst)
    //   {
    //     refresh();
    //     isFirst = false;
    //   }
    renderingEngine = const TeXViewRenderingEngine.katex();

    String questionType=widget.question.questionType;
    if(questionType=="scq"){
      return getSCQuestion(context, renderingEngine);
    }
    else if(questionType=="integer")
    {
      return getIntegerQuestion(context, renderingEngine);
    }
    else
    {
      return getUnknownQuestion(context,renderingEngine);
    }
  }



  Widget getSCQuestion(BuildContext context,TeXViewRenderingEngine renderingEngine){
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.all( 10.0),
          decoration: BoxDecoration(color: appColors["black"]!,borderRadius: BorderRadius.circular(20), ),
          child:Row(
                  children: [
                    Column(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children: [
                        Text("Q: Single Choice Question",style: TextStyle(color: appColors["white"]!),),
                      ],
                    ),
                    const Spacer(),
                    // Icon(Icons.help_outline,color: appColors["white"]!,)
                  ],
                )

          ),

        Container(
          decoration: BoxDecoration(color:appColors["white"]!),
          child: Column(
            children: [
              Container(
                // margin: EdgeInsets.only(top:10),
                padding: EdgeInsets.all(20),
                child: TeXView(
                    loadingWidgetBuilder: (context){
                      return Center(child: CircularProgressIndicator(color: appColors['primary']!,));
                    },
                    renderingEngine: renderingEngine,
                    child: TeXViewDocument(stringToBase64.decode(widget.question.question),
                        // style: TeXViewStyle(
                        //     // padding: const TeXViewPadding.all(0),
                        //     textAlign: TeXViewTextAlign.center,
                        //     fontStyle: TeXViewFontStyle(fontSize: 20,fontWeight: TeXViewFontWeight.bolder)
                        // )
                    ),
                    // style: TeXViewStyle(
                    //   elevation: 10,
                    //   backgroundColor: appColors["white"]!,
                    // ),
                  ),
                ),
              Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color:appColors["white"]!,
                      border: Border.all(color:answer=="A"?appColors["green"]!:appColors["grey"]!,width:answer=="A"?3:1 ),
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: ListTile(
                    onTap: (){
                      setAnswer("A");
                    },
                    selected: true,
                    contentPadding: const EdgeInsets.all(2.0),
                    leading: Container(padding: const EdgeInsets.all(15.0),decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(25.0)),color: Colors.black38), child: Text("A",style: TextStyle(color: appColors["white"]!))),
                    title: IgnorePointer(
                      child: TeXView(
                        renderingEngine: renderingEngine,
                        child: TeXViewDocument(stringToBase64.decode(widget.question.options[0].option_value),
                            // style: const TeXViewStyle(textAlign: TeXViewTextAlign.center)
                        ),
                        style: TeXViewStyle(backgroundColor: appColors["white"]!,),
                      ),

                    ),
                  ),
                ),

              // Divider(color: appColors["primary"]!,),
              Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color:appColors["white"]!,
                      border: Border.all(color:answer=="B"?appColors["green"]!:appColors["grey"]!,width:answer=="B"?3:1 ),
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: ListTile(
                    onTap: (){setAnswer("B");},
                    contentPadding: const EdgeInsets.all(2.0),
                    leading: Container(padding: const EdgeInsets.all(15.0),decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(25.0)),color: Colors.black38), child: Text("B",style: TextStyle(color: appColors["white"]!))),
                    title: IgnorePointer(
                      child: TeXView(
                        renderingEngine: renderingEngine,child: TeXViewDocument(stringToBase64.decode(widget.question.options[1].option_value),
                          // style: const TeXViewStyle(textAlign: TeXViewTextAlign.center)
                      ),
                        style: TeXViewStyle(backgroundColor: appColors["white"]!,),
                      ),
                    ),
                  ),
                ),

              // Divider(color: appColors["primary"]!,),
              Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color:appColors["white"]!,
                      border: Border.all(color:answer=="C"?appColors["green"]!:appColors["grey"]!,width:answer=="C"?3:1 ),
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: ListTile(
                    onTap: (){setAnswer("C");},
                    contentPadding: const EdgeInsets.all(2.0),
                    leading: Container(padding: const EdgeInsets.all(15.0),decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(25.0)),color: Colors.black38), child: Text("C",style: TextStyle(color: appColors["white"]!))),
                    title: IgnorePointer(
                      child:TeXView(
                        renderingEngine: renderingEngine,child: TeXViewDocument(stringToBase64.decode(widget.question.options[2].option_value),
                          // style: const TeXViewStyle(textAlign: TeXViewTextAlign.center)
                      ),
                        style: TeXViewStyle(backgroundColor: appColors["white"]!,),
                      ),
                    ),
                  ),
                ),

              // Divider(color: appColors["primary"]!,),
              Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color:appColors["white"]!,
                      border: Border.all(color:answer=="D"?appColors["green"]!:appColors["grey"]!,width:answer=="D"?3:1 ),
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: ListTile(
                    // tileColor: appColors['grey'],
                    onTap: (){setAnswer("D");},
                    contentPadding: const EdgeInsets.all(2.0),
                    leading: Container(padding: const EdgeInsets.all(15.0),decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(25.0)),color: Colors.black38), child: Text("D",style: TextStyle(color: appColors["white"]!))),
                    title: IgnorePointer(
                      child: TeXView(
                        renderingEngine: renderingEngine,child: TeXViewDocument(stringToBase64.decode(widget.question.options[3].option_value),
                          // style: const TeXViewStyle(textAlign: TeXViewTextAlign.center)
                      ),
                        style: TeXViewStyle(backgroundColor: appColors["white"]!,),
                      ),
                    ),
                  ),
                ),

            ],
          ),
        ),
         if(showingAnswer) Container(
          padding: const EdgeInsets.all(18.0),
           margin: const EdgeInsets.all( 10.0),
          decoration: BoxDecoration(color: answer==widget.question.correctAns?Colors.green:Colors.red,borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  clumsyTextLabel("Correct Answer: ", color: appColors['white']),
                  clumsyTextLabel(widget.question.correctAns??"-", color: appColors['white']),
                ],
              ),

              ClumsyFinalButton("View Solution", Get.width*0.8, () {
                Get.toNamed(Routes.SINGLE_QUESTION_PAGE,arguments: widget.question.id);
              }, false,color: Colors.white),
            ],
          ),
        ),
         Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.all( 10.0),
          decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              // GestureDetector(
              //     onTap: (){
              //       // setState(() {
              //       //   qs.toggleReview();
              //       // });
              //     },
              //     child: Container(padding: const EdgeInsets.all(10.0),decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(25.0)),color: appColors["purple"]!),child: Text("Review Later",style: TextStyle(color: appColors["white"]!)),)),

              GestureDetector(
                  onTap: (){

                    // setState(() {
                   clearAnswer();

                    // });
                  },
                  child: Container(padding: const EdgeInsets.all(10.0),decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(25.0)),color: appColors["red"]!),child: Text("Clear",style: TextStyle(color: appColors["white"]!)),)),


              GestureDetector(
                  onTap: (){
                    showAnswer();
                  },
                  child: Container(padding: const EdgeInsets.all(10.0),decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(25.0)),color:  appColors["green"]!),child: Text("Submit/Check",style: TextStyle(color: appColors["white"]!)),)),

            ],
          ),
        ),
      ],
    );
  }

  Widget getIntegerQuestion(BuildContext context,TeXViewRenderingEngine renderingEngine){
    TextEditingController answerController = TextEditingController(text:answer);
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.only(right: 0.0),
          decoration: BoxDecoration(color: appColors["black"]!,borderRadius: BorderRadius.circular(20), ),
          child:Row(
            children: [
              Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  Text("Q: Integer Type Question",style: TextStyle(color: appColors["white"]!),),
                ],
              ),
              const Spacer(),
              // Image.asset(image,height: 40,width: 40,),
              // Icon(Icons.help_outline,color: appColors["white"]!,)
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top:10),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                  ),
                  child: TeXView(
                    loadingWidgetBuilder: (context){
                      return Center(child: CircularProgressIndicator(color: appColors['primary']!,));
                    },
                    renderingEngine: renderingEngine,
                    child:TeXViewDocument(
                        stringToBase64.decode(widget.question.question),
                        style: TeXViewStyle(
                            padding: const TeXViewPadding.all(0),
                            margin:    TeXViewMargin.all(0),
                            // textAlign: TeXViewTextAlign.center,
                            // height: 200,
                            // sizeUnit: TeXViewSizeUnit.percent,
                            fontStyle: TeXViewFontStyle(fontSize: 10,fontWeight: TeXViewFontWeight.bolder)
                        )
                    ),
                    style: TeXViewStyle(
                      elevation: 0,
                      backgroundColor: appColors["white"]!,
                    ),
                  ),
                ),
                TextFormField(
                  controller: answerController,
                  style: TextStyle(color: Colors.black,fontSize: 25),
                  decoration: InputDecoration(
                    focusColor: Colors.grey,

                    prefixIcon: Icon(
                      Icons.arrow_right,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderSide:BorderSide(color: appColors['primary']!, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:BorderSide(color: appColors['primary']!, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    fillColor: Colors.grey,
                    hintText: "Answer",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontFamily: "verdana_regular",
                      fontWeight: FontWeight.w400,
                    ),
                    labelText: 'Integer Answer',
                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontFamily: "verdana_regular",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),

        ),
        if(showingAnswer) Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              clumsyTextLabel("Correct Answer: "),
              clumsyTextLabel(widget.question.correctAns??"-"),
            ],
          ),
        ),
        if(!showingAnswer) Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: (){
                    clearAnswer();
                  },
                  child: Container(padding: const EdgeInsets.all(10.0),decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(25.0)),color: appColors["red"]!),child: Text("Clear",style: TextStyle(color: appColors["white"]!)),)),
              GestureDetector(
                  onTap: (){
                    showAnswer();
                  },
                  child: Container(padding: const EdgeInsets.all(10.0),decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(25.0)),color:  appColors["green"]!),child: Text("Submit/Check",style: TextStyle(color: appColors["white"]!)),)),
            ],
          ),
        ),
      ],
    );
  }

  Widget getUnknownQuestion(BuildContext context,TeXViewRenderingEngine renderingEngine){
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.only(right: 0.0),
          decoration: BoxDecoration(color: appColors["black"]!,borderRadius: BorderRadius.circular(20), ),
          child:Row(
            children: [
              Text("Q: Question",style: TextStyle(color: appColors["white"]!),),
              const Spacer(),
              Icon(Icons.help_outline,color: appColors["white"]!,)
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(color:appColors["white"]!),
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(top:10),
                      padding: EdgeInsets.all(20),
                      child: clumsyTextLabel("Sorry, This is an Unkown Question type question")
                  ),

                ],
              ),
            ),
          ),

        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              GestureDetector(
                  onTap: (){

                    // setState(() {
                    //   qs.clearAnswer();
                    // });
                  },
                  child: Container(padding: const EdgeInsets.all(10.0),decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(25.0)),color: appColors["red"]!),child: Text("Clear",style: TextStyle(color: appColors["white"]!)),)),


              GestureDetector(
                  onTap: (){
                    // setState(() {
                    //   saveAnswer();

                    // });
                  },
                  child: Container(padding: const EdgeInsets.all(10.0),decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(25.0)),color:  appColors["green"]!),child: Text("Save & next",style: TextStyle(color: appColors["white"]!)),)),
              GestureDetector(
                  onTap: (){
                    // qs.saveAnswer();

                  },
                  child: const Icon(Icons.chevron_right,size: 40.0,)),
            ],
          ),
        ),
      ],
    );
  }
}
