// import 'dart:convert';

// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:get/get.dart' hide Response;
// import 'package:getx/app/controller/authentication/authentication.dart';
// import '../../data/model/request_response.dart';
// import 'package:dio/dio.dart';

// class Networking extends GetxController {
// // all the apis reside here
// late Authentication auth;
// late Dio dio;

// var options = BaseOptions(
//   baseUrl: 'https://apia.grcls.in/api',
//   // baseUrl: 'https://192.168.29.176:5000/api',
//   connectTimeout: 50000,
//   receiveTimeout: 600000,
// );

//   Networking(){
//     dio = new Dio(options);
//     auth = Get.find<Authentication>();
//     print("networking initialized");
//   }

//   void healthCheck(){
//     print("Logged In Status: "+auth.isLoggedIn.toString());
//   }

//   Future<RequestResponse> post(String path,{Map<String,dynamic>? headers,Map<String,dynamic>? query, dynamic data}) async
//   {
//     print(data);
//     // print(path);
//     ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();
//     if (connectivityResult == ConnectivityResult.none) {
//       return RequestResponse(code: -10, message: "Please Check Internet Connectivity", status: "failed");
//     }
//     try{
//       Response<String> response = await dio.post(path,data:data,queryParameters: query,options:Options(headers: headers));
//       if(response.statusCode ==200)
//         {
//             return RequestResponse.fromJson(json.decode(response.data!));
//         }
//       else
//         {
//           return RequestResponse(code: -10, message: response.statusCode.toString(), status: "failed");
//         }
//     }
//     on DioError  catch (ex) {
//       if(ex.type == DioErrorType.connectTimeout){
//         throw Exception("Connection  Timeout Exception");
//       }
//       throw Exception(ex.message);
//     }
//     catch(err)
//     {
//       print("Networking post method");
//       return RequestResponse(code: -20, message: err.toString(), status: "failed");
//     }
//   }

// Future<RequestResponse> get(String path,{Map<String,dynamic>? headers,Map<String,dynamic>? query}) async
// {
//   ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();
//   if (connectivityResult == ConnectivityResult.none) {
//     return RequestResponse(code: -10, message: "Please Check Internet Connectivity", status: "failed");
//   }
//   try{
//     Response<String> response = await dio.get(path,queryParameters: query,options:Options(headers: headers));
//     print(path);
//     print(response.data);
//     if(response.statusCode ==200)
//     {
//       return RequestResponse.fromJson(json.decode(response.data!));
//     }
//     else
//     {
//       return RequestResponse(code: -10, message: response.statusCode.toString(), status: "failed");
//     }
//   }
//   on DioError  catch (ex) {
//     if(ex.type == DioErrorType.connectTimeout){
//       throw Exception("Connection  Timeout Exception");
//     }
//     throw Exception(ex.message);
//   }
//   catch(err)
//   {
//     return RequestResponse(code: -20, message: err.toString(), status: "failed");
//   }
// }



// }


// import 'dart:convert';

// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:get/get.dart' hide Response;
// import 'package:getx/app/controller/authentication/authentication.dart';
// import '../../data/model/request_response.dart';
// import 'package:dio/dio.dart';




// class Networking extends GetxController {
  
//   // All the APIs reside here
//   late Authentication auth;
//   late Dio dio;

//   var options = BaseOptions(
//     // baseUrl: 'https://api.grcls.in/api',
//     baseUrl: 'https://apia.grcls.in/api',

//     connectTimeout: Duration(milliseconds: 50000),
//     receiveTimeout: Duration(milliseconds: 600000),
//   );

//   Networking() {
//     dio = Dio(options);
//     auth = Get.find<Authentication>();
//     print("Networking initialized");
//   }

//   void healthCheck() {
//     print("Logged In Status: " + auth.isLoggedIn.toString());
//   }

//   Future<RequestResponse> post(String path, {Map<String, dynamic>? headers, Map<String, dynamic>? query, dynamic data}) async {
//     print(data);
//     ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();
//     if (connectivityResult == ConnectivityResult.none) {
//       return RequestResponse(code: -10, message: "Please check internet connectivity", status: "failed");
//     }
//     try {
//       Response<String> response = await dio.post(path, data: data, queryParameters: query, options: Options(headers: headers));
//       if (response.statusCode == 200) {
//         return RequestResponse.fromJson(json.decode(response.data!));
//       } else {
//         return RequestResponse(code: -10, message: response.statusCode.toString(), status: "failed");
//       }
//     } on DioException catch (ex) {
//       return _handleDioError(ex);
//     } catch (err) {
//       print("Networking post method");
//       return RequestResponse(code: -20, message: err.toString(), status: "failed");
//     }
//   }

//   Future<RequestResponse> get(String path, {Map<String, dynamic>? headers, Map<String, dynamic>? query}) async {
//     ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();
//     if (connectivityResult == ConnectivityResult.none) {
//       return RequestResponse(code: -10, message: "Please check internet connectivity", status: "failed");
//     }
//     try {
//       Response<String> response = await dio.get(path, queryParameters: query, options: Options(headers: headers));
//       print(path);
//       print(response.data);
//       if (response.statusCode == 200) {
//         return RequestResponse.fromJson(json.decode(response.data!));
//       } else {
//         return RequestResponse(code: -10, message: response.statusCode.toString(), status: "failed");
//       }
//     } on DioException catch (ex) {
//       return _handleDioError(ex);
//     } catch (err) {
//       return RequestResponse(code: -20, message: err.toString(), status: "failed");
//     }
//   }

//   RequestResponse _handleDioError(DioException ex) {
//     String message;
//     switch (ex.type) {
//       case DioExceptionType.connectionTimeout:
//         message = "Connection Timeout Exception";
//         break;
//       case DioExceptionType.sendTimeout:
//         message = "Send Timeout Exception";
//         break;
//       case DioExceptionType.receiveTimeout:
//         message = "Receive Timeout Exception";
//         break;
//       case DioExceptionType.badResponse:
//         if (ex.response != null) {
//           message = "Received invalid status code: ${ex.response?.statusCode}";
//         } else {
//           message = "Received invalid status code with no response";
//         }
//         break;
//       case DioExceptionType.cancel:
//         message = "Request to API server was cancelled";
//         break;
//       case DioExceptionType.badCertificate:
//         message = "Bad certificate";
//         break;
//       case DioExceptionType.connectionError:
//         message = "Connection to API server failed due to internet connection";
//         break;
//       default:
//         message = "Unexpected error occurred";
//         break;
//     }
//     return RequestResponse(code: -20, message: message, status: "failed");
//   }
// }

import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart' hide Response;
import 'package:getx/app/controller/authentication/authentication.dart';
import '../../data/model/request_response.dart';
// import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';

// class Networking extends GetxController {
//   // All the APIs reside here
//   late Authentication auth;
//   late Dio dio;

//   var options = BaseOptions(
//     // baseUrl: 'https://api.grcls.in/api',
//     baseUrl: 'https://apia.grcls.in/api',
  
    
//     connectTimeout: const Duration(seconds: 50),
//     receiveTimeout: const Duration(seconds: 600),
//   );


  // Networking() {
  //   dio = Dio(options);
  //   auth = Get.find<Authentication>();
  //   print("Networking initialized");
  // }


class Networking extends GetxController {
  // All the APIs reside here
  late Authentication auth;
  late Dio dio;

  var options = BaseOptions(
    baseUrl: 'https://api.grcls.in/api',
    // baseUrl: 'https://apiaa.grcls.in/api',
    connectTimeout: const Duration(seconds: 50),
    receiveTimeout: const Duration(seconds: 600),
  );

   Networking() {
    dio = Dio(options);
    auth = Get.find<Authentication>();
    print("Networking initialized");
  }

  // Networking() {
  //   // Create an HTTP/2 client.
  //   var http2Client = Http2Adapter(
  //     ConnectionManager(
  //       idleTimeout: const Duration(seconds: 10), // Adjust as needed
  //     ),
  //   );

  //   // Create Dio with the HTTP/2 adapter.
  //   dio = Dio(options)
  //     ..httpClientAdapter = http2Client;

  //   auth = Get.find<Authentication>();
  //   print("Networking initialized");
  // }


  void healthCheck() {
    print("Logged In Status: " + auth.isLoggedIn.toString());
  }

  Future<RequestResponse> post(String path, {Map<String, dynamic>? headers, Map<String, dynamic>? query, dynamic data}) async {
    print(data);
    ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return RequestResponse(code: -10, message: "Please check internet connectivity", status: "failed");
    }
    try {
      Response<String> response = await dio.post(path, data: data, queryParameters: query, options: Options(headers: headers));
      if (response.statusCode == 200) {
        return RequestResponse.fromJson(json.decode(response.data!));
      } else {
        return RequestResponse(code: -10, message: response.statusCode.toString(), status: "failed");
      }
    } on DioException catch (ex) {
      return _handleDioError(ex);
    } catch (err) {
      print("Networking post method");
      return RequestResponse(code: -20, message: err.toString(), status: "failed");
    }
  }

  Future<RequestResponse> get(String path, {Map<String, dynamic>? headers, Map<String, dynamic>? query}) async {
    ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return RequestResponse(code: -10, message: "Please check internet connectivity", status: "failed");
    }
    try {
      Response<String> response = await dio.get(path, queryParameters: query, options: Options(headers: headers));
      print(path);
      print(response.data);
      if (response.statusCode == 200) {
        return RequestResponse.fromJson(json.decode(response.data!));
      } else {
        return RequestResponse(code: -10, message: response.statusCode.toString(), status: "failed");
      }
    } on DioException catch (ex) {
      return _handleDioError(ex);
    } catch (err) {
      return RequestResponse(code: -20, message: err.toString(), status: "failed");
    }
  }

  RequestResponse _handleDioError(DioException ex) {
    String message;
    switch (ex.type) {
      case DioExceptionType.connectionTimeout:
        message = "Connection Timeout Exception";
        break;
      case DioExceptionType.sendTimeout:
        message = "Send Timeout Exception";
        break;
      case DioExceptionType.receiveTimeout:
        message = "Receive Timeout Exception";
        break;
      case DioExceptionType.badResponse:
        if (ex.response != null) {
          message = "Received invalid status code: ${ex.response?.statusCode}";
        } else {
          message = "Received invalid status code with no response";
        }
        break;
      case DioExceptionType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioExceptionType.badCertificate:
        message = "Bad certificate";
        break;
      case DioExceptionType.connectionError:
        message = "Connection to API server failed due to internet connection";
        break;
      default:
        message = "Unexpected error occurred";
        break;
    }
    return RequestResponse(code: -20, message: message, status: "failed");
  }
}
