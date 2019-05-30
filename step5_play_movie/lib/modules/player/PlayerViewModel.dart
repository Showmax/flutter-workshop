import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:showmax/api/API.dart';
import 'package:showmax/api/entities/Video.dart';

import 'PlaybackPlay.dart';

class PlayerViewModel {
  // Properties / Internal
  StreamController<PlaybackPlay> _content;
  API _api;
  Video _video;

  // Properties / Public
  Stream<PlaybackPlay> content;

  // Public
  PlayerViewModel(Video video, API api) {
    _video = video;
    _api = api;
    _content = StreamController<PlaybackPlay>();
    content = _content.stream;
  }

  void load() async {
    final encoding = Platform.isAndroid ? "mpd_clear" : "hls_clear";
    try {
      final response = await _api.directGet("${_video.link}?&encoding=$encoding");
      final playbackPlay = PlaybackPlay.fromJson(json.decode(response.body));
      _content.add(playbackPlay);
    } catch (error) {
      print(error);
      _content.addError(error);
    }
  }
}
