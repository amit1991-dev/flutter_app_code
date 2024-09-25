// import 'package:flutter/material.dart';
// import 'package:no_screenshot/no_screenshot.dart';

// final _noScreenshot = NoScreenshot.instance;

//  // Disable Screenshot and Recording in the app

// void disableScreenshot() async {
//   bool result = await _noScreenshot.screenshotOff();
//   debugPrint('Screenshot Off: $result');
// }
import 'package:flutter/material.dart';
import 'package:no_screenshot/no_screenshot.dart';

class ProtectedPage extends StatefulWidget {
  final Widget child; // Add a child property to hold the content

  const ProtectedPage({super.key, required this.child}); // Require the child

  @override
  _ProtectedPageState createState() => _ProtectedPageState();
}

class _ProtectedPageState extends State<ProtectedPage> {
  final _noScreenshot = NoScreenshot.instance;

  @override
  void initState() {
    super.initState();
    _disableScreenshot();
  }

  @override
  void dispose() {
    _enableScreenshot();
    super.dispose();
  }

  void _disableScreenshot() async {
    bool result = await _noScreenshot.screenshotOff();
    debugPrint('Screenshot Off: $result');
  }

  void _enableScreenshot() async {
    bool result = await _noScreenshot.screenshotOn();
    debugPrint('Screenshot On: $result');
  }

  @override
  Widget build(BuildContext context) {
    return widget.child; // Return the provided child widget
  }
}
