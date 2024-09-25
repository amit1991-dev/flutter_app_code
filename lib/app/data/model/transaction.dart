class Transaction {
  // Map<String,int> body={};

  Transaction();

  Transaction.fromJson(Map<String, dynamic> json){
      // body = json as Map<String, int>;
  }

  Map<String, dynamic> toJson(){
    // return body;
    return {};
  }
}