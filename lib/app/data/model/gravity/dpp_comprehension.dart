

class DppComprehension {
  String name,id,content;
  DppComprehension(this.name,this.id,this.content);

  factory DppComprehension.fromJSON(Map<String,dynamic> json)
  {
    print(json['name']);
    print(json['_id']);

    return DppComprehension(json['name'],json['_id'],json['content']);
  }

  @override
  String toString()
  {
    return name;
  }
}
