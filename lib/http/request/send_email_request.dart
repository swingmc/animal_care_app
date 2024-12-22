import 'package:animalCare/http/request/base_request.dart';

class SendEmailRequest extends BaseRequest {
  @override
  HTTPMethod httpMethod() {
    return HTTPMethod.POST;
  }

  @override
  bool needLogin() {
    return false;
  }

  @override
  String path() {
    return '/api/v1/user/send_activate_email';
  }
}