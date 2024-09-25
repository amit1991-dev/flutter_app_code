import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' hide Response;
import 'package:getx/app/controller/home/home_controller.dart';
import 'package:getx/app/data/constants/miscellaneous.dart';
import 'package:getx/app/data/model/api_response.dart';
import 'package:getx/app/routes/app_pages.dart';
import 'package:http/http.dart' as http;
import 'package:getx/app/controller/authentication/authentication.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../ui/android/widgets/miscellaneous.dart';

class RazorPayments extends GetxController {

  late Razorpay _razorpay;
  late final platform;

  RazorPayments() {
    // print(platform);

      platform = const MethodChannel("razorpay_flutter");
      _razorpay = Razorpay();
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);


    print("networking initialized");
  }

  @override
  void onClose() {
    // TODO: implement onClose

    _razorpay.clear();
    super.onClose();
  }

  Future<void> attemptPayment(int amount, String paymentName) async
  {
      if(amount<10)
      {
        showSnackbar("Error","Amount not enough to proceed");
        amount =100;
      }
      String key = 'rzp_test_RrFQYRbYZudkJO';// razorpay pay key
      String secret = "Kkg9NCJZXTlksvJ6z6ofqdM8";// razoepay secret key
      String basicAuth = 'Basic ${base64Encode(utf8.encode('$key:$secret'))}';


      var orderMap =  {
        "order_type":"tickets",
        "tickets":Get.find<HomeController>().cart.value.body.values.toList(),
        "total_amount":amount,
        "user_id":Get.find<Authentication>().user!.id,
        "host_id":Get.find<HomeController>().cartEvent!.host!.id,
        "event_id":Get.find<HomeController>().cartEvent!.id
      };
      print("order body");
      print(jsonEncode(orderMap));
      String? uuid = await getOrderId(orderMap);
      if(uuid == null)
        {
          showSnackbar("Error", "Could not create an order");
          return;
        }

      Map<String, dynamic> body = {
        "amount": amount * 100,
        "currency": "INR",
        "receipt": uuid,
        "notes":{}
      };
      print("payment body");
      print(jsonEncode(body));
      var res = await http.post(
        Uri.https(
            "api.razorpay.com", "v1/orders"), //https://api.razorpay.com/v1/orders // Api provided by Razorpay Official 💙
        headers: <String, String>{
          "Content-Type": "application/json",
          'authorization': basicAuth,
        },
        body: jsonEncode(body),
      );

      if (res.statusCode == 200) {
        Map<String,dynamic> body = jsonDecode(res.body);
        print("received Order Id");
        print(body);
        await openCheckout(amount,paymentName,body['id']); // 😎🔥
      }
      print(res.body);

  }

  Future<void> openCheckout(int amount,String paymentName,String orderId) async {

    var options = {

      'key': 'rzp_test_RrFQYRbYZudkJO',
      'amount': amount*100,//because payments are in paise, min 10 is required!
      // 'order_id':orderId,
      'name': paymentName,
      'order_id':orderId,
      // 'description': 'Fine T-Shirt',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'options':{
        'checkout':{
          "method":{
            "netbanking": "1",
            "card": "1",
            "upi": "1",
            "wallet": "1"
          }
        }
      }
      // 'external': {
      //   'wallets': ['paytm']
      // }
    };




    try {
      print("trying Razorpay");
      _razorpay.open(options);
    } catch (e) {
      print(e);
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('Success order id: ${response.orderId}');
    print('Success payment id: ${response.paymentId}');
    Get.find<HomeController>().cartClear();
    Get.offNamed(Routes.PAYMENT_BOOKING_STATUS,arguments: "Payment-ID:${response.paymentId}");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Error Response: ${response.message}');
    showSnackbar("Payment Failed", response.message??response.code.toString()??"Unknown Problem");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External SDK Response: $response');
    /* Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  Future<String?> getOrderId(Map<String, Object> orderMap) async {
    APIResponse res=await Get.find<HomeController>().createOrder(orderMap);
    if(res.status==TextMessages.SUCCESS){
      return res.data as String;
    }
    else
      {
        return null;
      }
    return "";
  }
}