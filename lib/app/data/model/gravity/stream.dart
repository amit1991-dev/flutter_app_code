
class GravityStream {
  String name,id;
  GravityStream(this.name,this.id);

  factory GravityStream.fromJSON(Map<String,dynamic> json)
  {
    return GravityStream(json['name'],json['_id']);
  }

  @override
  String toString()
  {
    return name;
  }
}
