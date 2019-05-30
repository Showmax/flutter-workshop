// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PlaybackPlay.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaybackPlay _$PlaybackPlayFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['asset_id', 'url'],
      disallowNullValues: const ['asset_id', 'url']);
  return PlaybackPlay(
      id: json['asset_id'] as String, url: json['url'] as String);
}

Map<String, dynamic> _$PlaybackPlayToJson(PlaybackPlay instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('asset_id', instance.id);
  writeNotNull('url', instance.url);
  return val;
}
