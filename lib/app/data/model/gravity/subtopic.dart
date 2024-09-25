class SubTopic {
  String name,id,content;
  int sequenceNumber;
  SubTopic(this.id,this.name,this.sequenceNumber,this.content);

  factory SubTopic.fromJSON(Map<String,dynamic> json)
  {
    // List<SubTopic> topics=[];
    return SubTopic(json['_id'],json['name'],json['sequence_number'],json['content']);
  }

  @override
  String toString()
  {
    return "Subtopic:"+this.name;
  }
}

