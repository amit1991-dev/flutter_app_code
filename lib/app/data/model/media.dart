class Media {
  
  String? id;
  late String url;
  late String mediaType;

  Media({ this.id,required this.url,required this.mediaType});
  Media.fromJson(Map<String, dynamic> json){
    print(json);
      id = json['_id'];
      url = json['path'];
      mediaType = json['media_type'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['path'] = url;
    data['media_type'] = mediaType;
    data['_id'] = id;
    return data;
  }
}