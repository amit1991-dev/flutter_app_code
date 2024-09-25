

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/city_state.dart';

class TextMessages{
  static final String SUCCESS="success";
  static final String FAILED="failed";
  // static final String SOMETHINGS_WRONG="Something is just WRONG!";
}


class StorageKeys{
  static final String AUTH_KEY = "authentication";
  static final String TOKEN_KEY = "token";
  static final String USER_KEY = "user";
  static final String CART_STORAGE_KEY = "cart_storage";
  static final String CART_KEY = "cart";
}

class Credentials {
  static const String s3_poolD = "ap-south-1:9e3e34bc-b6cc-417d-b91e-05eb9a3677d5";
  static const String s3_bucketName = "clumsystorage";
}

String bucketBase = "https://clumsystorage.s3.ap-south-1.amazonaws.com";


List<CityState> cities = [
  CityState.defaultCity(),//all cities!
  CityState(city: "Bhopal", state: "Madhya Pradesh"),
];

List<String> categories = [
  "-","EDM","Bollywood","HipHop","Ladies Night","Sit and Drink","Rock","Saturday night"
];

// const List<Color> appColors = [Colors.amber,Colors.white,Colors.black,Colors.grey,Colors.red,Colors.blue,Colors.green];
const Map <String,Color> appColors = {
  // 'primary':Colors.blueGrey,
  // 'primary':Colors.green,
  'primary':Color.fromARGB(255,115, 93, 184),

  'white':Colors.white,
  // 'white':Colors.black87,

  'background':Colors.white,
  // 'background':Colors.black87,

  "grey":Colors.grey,
  "red":Colors.red,
  "purple":Colors.purple,
  "black":Colors.black,
  "blue":Colors.blue,
  "purple-dark":Color.fromARGB(255, 84, 18, 165),
  "golu":Color.fromARGB(220, 210, 245, 212),
  "golu-grey":Color.fromARGB(220, 53, 54, 53),
  "blackgrey":Color.fromARGB(233, 2, 12, 15),
  "green":Colors.green};


 openLink(String url) async{
  Uri uri = Uri.parse(url);
  if (!await launchUrl(uri,mode: LaunchMode.externalApplication)) {
    Get.snackbar("Error", "Could not open the link for the file");
  }
}
