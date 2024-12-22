import 'package:animalCare/http/request/base_request.dart';

class EmailCheckStatusRequest extends BaseRequest {
  @override
  HTTPMethod httpMethod() {
    return HTTPMethod.GET;
  }

  @override
  bool needLogin() {
    return false;
  }

  @override
  String path() {
    return '/api/v1/user/activate_status';
  }
}