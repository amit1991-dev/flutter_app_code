import 'dart:convert';

import 'event.dart';
import 'media.dart';
import 'user.dart';

class Booking {
  
  late String id;
  late String bookingStatus;
  late int verified;
  List<Ticket> tickets=[];
  int personCount=0;
  late Event event;
  late User host;
  late User user;
  late Transaction transaction;

  Booking({required this.id});
  Booking.fromJson(Map<String, dynamic> json){
    print(json['transaction'].toString());
    print("Booking Transaction");
    id = json['_id'];
    bookingStatus = json['booking_status'];
    verified = json['verified'];
    // print("a");
    host = User.fromJson(json['host']);
    // print("a");
    user = User.fromJson(json['user']);
    // print("a");
    event = Event.fromJson(json['event']);
    transaction = Transaction.fromJson(json['transaction']);
    // print("b");
    print("Creating tickets in bookings");
    if(json.containsKey("tickets")) {
      for(Map<String,dynamic> tkt in json['tickets']){
        Ticket ticket= Ticket.fromJson(tkt);
        tickets.add(ticket);
        personCount += ticket.count;
      }
    }
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['name'] = name;
    // data['_id'] = id;
    // data['phases'] = jsonEncode(phases.map((e) => e.toJson()));
    // data['media'] = jsonEncode(medias.map((e) => e.toJson()));
    return data;
  }
}

class Ticket {
  late String id;
  late String phase,category,ticket;
  late String ticketType;
  late CategoryTicket categoryTicket;
  late int count;
  // late Transaction transaction;

  Ticket.fromJson(Map<String, dynamic> json){
    id = json['_id'];
    phase = json['phase'];
    category = json['category'];
    ticket = json['name'];
    ticketType = json['ticket_type']??"";
    count = json['count']??0;
  }
}

class Transaction {

  late String id;

  late int amount,amountPaid;
  late String orderId;
  late String paymentStatus;

  Transaction.fromJson(Map<String, dynamic> json){
    id = json['_id'];
    amount = json['order']['amount'];
    amountPaid = json['order']['amount_paid'];
    orderId = json['order']['receipt'];
    paymentStatus = json['order']['status'];
  }
}