import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:getx/app/bindings/home_binding.dart';
import 'package:getx/app/bindings/root_bindings.dart';
// import 'package:getx/app/controller/authentication/authentication.dart';
import 'package:getx/app/routes/app_pages.dart';
import 'package:getx/app/translations/app_translations.dart';
import 'package:getx/app/ui/android/booting/splash.dart';
import 'package:getx/app/ui/android/widgets/connectivity_status.dart';
import 'package:getx/app/ui/android/widgets/internet_checker.dart';

import 'app/data/constants/miscellaneous.dart';
// import 'app/data/model/user.dart';
// import 'app/ui/android/home/home_page.dart';
import 'app/ui/theme/app_theme.dart';

import 'package:flutter_downloader/flutter_downloader.dart';

import 'package:wakelock_plus/wakelock_plus.dart';

void main() async {
  await dotenv.load(fileName: "assets/.env");
  WidgetsFlutterBinding.ensureInitialized();
  // WidgetsFlutterBinding.ensureInitialized();

  // Plugin must be initialized before using
  await FlutterDownloader.initialize(
      debug:
          true, // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl:
          true // option: set to false to disable working with http links (default: false)

      );
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  //
  // SystemChrome.setSystemUIOverlayStyle(
  //   SystemUiOverlayStyle(
  //     statusBarColor: Colors.transparent,
  //     statusBarIconBrightness: Brightness.light,
  //   ),
  // );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: appColors['background'],
  ));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,

    // DeviceOrientation.landscapeRight,
    // DeviceOrientation.landscapeLeft
  ]);
  // InternetChecker();

  // await GetStorage.init();
  // print("Before : ${GetStorage().read("XXX")}");
  // await GetStorage().write("XXX", 1);
  // print("After : ${GetStorage().read("XXX")}");
  //
  // Authentication a = Authentication();
  //
  // await a.initialize();
  //
  // print(a.isLoggedIn.value);
  // if(!a.isLoggedIn.value)
  //   {
  //     print("yes");
  //     await a.login(User(id: "a",token: "asdasd",role: "ASDasd"));
  //   //   print(GetStorage(StorageKeys.AUTH_KEY).read(StorageKeys.TOKEN_KEY));
  //   //   print(GetStorage(StorageKeys.AUTH_KEY).read(StorageKeys.USER_KEY));
  //   }
  // else
  //   {
  //     print("no");
  //     await a.logout();
  //   }

  // Prevent Device from Sleep mode
  WakelockPlus.enable();
  
 // internet checkher
  // Get.put(InternetChecker(),permanent: true);
  const ConnectivityStatusWidget();
  



// Disable Screenshot and Recording
  // disableScreenshot();
  // Add this line
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    
    // initial:RootBindings(),
    initialRoute: Routes.INITIAL,
    theme: darkTheme,
    darkTheme: ThemeData(
      brightness: Brightness.dark,
    ),
    themeMode: ThemeMode.dark,
    defaultTransition: Transition.fade,
    getPages: AppPages.pages,
    locale: const Locale('pt', 'BR'),
    translationsKeys: AppTranslation.translations,
  ));
}
