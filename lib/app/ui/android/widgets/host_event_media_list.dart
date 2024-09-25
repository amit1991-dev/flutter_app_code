// import 'dart:io';

// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:getx/app/controller/host_controller.dart';
// import 'package:getx/app/data/model/api_response.dart';
// import 'package:image_picker/image_picker.dart';
// // import 'package:simple_s3/simple_s3.dart';

// import '../../../data/constants/miscellaneous.dart';
// import '../../../data/model/media.dart';
// import 'miscellaneous.dart';




// class HostEventMediaListWidget extends StatefulWidget {
//   List<Media> medias;
//   String eventId;
//   HostEventMediaListWidget({required this.eventId,required this.medias,Key? key}) : super(key: key);

//   @override
//   State<HostEventMediaListWidget> createState() => _HostEventMediaListWidgetState();
// }

// class _HostEventMediaListWidgetState extends State<HostEventMediaListWidget> {
//   // final SimpleS3 _simpleS3 = SimpleS3();
//   bool isLoading = false;
//   bool uploaded = true;
//   File? selectedFile;
//   final ImagePicker _picker = ImagePicker();


//   Future<String?> _upload({image=true}) async {
//     String? result;
//     String extension = selectedFile!.path.substring(selectedFile!.path.lastIndexOf("."));
//     print(extension);
//     String filename = DateTime.now().toString().replaceAll(" ", "").replaceAll(".", "")+extension;
//     // result = await _simpleS3.uploadFile(
//     //   selectedFile!,
//     //   Credentials.s3_bucketName,
//     //   Credentials.s3_poolD,
//     //   AWSRegions.apSouth1,
//     //   debugLog: true,
//     //   s3FolderPath: image?"test/images":"test/videos",
//     //   fileName: filename,
//     //   accessControl: S3AccessControl.publicReadWrite,
//     // );
//         setState(() {
//           isLoading = true;
//         });
//        try{

//          // await Future.delayed(Duration(seconds: 2));
//          print(filename);
//          if(selectedFile != null)
//            {
//              print("yes");
//              var connectivityResult = await (Connectivity().checkConnectivity());
//              if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
//                // I am connected to a mobile network.
//                print("connected to the network");

//                result = await _simpleS3.uploadFile(
//                  selectedFile!,
//                  Credentials.s3_bucketName,
//                  Credentials.s3_poolD,
//                  AWSRegions.apSouth1,
//                  debugLog: true,
//                  s3FolderPath: image?"test/images":"test/videos",
//                  fileName: filename,
//                  accessControl: S3AccessControl.publicReadWrite,
//                ).catchError((error){
//                  showSnackbar("Info", error.toString());
//                });
//              } else {
//                // I am connected to a wifi network.
//                throw("No network connection");
//              }
//            }
//          else{
//            throw("Problem with the selected file");
//          }
//          String url = bucketBase +(image?"/test/images":"/test/videos") + "/$filename";
//          print(url);
//          print(result);
//          bool savedSuccessfully = await Get.find<HostController>().saveMedia(widget.eventId,url,image);
//          if(savedSuccessfully)
//            {
//              uploaded = true;
//              widget.medias.add(Media(url: url,mediaType: image?"image":"video"));
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


//   initiateMedia({String mediaType="image"}){
//   }

//   @override
//   void initState() {

//     // // Pick an image
//     // final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     // // Capture a photo
//     // final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
//     // // Pick a video
//     // final XFile? image = await _picker.pickVideo(source: ImageSource.gallery);
//     // // Capture a video
//     // final XFile? video = await _picker.pickVideo(source: ImageSource.camera);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     print("medias:"+widget.medias.length.toString());
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         children: [
//           ...List.generate(widget.medias.length, (index){
//             return Column(
//               children: [
//                 clumsyMediaWidget(widget.medias[index]),
//                 deleteMediaButton(widget.medias[index])
//               ],
//             );
//           }),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//                 width: 225,
//                 height: 200,
//                 decoration: BoxDecoration(
//                   border: Border.all(color:appColors["primary"]!,style: BorderStyle.solid,width: 2),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: isLoading?
//                     Center(
//                       child: CircularProgressIndicator(color: appColors["primary"]!,),
//                     )
//                     :
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [

//                     TextButton(child:Text("+ Image"),onPressed: () async {
//                       print("yes");
//                       XFile? file = await _picker.pickImage(source: ImageSource.gallery);
//                       if(file != null)
//                         {
//                           selectedFile = File(file.path);
//                           // print(selectedFile);
//                           await _upload();
//                           selectedFile = null;

//                         }
//                     },),
//                     Text("OR"),
//                     TextButton(child:Text("+ Video"),onPressed: () async {
//                       XFile? file = await _picker.pickVideo(source: ImageSource.gallery);
//                       if(file != null)
//                       {

//                         selectedFile = File(file.path);
//                         print(selectedFile);
//                         // await _upload(image: false);
//                         selectedFile = null;
//                       }
//                     },),
//                     // Text("+ Video"),
//                     // ClumsyRealButton("+ Video", Get.width, () { }, false),
//                   ],
//                 )
//             )

//           ),
//         ],
//       ),
//     );
//   }


//   Widget deleteMediaButton(Media media){
//     return InkWell(
//       onTap: () async {
//         if(media.id != null)
//           {
//             if(await Get.find<HostController>().removeMedia(widget.eventId, media.id!))
//             {
//               bool result = await SimpleS3.delete(
//                   media.url,
//                 Credentials.s3_bucketName,
//                 Credentials.s3_poolD,
//                 AWSRegions.apSouth1,
//               );
//               print("succcessfully deleted the image from the S3 bucket");
//               if(result)
//                 {
//                   showSnackbar("Successfully removed", "");
//                 }

//             }
//           }
//         setState(() {
//           print(widget.medias.length);
//           widget.medias.remove(media);
//           print("removed");
//           print(widget.medias.length);
//         });
//       },
//       child: clumsyTextLabel("Delete?",color: Colors.red),
//     );
//   }
// }
