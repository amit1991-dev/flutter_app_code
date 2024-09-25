import 'package:getx/app/data/model/transaction.dart';

class HostInfo {
  // Map<String,int> body={};

  late String account;
  late String ifsc;
  late List<String> notifications;
  late List<Transaction> transactions;


  HostInfo({required this.account, required this.ifsc, required this.notifications, required this.transactions});

  HostInfo.fromJson(Map<String, dynamic> json){
      // body = json as Map<String, int>;
    account = json['account_number']??"-";
    ifsc = json['ifsc']??"-";
    notifications = [];
    for( var notification in json['notifications'])
      {
       notifications.add(notification);
      }

    transactions = [];
    // for( var transactionMap in json['transactions'])
    // {
    //   transactions.add(Transaction.fromJson(transactionMap));
    // }

    // transactions = json['transactions'];
  }

  Map<String, dynamic> toJson(){
    return {
      'account_number':account,
      'ifsc':ifsc,
      'notifications':notifications,
      // 'transactions':transactions,
    };
  }
}