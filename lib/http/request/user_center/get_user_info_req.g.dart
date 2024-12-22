// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_info_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUserInfoResult _$GetUserInfoResultFromJson(Map<String, dynamic> json) =>
    GetUserInfoResult()
      ..nickname = json['nickname'] as String?
      ..avatar_url = json['avatar_url'] as String?
      ..email = json['email'] as String?
      ..user_id = json['user_id'] as int?
      ..avatar_image_id = json['avatar_image_id'] as int?;

Map<String, dynamic> _$GetUserInfoResultToJson(GetUserInfoResult instance) =>
    <String, dynamic>{
      'nickname': instance.nickname,
      'avatar_url': instance.avatar_url,
      'email': instance.email,
      'user_id': instance.user_id,
      'avatar_image_id': instance.avatar_image_id,
    };
