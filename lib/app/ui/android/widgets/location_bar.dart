import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/app/controller/home/home_controller.dart';
import 'package:getx/app/data/model/city_state.dart';
import 'package:getx/app/ui/android/widgets/miscellaneous.dart';

import '../../../data/constants/miscellaneous.dart';


class LocationBar extends StatefulWidget {
  const LocationBar({Key? key}) : super(key: key);

  @override
  State<LocationBar> createState() => _LocationBarState();
}

class _LocationBarState extends State<LocationBar> {

  void detectLocation() async {
    print(":location");
    // await getUserCityState();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    detectLocation();

  }


  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        //icon,
        // Flexible(
        //   flex:1,
        //   child: InkWell(
        //     onTap: (){
        //       print("Location");
        //       detectLocation();
        //       // Get.toNamed(Routes.SEARCH);
        //     },
        //     child: const Padding(
        //       padding: EdgeInsets.all(18.0),
        //       child: Icon(
        //         Icons.location_on,
        //         color: appColors["primary"]!,
        //         size: 35,
        //       ),
        //     ),
        //   ),
        // ),
        // Flexible(
        // flex: 2,
        //   child: Column(
        //     children: [
        //       clumsyTextLabel(Get.find<HomeController>().cityState.value.city,fontsize: 18),
        //       clumsyTextLabel(Get.find<HomeController>().cityState.value.state,fontsize: 12),
        //     ],
        //   ),
        // ),
        Flexible(
          // flex: 2,
          child:DropdownButtonFormField2(
            value: "${Get.find<HomeController>().cityState.value.city}:${Get.find<HomeController>().cityState.value.state}",
              decoration: InputDecoration(
                //Add isDense true and zero Padding.
                //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                // isDense: true,
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                //Add more decoration as you want here
                //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
              ),
            isExpanded: true,
            onChanged: (value) {
              //Do something when changing the item if you want.
              print("Changed${value!}");
              Get.find<HomeController>().cityState.value = CityState(city: value!.split(":")[0], state: value!.split(":")[1]);
            },
            // focusColor: appColors["primary"]!,
            // buttonHighlightColor: appColors["primary"]!,
            // selectedItemHighlightColor: appColors["primary"]!,
            onSaved: (value) {
              print(value);
              // selectedValue = value.toString();
            },
            hint: const Text(
              'Select Your City',
              style: TextStyle(fontSize: 14),
            ),
            items: cities.map((e){
              print(e.city);
              return DropdownMenuItem(

                  value:"${e.city}:${e.state}",
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  clumsyTextLabel(e.city,fontsize: 12,color: appColors["primary"]!),
                  // clumsyTextLabel(e.state,fontsize: 10),
                ],
              ));
            }).toList(),
          ),

        )
      ],
    ));
  }
}
