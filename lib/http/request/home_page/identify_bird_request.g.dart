// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'identify_bird_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IdentifyBirdResult _$IdentifyBirdResultFromJson(Map<String, dynamic> json) =>
    IdentifyBirdResult()
      ..has_identify_error = json['has_identify_error'] as bool?
      ..has_bird = json['has_bird'] as bool?
      ..name = json['name'] as String?
      ..introduction = json['introduction'] as String?;

Map<String, dynamic> _$IdentifyBirdResultToJson(IdentifyBirdResult instance) =>
    <String, dynamic>{
      'has_identify_error': instance.has_identify_error,
      'has_bird': instance.has_bird,
      'name': instance.name,
      'introduction': instance.introduction,
    };
