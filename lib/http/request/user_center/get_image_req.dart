import 'package:animalCare/http/request/base_request.dart';


class GetImageRequest extends BaseRequest {
  final int imageID;

  GetImageRequest(this.imageID);

  @override
  HTTPMethod httpMethod() {
    return HTTPMethod.GETFILE;
  }

  @override
  bool needLogin() {
    return true;
  }

  @override
  String path() {
    return 'api/v1/image/${imageID}';
  }
}
