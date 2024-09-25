import 'package:getx/app/data/model/event.dart';

class Wallet {
  List<WalletTransaction> transactions=[];
  late int unsettledAmount;
  Wallet.fromJson(Map<String, dynamic> json){
    unsettledAmount = json['unsettled_amount'];
    int o=0;
    for(var i in json['transactions'])
      {
        print("creating transaction"+o.toString());
        transactions.add(WalletTransaction.fromJson(json[i]));
      }
  }
}

class WalletTransaction{
  String? userId,status,transactionType,detailsJson;
  late bool credit,settled,approved;
  late double amount;

  WalletTransaction.fromJson(Map<String, dynamic> json){
    userId = json['user_id'];
    status = json['status'];
    transactionType = json['transaction_type'];
    detailsJson = json['details_json'];
    amount = json['amount'];
    credit = json['credit'];
    settled = json['settled'];
    approved = json['approved'];
  }
}