// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:getx/app/data/constants/miscellaneous.dart';
// import 'package:getx/app/ui/android/widgets/miscellaneous.dart';

// class DND extends StatelessWidget {
//   static const platform = MethodChannel('org.gravityclasses.test_series/Gravity');

//   const DND({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: appColors["background"]!,
//       extendBodyBehindAppBar: true,
      
//       // appBar: AppBar(
//       // backgroundColor: appColors["background"]!,

//       //   // title: const Text('Do Not Disturb Mode'),
//       // ),
//       // body: Center(
//         body:  SafeArea(
//           child:
//         Column(
          
//           children: [
//            headerBar("Do Not Disturb \nMode",parent:true),
// const SizedBox(height: 300),
//             ElevatedButton(
//                  style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => appColors["purple-dark"]!),
//                 ),
//               onPressed: _enableDoNotDisturb,
//               child: const Text('Enable DND',
//               style: TextStyle(color: Colors.white,
//               fontSize: 14,
//               fontWeight: FontWeight.bold,),
//               ),
//               // style: TextStyle(color: Color.fromARGB(220, 210, 245, 212)),),

//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//                  style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => appColors["red"]!),
//                 ),
//               onPressed: _disableDoNotDisturb,
//               child: const Text('Disable DND',
//               style: TextStyle(color: Colors.white,
//               fontSize: 14,
//               fontWeight: FontWeight.bold,),
//               ),
//               // style: TextStyle(color: Color.fromARGB(220, 210, 245, 212)),),
//             ),
//           ],
//         ),
//       // ),
//       ),
//     );
//   }

//   Future<void> _enableDoNotDisturb() async {
//     try {
//       await platform.invokeMethod('enableDND');
//     } on PlatformException catch (e) {
//       print("Failed to enable DND: '${e.message}'.");
//     }
//   }

//   Future<void> _disableDoNotDisturb() async {
//     try {
//       await platform.invokeMethod('disableDND');
//     } on PlatformException catch (e) {
//       print("Failed to disable DND: '${e.message}'.");
//     }
//   }
// }
