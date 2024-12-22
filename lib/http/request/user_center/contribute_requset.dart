import 'package:animalCare/http/request/base_request.dart';

class ContributeRequest extends BaseRequest {
  @override
  HTTPMethod httpMethod() {
    return HTTPMethod.POSTFILE;
  }

  @override
  bool needLogin() {
    return true;
  }

  @override
  String path() {
    return 'api/v1/image/contribute';
  }
}