class GravityFile{
  String title,id,url,fileType;
  GravityFile(this.id,this.title,this.url,this.fileType);
  factory GravityFile.fromJSON(Map<String,dynamic> json)
  {
    return GravityFile(json['_id'], json['title'], json['url'] , json['fileType'] );
  }

  @override
  String toString()
  {
    return this.title+":"+this.url.toString()+"th ,\n";
  }
}