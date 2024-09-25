// import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getx/app/controller/authentication/authentication.dart';
// import 'package:getx/app/controller/authentication/authentication.dart';
// import 'package:getx/app/controller/home/home_controller.dart';
import 'package:getx/app/data/constants/miscellaneous.dart';
// import 'package:getx/app/data/constants/request_paths.dart';
import 'package:getx/app/routes/app_pages.dart';
// import 'package:getx/app/ui/android/home/gravity/batch_page.dart';
// import 'package:getx/app/ui/android/home/gravity/my_batches.dart';
// import 'package:getx/app/ui/android/widgets/all_events_grid.dart';
// import 'package:getx/app/ui/android/widgets/home_carousal.dart';
// import 'package:getx/app/ui/android/widgets/location_bar.dart';
import 'package:getx/app/ui/android/widgets/miscellaneous.dart';
// import 'package:getx/app/ui/android/widgets/todays_events_list.dart';

// import '../../../data/model/city_state.dart';
// import '../widgets/gravity/batches_list_widget.dart';
// import '../widgets/gravity/previous_year_exam_list.dart';

import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'webview.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
// class MyDrawer extends StatelessWidget {
  // const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: appColors["background"]!,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: appColors["primary"]!,
            ),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,

              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/glogoB.png",
                  width: 100,
                ),
                const SizedBox(
                  height: 10,
                ),
                // clumsyTextLabel("Gravity",
                // fontsize: 16, color: appColors["white"]!),
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.video_collection_outlined,
              color: appColors["primary"]!,
            ),
            title: clumsyTextLabel("Batches",
                fontsize: 14, color: appColors["primary"]!),
            onTap: () {
              Get.toNamed(Routes.My_Batches);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              color: appColors["primary"]!,
            ),
            title: clumsyTextLabel("Profile",
                fontsize: 14, color: appColors["primary"]!),
            onTap: () {
              Get.toNamed(Routes.PROFILE);
            },
          ),
   
   
         
          

          ListTile(
            leading: Icon(
              Icons.search,
              color: appColors["primary"]!,
            ),
            title: clumsyTextLabel("About Us",
                fontsize: 14, color: appColors["primary"]!),
            onTap: () {
            // Get.to  ( _launchURL('https://students.grcls.in/about_us') as Widget Function());

              Get.to(()=>
              const WebViewScreen(url: 'https://students.grcls.in/about_us',
              text: "About Us",
              ) ,
              );
            },
          ),
          
          
          ListTile(
            leading: Icon(
              Icons.school,
              color: appColors["primary"]!,
            ),
            title: clumsyTextLabel("Courses",
                fontsize: 14, color: appColors["primary"]!),
            onTap: () {
            // Get.to  ( _launchURL('https://students.grcls.in/courses') as Widget Function());

              Get.to(()=>
              const WebViewScreen(url: 'http://students.grcls.in/courses',
              text: "Courses",
              ) ,
              );
            },
          ),
          
          ListTile(
            leading: Icon(
              Icons.contact_page,
              color: appColors["primary"]!,
            ),
            title: clumsyTextLabel("Contact Us",
                fontsize: 14, color: appColors["primary"]!),
            onTap: () {
            // Get.to  ( _launchURL('https://students.grcls.in/contact_us') as Widget Function());

              Get.to(() =>
              const WebViewScreen(url: 'https://students.grcls.in/contact_us',
              text: "Contact Us",
              ),
              );
            },
          ),
          
           ListTile(
            leading: Icon(
              Icons.inventory_sharp,
              color: appColors["primary"]!,
            ),
            title: clumsyTextLabel("Terms & Conditions",
                fontsize: 14, color: appColors["primary"]!),
            onTap: () {
            // Get.to  ( _launchURL('https://students.grcls.in/about_us') as Widget Function());

              Get.to(
              // WebViewScreen1(url: 'students.grcls.in/login'),
              
              ()=>const WebViewScreen(url:'https://students.grcls.in/profile_deletion_guidance',
              text: "Terms & Conditions",
              )  ,
              );
            },
          ),
          
          ListTile(
            leading: Icon(
              Icons.logout,
              color: appColors["primary"]!,
            ),
            title: clumsyTextLabel("Logout",
                fontsize: 14, color: appColors["primary"]!),
            onTap: () {
              Get.find<Authentication>().logout();
              Get.offAllNamed(Routes.INITIAL);
              // Get.toNamed(Routes.MyBatches);
            },
          ),
        ],
      ),
    );
  }
}



// class WebViewScreen extends StatelessWidget {
//   final String url;
//   final String text;


//   const WebViewScreen({Key? key, required this.text,required this.url}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(text),
//       ),
//       body: WebView(
//         initialUrl: url,
//         // javascriptMode:
//             JavascriptMode.unrestricted, // Allow JavaScript execution
//       ),
//     );
//   }
// }


// class WebViewScreen1 extends StatelessWidget {
//   final String url;

//   const WebViewScreen1({Key? key, required this.url}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Delete Account"),
//       ),
//       body: WebView(
//         initialUrl: url,
//         javascriptMode:
//             JavascriptMode.unrestricted, // Allow JavaScript execution
//       ),
//     );
//   }
// }

Future<void> _launchURL(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch $url');
  }
}