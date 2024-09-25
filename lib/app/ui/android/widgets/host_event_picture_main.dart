// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:getx/app/controller/host_controller.dart';
// import 'package:image_picker/image_picker.dart';
// // import 'package:simple_s3/simple_s3.dart';

// import '../../../data/constants/miscellaneous.dart';
// import '../../../data/model/event.dart';
// import '../../../data/model/media.dart';
// import '../../../routes/app_pages.dart';
// import 'miscellaneous.dart';


// class HostEventPictureMain extends StatefulWidget {
//   Event event;
//   HostEventPictureMain({required this.event,Key? key}) : super(key: key);

//   @override
//   State<HostEventPictureMain> createState() => _HostEventPictureMainState();
// }

// class _HostEventPictureMainState extends State<HostEventPictureMain> {
//   final SimpleS3 _simpleS3 = SimpleS3();
//   bool isLoading = false;
//   bool uploaded = true;
//   File? selectedFile;
//   final ImagePicker _picker = ImagePicker();


//   Future<String?> _upload() async {
//     String? result;
//     String extension = selectedFile!.path.substring(selectedFile!.path.lastIndexOf("."));
//     print(extension);
//     String filename = DateTime.now().toString().replaceAll(" ", "").replaceAll(".", "")+extension;
//         setState(() {
//           isLoading = true;
//         });
//        try{
//          print(filename);
//          if(selectedFile != null)
//            {
//              print("yes");
//              result = await _simpleS3.uploadFile(
//                selectedFile!,
//                Credentials.s3_bucketName,
//                Credentials.s3_poolD,
//                AWSRegions.apSouth1,
//                debugLog: true,
//                s3FolderPath: "test/images",
//                fileName: filename,
//                accessControl: S3AccessControl.publicReadWrite,
//              );
//            }
//          else{
//            throw("Problem with the selected file");
//          }
//          String url = bucketBase +("/test/images") + "/$filename";
//          print(url);
//          print(result);
//          bool savedSuccessfully = await Get.find<HostController>().saveDP(widget.event.id,url);
//          if(savedSuccessfully)
//            {
//              uploaded = true;
//              // widget.medias.add(Media(url: url,mediaType: image?"image":"video"));
//              widget.event.thumbnail = url;
//            }
//          else
//            {
//              uploaded = false;
//            }
//        }
//        catch(e){
//          print(e);
//          showSnackbar("Error", e.toString());
//          uploaded = false;
//        }
//         setState(() {
//           isLoading = false;
//         });
//   }

//   Future<String?> _remove_picture() async {

//     try{
//       String url = "https://clumsyapp.com/images/c_logo.png";
//       bool savedSuccessfully = await Get.find<HostController>().saveDP(widget.event.id,url);
//       if(savedSuccessfully)
//       {
//         uploaded = true;
//         widget.event.thumbnail = url;
//         // showSnackbar("Status","Successfully removed image");
//         setState(() {

//         });
//         // widget.medias.add(Media(url: url,mediaType: image?"image":"video"));
//       }
//       else
//       {
//         uploaded = false;
//       }
//       showSnackbar("Status","Successfully removed image");
//     }
//     catch(e){
//       print(e);
//       showSnackbar("Error", e.toString());
//       uploaded = false;
//     }
//     // setState(() {
//     //   isLoading = false;
//     // });
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var image;
//     if( widget.event.thumbnail == null )
//       {
//         image = AssetImage("assets/images/pager.jpg");
//       }
//     else
//       {
//         image = NetworkImage(widget.event.thumbnail!);
//       }
//     return Stack(
//         children: [
//           InkWell(
//             onTap: (){
//               if(widget.event.thumbnail != null)
//                 {
//                   Get.toNamed(Routes.IMAGE_VIEWER,arguments: widget.event.thumbnail);
//                 }
//             },
//             child: Container(
//               height: 550,
//               width: Get.width,
//               decoration:  BoxDecoration(
//                   color: appColors["background"]!,
//                   image: DecorationImage(
//                     // image: NetworkImage("https://picsum.photos/100/550"),
//                       image: image,
//                       fit: BoxFit.contain)),
//               child: const Padding(
//                 padding: EdgeInsets.all(8.0),
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 0,
//               width: Get.width,
//               child:Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ClumsyButton("Upload", Get.width*0.3, () async {
//                     print("yess");
//                     XFile? file = await _picker.pickImage(source: ImageSource.gallery);
//                     if(file != null)
//                     {
//                       selectedFile = File(file.path);
//                       // print(selectedFile);
//                       await _upload();
//                       selectedFile = null;

//                     }
//                   }, false),
//                   ClumsyButton("Remove", Get.width*0.3, () async {
//                     print("o");
//                     await _remove_picture();
//                   }, false)
//                 ],
//               )
//           )
//         ]
//     );
//   }
// }
