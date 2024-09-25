import 'dart:convert';

class User {
  
  late String id;
  String? name,email;
  late String role;
  late String gender;
  late String token;
  late String phone;
  late bool isHost;

  User({ required this.id, required this.token, required this.role});
  User.fromJson(Map<String, dynamic> json){
    print("Converting user");
    print(jsonEncode(json));
    // print(5);
      id = json['_id'];
      // print(5);
      name = json['name'];
      // print(5);
      email = json['email'];
      // print(5);
      token = json['token'];
      // print(5);
      phone = json['phone'];

      isHost = json['enabled_as_host']??false;
      role = json['role']??"-";
////////// student information structure ///////////////
    gender = json['gender']??"male";



  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = {};
    data['email'] = email;
    data['enabled_as_host'] = isHost;
    data['token'] = token;
    data['role'] = role;
    data['phone'] = phone;
    data['gender'] = gender;
    data['_id'] = id;
    data['name'] = name;
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    // return "user:${id},${role},${phone}, ${token}";
    return "user:${id},${role}, ${token}";
  }
}