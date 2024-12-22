import 'package:animalCare/http/request/base_request.dart';

part 'upload_image_req.g.dart';

class UploadImageRequest extends BaseRequest {
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
    return 'api/v1/image/upload';
  }

  @override
  set useHttps(bool _useHttps) {
    //TODO
    super.useHttps = false;
  }
}


@JsonSerializable()
class UploadImageResult implements Jsonable{
  int? image_id;
  UploadImageResult();
  factory UploadImageResult.fromJson(Map<String, dynamic> json) => _$UploadImageResultFromJson(json);

  @override
  Jsonable fromJson(Map<String, dynamic> json) {
    return UploadImageResult.fromJson(json);
  }
}