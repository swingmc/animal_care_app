import 'package:animalCare/widget/world/world_message_card.dart';

import 'base_request.dart';
part 'animal.g.dart';

class GetPostRequest extends BaseRequest {
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
    return 'api/v1/post/list';
  }
}

@JsonSerializable()
class Media {
  String? CoverPath;
  String? Title;
  String? Description;

  Media();

  @override
  factory Media.fromJson(Map<String, dynamic> json) =>
      _$MediaFromJson(json);
}

@JsonSerializable()
class GetPostResult implements Jsonable {
  List<Media>? media_list;

  GetPostResult();

  factory GetPostResult.fromJson(Map<String, dynamic> json) =>
      _$GetPostResultFromJson(json);

  @override
  Jsonable fromJson(Map<String, dynamic> json) {
    GetPostResult result = GetPostResult.fromJson(json);
    return result;
  }
}