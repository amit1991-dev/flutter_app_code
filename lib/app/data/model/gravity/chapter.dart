
import 'gravity_file.dart';
import 'topic.dart';


class Chapter {
  String name,id,subject,content;
  int classNumber=0,sequenceNumber=0;
  List<GravityFile> gFiles;
  // List<Topic> topics;
  Chapter(this.id,this.name,this.subject,this.classNumber,this.sequenceNumber,this.content,this.gFiles);

  factory Chapter.fromJSON(Map<String,dynamic> json)
  {

    // List<Topic> topics=List.generate(json['topics'].length, (index) {
    //   return Topic.fromJSON(json['topics'][index]);
    // });

    List<GravityFile> files=List.generate(json['files'].length, (index) {
      return GravityFile.fromJSON(json['files'][index]);
    });

    return Chapter(json['_id'],json['name'],json['subject'],json['class_number']??0,json['sequence_number']??0,json['content'],files);

  }

  @override
  String toString()
  {
    return "$name:${classNumber}th ,\n";
  }
}

