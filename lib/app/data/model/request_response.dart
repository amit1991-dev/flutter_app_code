class RequestResponse {
  int? code;
  late String message;
  late String status;
  late dynamic? data;

  RequestResponse({required this.message,required this.status,this.data,this.code});
  RequestResponse.fromJson(Map<String, dynamic> json){
        print(json);
        code = json['code'];
        status = json['status'];
        message = json['message'];
        if(json.containsKey("data"))
        {
          data = json['data'];
        }


  }
  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
  // Map<String, dynamic> toJson(){
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['name'] = this.title;
  //   data['body'] = this.body;
  //   return data;
  // }
}