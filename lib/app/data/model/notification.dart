class Notification {
  // Map<String,int> body={};
  late String id;
  late String body;

  Notification({required this.body});

  Notification.fromJson(Map<String, dynamic> json){
      // body = json as Map<String, int>;
    id = json['_id'];
    body = json['body']??"-";
  }
}