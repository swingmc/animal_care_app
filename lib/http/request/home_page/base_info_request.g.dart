// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_info_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppBaseInfoResult _$AppBaseInfoResultFromJson(Map<String, dynamic> json) =>
    AppBaseInfoResult()
      ..recommend_app_version = json['recommend_app_version'] as String?
      ..update_copy = json['update_copy'] as String?;

Map<String, dynamic> _$AppBaseInfoResultToJson(AppBaseInfoResult instance) =>
    <String, dynamic>{
      'recommend_app_version': instance.recommend_app_version,
      'update_copy': instance.update_copy,
    };
