import 'package:flutter/material.dart';
import 'package:showmax/helpers/HexColor.dart';
import 'package:showmax/api/entities/Asset.dart';
import 'package:showmax/modules/player/PlayerScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'DetailViewModel.dart';
import 'dart:math';

class DetailScreen extends StatefulWidget {

  final DetailViewModel _viewModel;
  DetailScreen(Asset asset):
    this._viewModel = DetailViewModel(asset);

  @override
  DetailScreenState createState() => new DetailScreenState(_viewModel);
}

class DetailScreenState extends State<DetailScreen> {

  final DetailViewModel _viewModel;
  
  DetailScreenState(this._viewModel);

  // - Lifecycle - 

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Detail>(
      stream: _viewModel.content,
      builder: (BuildContext context, AsyncSnapshot<Detail> snapshot) {
        final theme = _Theme.fromDetail(snapshot.data);
        List <Widget> stack = [];
        stack.add(_content(snapshot, theme));
        stack.add(_backButton(context, theme));
        return new Scaffold(
          backgroundColor: theme.background,
          body: Container(
            constraints: new BoxConstraints.expand(),
            child: Stack(children: stack),
          ),
        );
      },
    );
  }

  // - Content states - 

  Widget _content(AsyncSnapshot<Detail> snapshot, _Theme theme) {
    return Center(
      child: () {
        if (snapshot.hasError) {
          return _error(snapshot.error);
        }
        switch (snapshot.connectionState) {
          case ConnectionState.none: 
            return _empty();
          case ConnectionState.waiting: 
            return _waiting();
          case ConnectionState.active:
          case ConnectionState.done: 
            return _detail(snapshot.data, theme);
        }
      }(),
    );
  }

  Widget _waiting() {
    return CircularProgressIndicator();
  }

  Widget _empty() {
    return Container();
  }

  Widget _error(Object error) {
    return Text("Loading error, please try again later.");
  }

  Widget _detail(Detail detail, _Theme theme) {
    return Stack(children: [
      _Image(
        imageLink: detail.imageLink, 
        imageHeight: theme.imageHeight, 
        gradientColor: theme.background
      ),
      _heading(
        title: _title(detail.title, theme),
        button: detail.watchButtonVideo != null ? _WatchNowButton(
          onPressed: () { 
              Navigator.push(context, MaterialPageRoute(builder: (context) => PlayerScreen(detail.watchButtonVideo)));
           },
          theme: theme,
        ) : null,
        theme: theme,
      ),
    ]);
  }

  // - Sub widgets - 
  
  Widget _backButton(BuildContext context, _Theme theme) {
    return new Container(
      margin: new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: new BackButton(color: theme.foreground)
    ); 
  }

  Widget _heading({Widget title, Widget button, _Theme theme}) {
    List<Widget> column = [
      _gap(height: theme.imageHeight - 50),
      title,
      _gap(height: 5)
    ];
    if (button != null) {
      column.add(button);
    }
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: new Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: column,
        ),
      ),
    );
  }

  Widget _title(String title, _Theme theme) {
    return Container(
      child: new Text(
        '$title',
        style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: theme.foreground
        ),
      ),
    );
  }

  Widget _gap({int height}) {
    return SizedBox(height: height.toDouble());
  }
}

class _WatchNowButton extends RaisedButton {
  _WatchNowButton({
    Function onPressed,
    _Theme theme,
  }): super(
      padding: EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      textColor: theme.highlightContrast,
      color: theme.highlight,
      child: Text("▶︎  Watch Now"),
      elevation: 0,
      onPressed: onPressed,
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30.0)
      )
  );
}

class _Image extends StatelessWidget {

  final String imageLink;
  final int imageHeight;
  final Color gradientColor;

  _Image({this.imageLink, this.imageHeight, this.gradientColor});
  
  @override
  Widget build(BuildContext context) {
    var path = imageLink;
    if (path != null) {
      path = '$path/x${imageHeight*2}';
    }
    return Container(
      height: max(imageHeight.toDouble(), 0),
      child: Stack(
        children: [
          Container(
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: path,
            ),
            constraints: new BoxConstraints.expand(height: max(imageHeight.toDouble(), 0)),
          ),
          _imageGradient()
        ],
      ),
    );
  }

  Widget _imageGradient() {
    final height = 110.0;
    final top = imageHeight.toDouble() - height;
    return Container(
      margin: new EdgeInsets.only(top: max(top, 0)),
      height: height,
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: <Color>[
            gradientColor.withAlpha(0),
            gradientColor
          ],
          stops: [0.0, 1.0],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.0, 1.0),
        ),
      ),
    );
  }
}

class _Theme {
  final int imageHeight;
  final int itemGap;
  final Color background;
  final Color foreground;
  final Color highlight;
  final Color highlightContrast;
  _Theme({this.background, this.foreground, this.highlight, this.highlightContrast, this.imageHeight = 300, this.itemGap = 16});

  static _Theme fromDetail(Detail detail) {
    return _Theme(
      background: detail == null ? Colors.black : HexColor(detail.backgroundColor),
      foreground: detail == null ? Colors.white : HexColor(detail.foregroundColor),
      highlight: detail == null ? Colors.white : HexColor(detail.highlightColor),
      highlightContrast: detail == null ? Colors.black : HexColor(detail.highlightContrastColor),
    );
  }
}