import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:showmax/api/API.dart';
import 'package:showmax/api/entities/Video.dart';
import 'package:showmax/modules/player/PlayerViewModel.dart';
import 'package:video_player/video_player.dart';

import 'PlaybackPlay.dart';
import 'PlayerViewModel.dart';

class PlayerScreen extends StatefulWidget {
  final PlayerViewModel _viewModel;

  PlayerScreen(Video video) : this._viewModel = PlayerViewModel(video, API());

  @override
  _PlayerScreenState createState() => _PlayerScreenState(_viewModel);
}

class _PlayerScreenState extends State<PlayerScreen> {
  final PlayerViewModel _viewModel;
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;
  Chewie _chewie;

  _PlayerScreenState(this._viewModel);

  @override
  void initState() {
    super.initState();
    _viewModel.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: StreamBuilder<PlaybackPlay>(
              stream: _viewModel.content,
              builder: (BuildContext context, AsyncSnapshot<PlaybackPlay> snapshot) {
                if (snapshot.hasError) {
                  return _error(snapshot.error);
                }
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return _empty();
                  case ConnectionState.waiting:
                    return _waiting();
                  case ConnectionState.active:
                    return _content(snapshot.data);
                  case ConnectionState.done:
                    return _content(snapshot.data);
                }
              },
            ),
          ),
          new Container(
              margin: new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: new BackButton(color: Colors.white))
        ],
      ),
    );
  }

  Widget _waiting() {
    return CircularProgressIndicator();
  }

  Widget _empty() {
    return Container();
  }

  Widget _error(Object error) {
    return Text("Error: $error");
  }

  Widget _content(PlaybackPlay content) {
    //TODO uncomment as we don't want always to create new instance of chewie
//    if (_chewie != null) {
//      return _chewie;
//    }
    _videoPlayerController = VideoPlayerController.network(
        content.url ?? 'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4',
//TODO: apply modification for custom chewie version
//        Platform.isAndroid ? DataSourceEncoding.dash : DataSourceEncoding.hls
    );
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
      allowFullScreen: false,
    );
    _chewie = Chewie(
      controller: _chewieController,
    );
    return _chewie;
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _videoPlayerController?.dispose();
    super.dispose();
  }
}
