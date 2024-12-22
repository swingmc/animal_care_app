import '../base_request.dart';
part 'identify_bird_request.g.dart';


class IdentifyBirdRequest extends BaseRequest {
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
    return 'api/v1/device/identify';
  }
}

@JsonSerializable()
class IdentifyBirdResult implements Jsonable {
  bool? has_identify_error;
  bool? has_bird;
  String? name;
  String? introduction;

  IdentifyBirdResult();

  factory IdentifyBirdResult.fromJson(Map<String, dynamic> json) =>
      _$IdentifyBirdResultFromJson(json);

  @override
  Jsonable fromJson(Map<String, dynamic> json) {
    IdentifyBirdResult result = IdentifyBirdResult.fromJson(json);
    return result;
  }
}