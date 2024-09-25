import 'package:getx/app/ui/android/widgets/internet_checker.dart';

import '../controller/authentication/authentication.dart';
import '../controller/gravity/student_controller.dart';
import 'package:get/get.dart';

import '../controller/networking/networking.dart';


// class HomeBinding implements Bindings{
//   @override
//   void dependencies() {
//     Get.put<Authentication>( Authentication());
//     Get.lazyPut<Networking>(() {return Networking();});
//     Get.lazyPut<StudentsController>(() {return StudentsController(); });
//     // Get.lazyPut<RazorPayments>(() {return RazorPayments(); });
//   }

// }

class HomeBinding implements Binding {
  @override
  List<Bind<dynamic>> dependencies() {
    return [
      // Eager binding (binds immediately)
      Bind.put<Authentication>(Authentication()),

      // Lazy binding (binds when needed)
      Bind.lazyPut<Networking>(() => Networking()),
      Bind.lazyPut<StudentsController>(() => StudentsController()),
      // Bind.lazyPut<RazorPayments>(() => RazorPayments()),
      

    ];
  }
}
