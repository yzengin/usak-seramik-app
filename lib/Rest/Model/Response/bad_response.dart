import 'base_response.dart';

class BadResponse implements BaseResponse{
  @override
  late Map<String, dynamic> body;
  @override
  late String message;
  @override
  late int statusCode;

  BadResponse();

}