// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Media _$MediaFromJson(Map<String, dynamic> json) => Media()
  ..CoverPath = json['CoverPath'] as String?
  ..Title = json['Title'] as String?
  ..Description = json['Description'] as String?;

Map<String, dynamic> _$MediaToJson(Media instance) => <String, dynamic>{
      'CoverPath': instance.CoverPath,
      'Title': instance.Title,
      'Description': instance.Description,
    };

GetPostResult _$GetPostResultFromJson(Map<String, dynamic> json) =>
    GetPostResult()
      ..media_list = (json['media_list'] as List<dynamic>?)
          ?.map((e) => Media.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$GetPostResultToJson(GetPostResult instance) =>
    <String, dynamic>{
      'media_list': instance.media_list,
    };
