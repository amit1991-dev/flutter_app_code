class Topic {
  String name,id,content;
  int sequenceNumber;
  Topic(this.id,this.name,this.sequenceNumber,this.content);

  factory Topic.fromJSON(Map<String,dynamic> json)
  {
    List<Topic> topics=[];
    return Topic(json['_id'],json['name'],json['sequence_number'],json['content']);
  }

  @override
  String toString()
  {
    return "$name:";
  }
}

