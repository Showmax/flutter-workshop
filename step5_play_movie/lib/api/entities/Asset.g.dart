// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Asset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Asset _$AssetFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['id', 'title'],
      disallowNullValues: const ['id', 'title']);
  return Asset(
      id: json['id'] as String,
      title: json['title'] as String,
      images: (json['images'] as List)
              ?.map((e) =>
                  e == null ? null : Image.fromJson(e as Map<String, dynamic>))
              ?.toList() ??
          [],
      videos: (json['videos'] as List)
              ?.map((e) =>
                  e == null ? null : Video.fromJson(e as Map<String, dynamic>))
              ?.toList() ??
          []);
}

Map<String, dynamic> _$AssetToJson(Asset instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('title', instance.title);
  val['images'] = instance.images;
  val['videos'] = instance.videos;
  return val;
}
