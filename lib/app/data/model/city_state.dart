class CityState{
  late String city;
  late String state;

  CityState({required this.city,required this.state});


  bool equals(CityState cs)
  {
    return cs.city==city && cs.state==state;
  }



  factory CityState.defaultCity(){
    return CityState(city: "Any City", state: "Any State");
  }

}