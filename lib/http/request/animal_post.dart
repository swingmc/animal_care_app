import 'base_request.dart';

class SendPostRequest extends BaseRequest {
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
    return 'api/v1/post/send';
  }
}
