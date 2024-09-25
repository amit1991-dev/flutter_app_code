
class DppOption {
  String option_type,option_value;
  DppOption(this.option_type,this.option_value);

  factory DppOption.fromJSON(Map<String,dynamic> json)
  {
    return DppOption(json['option_type'],json['option_value']);
  }

  @override
  String toString()
  {
    return this.option_type+":"+this.option_value+"\n";
  }
}
