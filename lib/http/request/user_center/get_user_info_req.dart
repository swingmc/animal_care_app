import 'package:animalCare/http/request/base_request.dart';

part 'get_user_info_req.g.dart';

class GetUserInfoRequest extends BaseRequest {
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
    return 'api/v1/user/info';
  }
}


@JsonSerializable()
class GetUserInfoResult implements Jsonable{
  String? nickname;
  String? avatar_url;
  String? email;
  int? user_id;
  int? avatar_image_id;
  GetUserInfoResult();
  factory GetUserInfoResult.fromJson(Map<String, dynamic> json) => _$GetUserInfoResultFromJson(json);

  @override
  Jsonable fromJson(Map<String, dynamic> json) {
    //return GetUserInfoResult();
    return GetUserInfoResult.fromJson(json);
  }
}