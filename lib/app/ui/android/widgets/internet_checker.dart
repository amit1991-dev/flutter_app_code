// import 'dart:async';

// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   bool isConnectedToInternet = false;

//   StreamSubscription? _internetConnectionStreamSubscription;

//   @override
//   void initState() {
//     super.initState();
//     _internetConnectionStreamSubscription =
//         InternetConnection().onStatusChange.listen((event) {
//       switch (event) {
//         case InternetStatus.connected:
//           setState(() {
//             isConnectedToInternet = true;
//           });
//           break;
//         case InternetStatus.disconnected:
//           setState(() {
//             isConnectedToInternet = false;
//           });
//           break;
//         default:
//           setState(() {
//             isConnectedToInternet = false;
//           });
//           break;
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _internetConnectionStreamSubscription?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SizedBox(
//         width: MediaQuery.sizeOf(context).width,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Icon(
//               isConnectedToInternet ? Icons.wifi : Icons.wifi_off,
//               size: 50,
//               color: isConnectedToInternet ? Colors.green : Colors.red,
//             ),
//             Text(
//               isConnectedToInternet
//                   ? "You are connected to the internet."
//                   : "You are not connected to the internet.",
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class InternetChecker extends GetxController {
//   final Connectivity _connectivity = Connectivity();

//   @override
//   void onInit() {
//     super.onInit();
//     _connectivity.onConnectivityChanged.listen(netstatus);
//   }

//   netstatus(ConnectivityResult cr) {
//     if (cr == ConnectivityResult.none) {
//       Get.rawSnackbar(
//           title: 'No Internet Connection',
//           message: "Connect to the internet to proceed",
//           icon:const Icon(Icons.wifi_off,color: Colors.white,),
//           isDismissible:true,
          
//           duration:const Duration(days: 1),
//           shouldIconPulse:true,
//       );
//     }
//     else{
//       if(Get.isSnackbarOpen){
//         Get.closeCurrentSnackbar();
//       }
      
//     }
//   }
// }

import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InternetChecker extends GetxController {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final RxBool isConnected = true.obs; // Observable to track connectivity

  @override
  void onInit() {
    super.onInit();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      (ConnectivityResult result) {
        _updateConnectionStatus(result);
      },
    );
    _checkConnectivity(); // Initial check
  }

  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }

  Future<void> _checkConnectivity() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    _updateConnectionStatus(connectivityResult);
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    isConnected.value = result != ConnectivityResult.none;
    if (!isConnected.value) {
      _showSnackbar();
    } else {
      Get.closeCurrentSnackbar();
    }
  }

  void _showSnackbar() {
    Get.rawSnackbar(
      title: 'No Internet Connection',
      message: "Connect to the internet to proceed",
      icon: const Icon(
        Icons.wifi_off,
        color: Colors.white,
      ),
      isDismissible: true,
      duration: const Duration(days: 1), // Keep showing until dismissed
      shouldIconPulse: true,
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:getx/app/ui/android/widgets/internet_checker.dart'; // Import your InternetChecker

// class MyWidget extends StatelessWidget {
//   // const MyWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Internet Connectivity')),
//       body: Center(
//         child: Obx(() { 
//           if (Get.find<InternetChecker>().isConnected.value) {
//             return const Text('Connected', style: TextStyle(color: Colors.green));
//           } else {
//             return const Text('Disconnected', style: TextStyle(color: Colors.red));
//           }
//         }),
//       ),
//     );
//   }
// }
