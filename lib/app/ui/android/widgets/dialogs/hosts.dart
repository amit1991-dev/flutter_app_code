import 'package:flutter/material.dart';
// import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:get/get.dart';


var TestDialog=AlertDialog(
  title: const Text('Dialog'),
  content: const Text('This is a dialog'),
  actions: [
  TextButton(
  child: const Text("Close"),
  onPressed: () => Get.back(),
  ),
  ],
);


