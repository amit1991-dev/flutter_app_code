import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/app/controller/networking/google_places.dart';
import '../../../data/constants/miscellaneous.dart';
import 'package:search_choices/search_choices.dart';
class WidgetGooglePlaces extends StatefulWidget {
   WidgetGooglePlaces({Key? key}){
    //  Get.put<ClumsyGooglePlaces>(ClumsyGooglePlaces());
    // super(key: key);
  }

  @override
  State<WidgetGooglePlaces> createState() => _WidgetGooglePlacesState();
}

class _WidgetGooglePlacesState extends State<WidgetGooglePlaces> {

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container();
  //   return GetX<ClumsyGooglePlaces>(
  //     initState: (state){ Get.find<ClumsyGooglePlaces>().reset(); } ,
  //       builder: (controller){
  //     return SingleChildScrollView(
  //       child: Column(
  //         children: [
  //           Container(
  //             width: Get.width*0.8,
  //             margin: EdgeInsets.all(10),
  //             // decoration: BoxDecoration(
  //             //   // color: Color(0xff36363D),
  //             //   border: Border.all(color:appColors["grey"]!),
  //             //   borderRadius: BorderRadius.circular(20),
  //             // ),
  //             child: Padding(
  //               padding: EdgeInsets.all(18.0),
  //               child: TextFormField(
  //                 controller: searchController,
  //                 autofocus: false,
  //                 cursorColor: appColors["primary"]!,
  //                 cursorRadius: Radius.circular(10),
  //                 decoration: InputDecoration(
  //                   // border: InputBorder(borderSide: ),
  //                   labelText: "Venue address",
  //                   labelStyle: TextStyle(color: appColors["white"]!),
  //                 ),
  //                 // onChanged: (text){
  //                 //   print(text);
  //                 //   if(text.isNotEmpty)
  //                 //     {
  //                 //       controller.autoCompleteSearch(text);
  //                 //     }
  //                 //
  //                 // },
  //               ),
  //             ),
  //           ),
  //           Center(
  //             child: IconButton(icon: Icon(Icons.search),color: appColors["primary"]!,onPressed: (){
  //               if(searchController.text.isNotEmpty)
  //                   {
  //                     controller.autoCompleteSearch(searchController.text);
  //                   }
  //             },),
  //           ),
  //           Divider(),
  //           if(controller.predictions.length >0)
  //               ...List.generate(controller.predictions.value.length, (index) {
  //                 return ListTile(
  //                 title: Text(controller.predictions.value[index].description!),
  //                 onTap: (){
  //                 Get.back(result: controller.predictions.value[index].id);
  //                 },
  //                 );
  //                 })
  //             else
  //               Text("No results"),
  //         ],
  //       ),
  //     );
  //     //     SearchChoices.single(
  //     //       items: controller.predictions.value,
  //     //       value: selectedValueSingleDialog,
  //     //       hint: "Select one",
  //     //       searchHint: "Select one",
  //     //       onChanged: (value) {
  //     //         setState(() {
  //     //           selectedValueSingleDialog = value;
  //     //         });
  //     //       },
  //     //       isExpanded: true,
  //     //     )
  //   });
  // }
  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  }
}
