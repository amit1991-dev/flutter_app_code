import 'package:getx/app/controller/authentication/authentication.dart';
import 'package:get/get.dart';
import 'package:getx/app/controller/networking/google_places.dart';
import 'package:getx/app/controller/payments/razorpay.dart';
import 'package:getx/app/ui/android/widgets/internet_checker.dart';
import '../controller/home/home_controller.dart';
import '../controller/networking/networking.dart';

class RootBindings implements Binding {
  @override
  List<Bind<dynamic>> dependencies() {
    return [
        // Eager binding (binds immediately)
      Bind.put<Authentication>(Authentication()..initialize()),
      // Lazy binding (binds when needed)
      Bind.lazyPut<Networking>(() => Networking()),

      Bind.put(InternetChecker(), permanent: true),

    
    ];
  }
    // @override

  // void dependencies() {
  //   // Get.put<Authentication>( Authentication());
  //    Get.lazyPut<Authentication>(() => Authentication()..initialize()); // Call initialize() here
  //   Get.lazyPut<Networking>(() {return Networking();});
  //   // Get.lazyPut<RazorPayments>(() {return RazorPayments();});
  //   // Get.lazyPut<HomeController>(() {return HomeController(); });
  //   // Get.lazyPut<ClumsyGooglePlaces>(() {return ClumsyGooglePlaces(); });
  // }
}
