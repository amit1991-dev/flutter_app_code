
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import '../../../data/constants/miscellaneous.dart';

import 'miscellaneous.dart';
class CityTab extends StatefulWidget {
  const CityTab({Key? key}) : super(key: key);

  @override
  State<CityTab> createState() => _CityTabState();
}

class _CityTabState extends State<CityTab> {
  String? city="-",state="-";
  SingleValueDropDownController cityController = SingleValueDropDownController();
  void printCity() async {
    // String cityState = await getUserCityState();
    // city = cityState.substring(0,cityState.indexOf(":"));
    // state = cityState.substring(cityState.indexOf(":")+1);
    // print(cityState??"Empty");
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: DropDownTextField(
        // initialValue: "name4",
        controller: cityController,
        clearOption: true,
        enableSearch: true,
        clearIconProperty: IconProperty(color: appColors["green"]!),
        searchDecoration: const InputDecoration(
            hintText: "enter your city"),
        validator: (value) {
          if (value == null) {
            return "Required field";
          } else {
            return null;
          }
        },
        dropDownItemCount: 6,

        dropDownList: const [
          DropDownValueModel(name: 'name1', value: "value1"),
          DropDownValueModel(
              name: 'name2',
              value: "value2",
              toolTipMsg:
              "DropDownButton is a widget that we can use to select one unique value from a set of values"),
          DropDownValueModel(name: 'name3', value: "value3"),
          DropDownValueModel(
              name: 'name4',
              value: "value4",
              toolTipMsg:
              "DropDownButton is a widget that we can use to select one unique value from a set of values"),
          DropDownValueModel(name: 'name5', value: "value5"),
          DropDownValueModel(name: 'name6', value: "value6"),
          DropDownValueModel(name: 'name7', value: "value7"),
          DropDownValueModel(name: 'name8', value: "value8"),
        ],
        onChanged: (val) {},
      ),
    );
  }
}
