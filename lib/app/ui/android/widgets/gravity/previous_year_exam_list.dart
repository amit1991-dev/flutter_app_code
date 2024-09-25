import 'package:async_builder/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/app/controller/gravity/student_controller.dart';
import 'package:getx/app/data/model/event.dart';
import 'package:getx/app/data/model/gravity/batch.dart';
import 'package:getx/app/routes/app_pages.dart';
import 'package:getx/app/ui/android/widgets/category_item.dart';
import '../../../../controller/authentication/authentication.dart';
import '../../../../controller/host_controller.dart';
import '../../../../data/constants/errors.dart';
import '../../../../data/constants/miscellaneous.dart';
import '../../../../data/model/api_response.dart';
// import '../../../../data/model/booking.dart';
import '../../../../data/model/gravity/exam.dart';
import '../../../../data/model/host_info.dart';
import '../miscellaneous.dart';

class PreviousYearExamListWidget extends StatefulWidget {
  PreviousYearExamListWidget({Key? key}) : super(key: key);

  @override
  State<PreviousYearExamListWidget> createState() => _PreviousYearExamListWidgetState();
}

class _PreviousYearExamListWidgetState extends State<PreviousYearExamListWidget> {
  @override
  Widget build(BuildContext context) {
    return AsyncBuilder<APIResponse>(
      future: Get.find<StudentsController>().getExams(),
      waiting: (context) {
        return Center(
          child: clumsyWaitingBar(),
        );
      },
      builder: (context,apiResponse){
        if(apiResponse!.status == TextMessages.SUCCESS)
        {
          List<Exam> exams = apiResponse.data as List<Exam>;
          return 
          
          Container(
            margin: EdgeInsets.all(0),
            padding: EdgeInsets.all(0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Row(
                    children: [
                      clumsyTextLabel("Previous Year Exams\nQuestions",fontsize: 14,color: appColors['golu-grey']),
                      Spacer(),
                      InkWell(
                          onTap: (){},
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: clumsyTextLabel("View All",fontsize: 14,color: appColors['golu-grey']),
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: clumsyTextLabel("Session: 2023-2024",fontsize: 14,color: appColors['grey']),
                ),
                SizedBox(
                  height: 50,
                ),
SizedBox(
  height: 500,
  // width: 259,
          child:   ListView.builder(
            // scrollDirection: Axis.horizontal,
            scrollDirection: Axis.vertical,

  itemCount: exams.length,
  itemBuilder: (context, index) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.SUBJECTS_EXAM_PAGE, arguments: exams[index].id);
      },
      customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      splashColor: appColors["white"],
      child:Container(
  // width: Get.width * 0.41,
  height: 100,
  margin: EdgeInsets.all(30),
  padding: EdgeInsets.all(30),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    color: appColors['white'],
    boxShadow: const [
      BoxShadow(
        color: Colors.grey,
        spreadRadius: 0,
        blurRadius: 5,
        offset: Offset(2, 2)
      )
    ]
  ),
  child: ListTile(
    contentPadding: EdgeInsets.zero, // to remove default padding of ListTile
    leading: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Image.asset('assets/images/glogoB.png', height: 20),
        Icon(
                      Icons.padding_outlined,
                      color: appColors['primary'],
                    ),
      ],
    ),
    title: Column(
      mainAxisAlignment: MainAxisAlignment.start,

      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        clumsyTextLabel(exams[index].name, color: appColors['primary'], fontsize: 14),
        // clumsyTextLabel("EXAMS/QUESTIONS", color: appColors['primary'], fontsize: 16),
      ],
    ),
    
trailing: GestureDetector(
  onTap: () {
    Get.toNamed(Routes.SUBJECTS_EXAM_PAGE, arguments: exams[index].id);
  },
  child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Icon(Icons.arrow_circle_right, color: appColors['primary']),
    ],
  ),
),
  ),
),

      //  Container(
      //   width: Get.width * 0.41,
      //   height: 100,
      //   margin: EdgeInsets.all(5),
      //   padding: EdgeInsets.all(20),
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(22),
      //     color: appColors['white'],
      //     boxShadow: const [BoxShadow(color: Colors.grey, spreadRadius: 0, blurRadius: 5, offset: Offset(2, 2))]
      //   ),
      //   child: Center(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Center(
      //           child: SizedBox(
      //             height: 20,
      //             child: Image.asset('assets/images/glogoB.png')
      //           ),
      //         ),
      //         Center(
      //           child: clumsyTextLabel(exams[index].name,
      //           color: appColors['primary']),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      
    );
  },
)
   
          //  SingleChildScrollView(
          //         // scrollDirection: Axis.horizontal,
          //         scrollDirection: Axis.vertical,

          //         child:Row(
          //           children: [
          //             ...List.generate(exams.length, (index){
          //               return  InkWell(
          //                 onTap: (){
          //                   Get.toNamed(Routes.SUBJECTS_EXAM_PAGE,arguments: exams[index].id);
          //                 },
          //                 customBorder: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          //                 splashColor: appColors["white"],
          //                 child: Container(
          //                   width: Get.width*0.41,
          //                   height: 100,
          //                   margin: EdgeInsets.all(5),
          //                   padding: EdgeInsets.all(20),
          //                   decoration: BoxDecoration(
          //                       borderRadius: BorderRadius.circular(22),
          //                       color: appColors['white'],
          //                       // border: Border.all(color: appColors['primary']!),
          //                       boxShadow: const [BoxShadow(color: Colors.grey,spreadRadius: 0,blurRadius: 5,offset: Offset(2,2))]
          //                   ),
          //                   child: Center(
          //                     child: Column(
          //                       mainAxisAlignment: MainAxisAlignment.center,
          //                       // crossAxisAlignment: CrossAxisAlignment.start,
          //                       children: [
          //                         Center(
          //                           child: SizedBox(
          //                               height:20,
          //                               child: Image.asset('assets/images/glogoB.png')
          //                               ),
          //                         ),
          //                         Center(
          //                           child: clumsyTextLabel(exams[index].name,
          //                           // fontsize: 25,
          //                           color: appColors['primary']),
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                 ),
          //               );
          //             })
          //           ],
          //         ),
          //       ),
          
            ),
              ],
            )
          );
        
        }
        else
        {
          // showSnackbar("Error", apiResponse!.info!);
          print(apiResponse!.info!);
          return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(ErrorMessages.SOMETHINGS_WRONG),
                  ClumsyFinalButton("Retry", Get.width*0.6, () {
                    setState(() {

                    });
                  }, false)
                  // Text(error.toString()),
                ],
              )
          );
        }
      },
      error: (context, error, stackTrace) {
        return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Some error Occured"),
                Text(error.toString()),
              ],
            )
        );
      },
    );
  }


}