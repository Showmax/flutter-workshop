// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Video _$VideoFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['id', 'link', 'usage'],
      disallowNullValues: const ['id', 'link', 'usage']);
  return Video(
      id: json['id'] as String,
      link: json['link'] as String,
      usage: json['usage'] as String);
}

Map<String, dynamic> _$VideoToJson(Video instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('link', instance.link);
  writeNotNull('usage', instance.usage);
  return val;
}
