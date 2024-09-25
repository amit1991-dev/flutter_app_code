
class Option {
  String option_type,option_value;
  Option(this.option_type,this.option_value);

  factory Option.fromJSON(Map<String,dynamic> json)
  {
    return Option(json['option_type'],json['option_value']);
  }

  @override
  String toString()
  {
    return this.option_type+":"+this.option_value+"\n";
  }
}
