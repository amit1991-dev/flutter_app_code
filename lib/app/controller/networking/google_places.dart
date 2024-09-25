// import 'package:flutter/foundation.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:get/get.dart' hide Response;
// import 'package:google_place/google_place.dart';

// class ClumsyGooglePlaces extends GetxController {
//   late GooglePlace googlePlace;
//   RxBool waiting = false.obs;
//   final RxList<AutocompletePrediction> predictions = (<AutocompletePrediction>[]).obs;
//   final String _api_key=dotenv.get('GOOGLE_PLACES_API_KEY', fallback: 'Default value');

//   ClumsyGooglePlaces() {
//     googlePlace = GooglePlace(_api_key);
//   }

//   void reset(){
//     predictions.value = [];
//   }

//   void autoCompleteSearch(String value) async {
//     if(value.isEmpty)
//       {
//         waiting.value = false;
//         predictions.value =[];
//         return;
//       }
//     waiting.value = true;
//     var result = await googlePlace.autocomplete.get(value);
//     if (result != null && result.predictions != null)
//     {
//       if (kDebugMode) {
//         print("successfully Grabbed Predictions");
//       }

//       predictions.value = result.predictions!;
//       print(predictions.value);
//     }
//     waiting.value =false;
//   }
// }