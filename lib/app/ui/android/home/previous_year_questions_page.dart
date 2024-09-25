// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
// import 'package:getx/app/controller/authentication/authentication.dart';
// import 'package:getx/app/controller/home/home_controller.dart';
import 'package:getx/app/data/constants/miscellaneous.dart';
// import 'package:getx/app/data/constants/request_paths.dart';
import 'package:getx/app/routes/app_pages.dart';
import 'package:getx/app/ui/android/home/mydrawer.dart';
// import 'package:getx/app/ui/android/home/gravity/batch_page.dart';
// import 'package:getx/app/ui/android/home/gravity/my_batches.dart';
// import 'package:getx/app/ui/android/widgets/all_events_grid.dart';
import 'package:getx/app/ui/android/widgets/home_carousal.dart';
// import 'package:getx/app/ui/android/widgets/location_bar.dart';
import 'package:getx/app/ui/android/widgets/miscellaneous.dart';
// import 'package:getx/app/ui/android/widgets/todays_events_list.dart';

// import '../../../data/model/city_state.dart';
// import '../widgets/gravity/batches_list_widget.dart';
import '../widgets/gravity/previous_year_exam_list.dart';
// import 'booking_page.dart';

class PreviousYearQuestionsPage extends StatefulWidget {
  const PreviousYearQuestionsPage({super.key});
  @override
  State<PreviousYearQuestionsPage> createState() => _PreviousYearQuestionsPage();
}

class _PreviousYearQuestionsPage extends State<PreviousYearQuestionsPage> {
  // String? city = "-", state = "-";
  // SingleValueDropDownController cityController = SingleValueDropDownController(
  //     data: const DropDownValueModel(name: "-", value: "-"));
  // final TextEditingController? searchController = TextEditingController();
  // void detectLocation() async {
  //   print(":location");
  //   String cityState = await getUserCityState();
  //   // city = cityState.substring(0,cityState.indexOf(":"));
  //   // state = cityState.substring(cityState.indexOf(":")+1);
  //   // setState(() {
  //   //   cityController.dropDownValue = DropDownValueModel(name: city!, value: city);
  //   // });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // detectLocation();
    // await Get.put<HomeController>(HomeController());
    // Get.find<HomeController>().cityState.listen((p0) {
    //   setState(() {
    //
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Material(color: appColors["background"]!, child: getBody());
  }
  //
  // void detectLocation() async {
  //   print(":location");
  //   await getUserCityState();
  // }

//golu

  Widget getBody() {
    // var ncategories = categories.sublist(1);
    return SafeArea(
      child: Scaffold(
          // drawer: const MyDrawer(),
          extendBodyBehindAppBar: true,
          backgroundColor: appColors["background"]!,
          // appBar: AppBar(
          //   backgroundColor: Colors.transparent,
          // ),
          body: Container(
            color: appColors["background"]!,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
          
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: goluheaderBar("Previous Year Questions",parent: true)
                          
                        ),
 
              
                const  SizedBox(
                    height: 50,
                  ),
                  // Divider(color: appColors['primary']),
                   // golu previous year exams
                  
                  PreviousYearExamListWidget(),
                  // Divider(color: appColors['primary']),
                 const SizedBox(
                    height: 100,
                  ),
  
                

                ],
              ),
            ),
          )

          ),
    );
  }
}



  

