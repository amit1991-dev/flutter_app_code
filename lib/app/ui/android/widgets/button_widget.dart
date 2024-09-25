import 'package:flutter/material.dart';
import '../../../data/constants/miscellaneous.dart';
class RaisedButtonCustomWidget extends StatelessWidget {
  late final IconData icon;
  late final String text;
  late final Function onPressed;
  Color borderColor = appColors["white"]!;
  RaisedButtonCustomWidget({required this.icon, required this.text, required this.onPressed });

  @override
  Widget build(BuildContext context) {

    return ElevatedButton(
        // color: borderColor,
        onPressed: onPressed(),
        child: Icon(this.icon, color: appColors["white"]!,),);
  }
}
