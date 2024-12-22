import '../base_request.dart';
part 'base_info_request.g.dart';

class AppBaseInfoRequest extends BaseRequest {
  @override
  HTTPMethod httpMethod() {
    return HTTPMethod.GET;
  }

  @override
  bool needLogin() {
    return true;
  }

  @override
  String path() {
    return 'api/v1/base_info';
  }
}

@JsonSerializable()
class AppBaseInfoResult implements Jsonable {
  String? recommend_app_version;
  String? update_copy;

  AppBaseInfoResult();

  factory AppBaseInfoResult.fromJson(Map<String, dynamic> json) =>
      _$AppBaseInfoResultFromJson(json);

  @override
  Jsonable fromJson(Map<String, dynamic> json) {
    AppBaseInfoResult result = AppBaseInfoResult.fromJson(json);
    return result;
  }
}