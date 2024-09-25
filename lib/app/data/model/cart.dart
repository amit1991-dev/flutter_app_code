import 'package:getx/app/data/model/event.dart';

class Cart {
  Map<String,CartItem> body={};

  Cart({required this.body});

  Cart.fromJson(Map<String, dynamic> json){
      for(var i in json.keys)
        {
          body[i] = CartItem.fromJson(json[i]);
        }
  }

  Map<String, dynamic> toJson(){
    return body;
  }
}

class CartItem{
  late CategoryTicket ticket;
  int quantity=0;

  CartItem({required this.ticket});

  Map<String, dynamic> toJson(){
    return {"quantity":quantity,"category_ticket":ticket.toJson()};
  }

  CartItem.fromJson(Map<String, dynamic> json){
    ticket = CategoryTicket.fromJson(json["category_ticket"]);
    quantity = json['quantity'];
  }
}