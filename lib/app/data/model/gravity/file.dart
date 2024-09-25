class GravityFile {
  String name,id,url;


  GravityFile(this.id,this.name,this.url);

  factory GravityFile.fromJSON(Map<String,dynamic> json)
  {
    return GravityFile(json['_id'],json['name'],json['url']);
  }

  @override
  String toString()
  {
    return this.name+":"+this.url.toString()+"th ,\n";
  }
}

