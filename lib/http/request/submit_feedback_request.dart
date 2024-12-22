import 'package:animalCare/http/request/base_request.dart';

class SubmitFeedbackRequest extends BaseRequest {
  @override
  HTTPMethod httpMethod() {
    return HTTPMethod.POST;
  }

  @override
  bool needLogin() {
    return true;
  }

  @override
  String path() {
    return 'api/v1/feedback/submit';
  }
}