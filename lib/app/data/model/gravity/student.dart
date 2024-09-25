import 'package:flutter/foundation.dart';

class Student {
  String? name,fatherName,MotherName,phoneOffice,phoneResidence,fatherPhone,motherPhone,mathGrades,scienceGrades,schoolName,schoolAddress,category,
      profilePicture;
  late String id,email,classNumber,center, phone,stream;
  // Student(this.id,this.name,this.token,this.email,this.stream,this.classNumber,this.center,this.phone,this.profilePicture);

  Student.fromJSON(Map<String,dynamic> json)
  {
    // print(json);
    center = json["center"];
    stream = json['stream'];
    classNumber = json['class_number'];
    email = json['email'];
    id= json['_id'];
    phone=json['phone'];
    // Student(json['_id'],json['name'],json['token'],json['email'],json['stream'],json['class_number'],json['institute'],json['phone'],json['profilePicture']);
  }
}