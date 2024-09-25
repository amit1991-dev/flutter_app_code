import 'package:async_builder/async_builder.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:getx/app/controller/home/home_controller.dart';
import 'package:getx/app/data/model/event.dart';
import 'package:getx/app/data/model/gravity/gravity_result.dart';
import 'package:getx/app/ui/android/widgets/category_item.dart';
import '../../../controller/authentication/authentication.dart';
import '../../../controller/gravity/student_controller.dart';
import '../../../controller/host_controller.dart';
import '../../../data/constants/errors.dart';
import '../../../data/constants/miscellaneous.dart';
import '../../../data/model/api_response.dart';
import '../../../routes/app_pages.dart';
import 'miscellaneous.dart';

class HomeCarousal extends StatefulWidget {
  HomeCarousal({Key? key}) : super(key: key);
  @override
  State<HomeCarousal> createState() => _HomeCarousalState();
}



class _HomeCarousalState extends State<HomeCarousal> {
  TextEditingController categoryController = TextEditingController();
  bool categoryWait = false;
  @override
  Widget build(BuildContext context) {
    print("building carousel");
    return AsyncBuilder<APIResponse>(
        future: Get.find<StudentsController>().getGravityResults(),
        waiting: (context) {
          return Center(
            child: clumsyWaitingBar(),
          );
        },
        builder: (context,apiResponse){
          print("results");
          List<GravityResult> results = apiResponse!.data as List<GravityResult>;
          print(results);
          if(apiResponse!.status == TextMessages.SUCCESS)
          {
            List<GravityResult> results = apiResponse.data as List<GravityResult>;
            // print("results",);
            // print(results);
            if(results.isNotEmpty) {
              return CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  autoPlayAnimationDuration: Duration(seconds: 1),

                  enlargeCenterPage: true,
                  height:Get.height*0.3 ,
                ), items: [
                  ...List.generate(results.length, (index){
                    return InkWell(
                      onTap: (){
                        // Get.toNamed(Routes.EVENT,arguments: results[index].id);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: appColors["primary"]!),
                          image: DecorationImage(image: AssetImage("assets/images/result_1.jpeg"),fit: BoxFit.fill)
                          // image: DecorationImage(image: NetworkImage(results[index].url),fit: BoxFit.cover)
                        ),
                      ),
                    );
                  })
              ],
              );
            }
            else
              {
                return Text("");
              }
          }
          else
          {
            return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // headerBar("All Phases",parent: false),
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