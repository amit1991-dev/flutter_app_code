import 'package:getx/app/data/constants/miscellaneous.dart';

class APIResponse {
  late String status;
  late bool? hasData;
  late dynamic? data;
  late String? info;

// constructor
  APIResponse({required this.status, this.hasData, this.data, this.info});

//factory methods
  APIResponse.fromFailed({required this.info}) {
    hasData = false;
    status = TextMessages.FAILED;
  }

  APIResponse.fromSuccess({this.hasData, this.data}) {
    status = TextMessages.SUCCESS;
  }
}
