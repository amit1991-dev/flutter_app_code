import 'dart:convert';

import 'package:getx/app/data/model/user.dart';

import 'media.dart';

class Event {
  String? artist;
  String? bookingStatus;
  String? category;
  String? subcategory;
  String? eventTimestamp;
  String? eventDuration;
  String? eventType;
  String? description;

  String? venue;
  String? city;
  String? state;
  String? pincode;
  String? googlePlaces = "yet to be set";


  User? host;
  String? recurring;
  List<String> highlights=[];
  List<String> helpers=[];
  String? eventStatus;
  String? eventStatusExtra;
  String? currentPhaseId;

  late bool enabled,published;
  String? termsConditions;
  String? thumbnail;

  late String id;
  late String name;
  List<EventPhase> phases=[];
  // EventPhase? activePhase;
  EventPhase? currentPhase;
  List<Media> medias=[];

  Event({ required this.id, required this.name, required this.phases, required this.medias,required this.enabled,this.currentPhase,this.artist,this.termsConditions,this.eventStatusExtra,this.eventStatus,this.bookingStatus,this.category,this.description,this.city,this.eventDuration,this.eventTimestamp,this.eventType,this.pincode,this.recurring,this.state,this.subcategory,this.venue,this.thumbnail});
  Event.fromJson(Map<String, dynamic> json){
    id = json['_id'];

    name = json['name'];
    enabled = json['enabled'];
    published = json['published'];


    if(json.containsKey("phases")) {
      List phases = json['phases'];
      for(var phase in phases)
        {
          print(1);

          if(phase is Map<String,dynamic>)
            this.phases.add(EventPhase.fromJson(phase));
        }
    }
    print(3);
    if(json.containsKey("media")) {
      List medias = json['media'];
      for(var e in medias)
        {
          this.medias.add(Media.fromJson(e));
        }
    }
    if(json.containsKey("helpers")) {
      for(var t in json['helpers'])
        {
          helpers.add(t);
        }
    }
    print(3);
    if(json.containsKey("host"))
    {
      host = User.fromJson(json['host']);
    }
    print(4);
    if(json.containsKey("highlights"))
    {
      List hts = json['highlights'] as List;
      for (var element in hts) {
        highlights.add(element.toString());
      }
    }

    if(json.containsKey("active_phase"))
    {
      if (json["active_phase"] is String) {
        currentPhase = null;
        print("active Phase Id");
        print(json["active_phase"]);
        currentPhaseId= json["active_phase"];
      }
      else if (json["active_phase"] is Map<String,dynamic>)
        {
          // print('active Phase is a Map');
          currentPhase = EventPhase.fromJson(json["active_phase"]);
          currentPhaseId = currentPhase!.id;
        }
    }
    // print(2);
    artist = json['artist']??"-";
    bookingStatus = json['booking_status']??"-";
    venue = json['venue']??"-";
    city = json['city']??"-";
    state = json['state']??"-";
    pincode = json['pincode']??"-";
    category = json['category']??"-";
    subcategory = json['subcategory']??"-";
    eventTimestamp = json['event_timestamp']??"-";
    eventDuration = json['event_duration']??"-";
    eventType = json['event_type']??"-";
    description = json['description']??"-";
    eventStatus = json['event_status']??"-";
    eventStatusExtra = json['event_status_extra']??"-";
    thumbnail = json['thumbnail']??"https://clumsyapp.com/images/c_logo.png";
    termsConditions = json['terms_conditions']??"-";
    print(4);
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['_id'] = id;
    data['phases'] = jsonEncode(phases.map((e) => e.toJson()));
    data['media'] = jsonEncode(medias.map((e) => e.toJson()));
    return data;
  }
}

class EventPhase {
  late String id;
  late String name;
  late List<PhaseCategory> categories;

  EventPhase({ required this.id, required this.name, required this.categories});
  EventPhase.fromJson(Map<String, dynamic> json){
    // print("Creating Phase:"+json['name']);
    id = json['_id'];
    name = json['name'];
    categories =[];
    if(json.containsKey("categories"))
    {
      List categories = json['categories'];
      for(var c in categories)
        {
          // print("Creating a category");
          // print(c);
          this.categories.add(PhaseCategory.fromJson(c));
        }
      // categories.map((e) => this.categories.add(PhaseCategory.fromJson(e)));
    }
    else
      {
        categories =[];
      }
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['_id'] = id;

    data['categories'] = jsonEncode(categories.map((e) => e.toJson()));
    return data;
  }
}

class PhaseCategory {
  late String id;
  late String name;
  late List<CategoryTicket> tickets;

  // PhaseCategories({ id, title, body});
  PhaseCategory.fromJson(Map<String, dynamic> json){
    // print("in ticket constructor");
    id = json['_id'];
    name = json['name'];
    tickets = [];
    if(json.containsKey("tickets"))
      {
        List tickets = json['tickets'];

        for(var t in tickets)
          {
            this.tickets.add(CategoryTicket.fromJson(t));
          }
        // tickets.map((e) => this.tickets.add(CategoryTicket.fromJson(e)));
      }
    // print("out ticket constructor");
    }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['_id'] = id;
    data['tickets'] = jsonEncode(tickets.map((e) => e.toJson()));
    return data;
  }
}

class CategoryTicket {
  late String id;
  late String name;
  late int price;
  late int totalAvailable;
  late int supply;
  // CategoryTickets({ id, title, body});
  CategoryTicket.fromJson(Map<String, dynamic> json){
    id = json['_id'];
    name = json['name'];
    price = json['price'];
    supply = json['supply']??-1;
    totalAvailable = json['total_available']??0;
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['_id'] = id;
    data['price'] = price;
    data['supply'] = supply;
    data['total_available'] = totalAvailable;
    return data;
  }
}