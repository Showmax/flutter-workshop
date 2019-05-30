import 'package:flutter/material.dart';
import 'package:showmax/api/entities/Asset.dart';
import 'package:showmax/modules/player/PlayerScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'Detail.dart';
import 'dart:math';

class DetailScreen extends StatelessWidget {

  final Detail _detail;

  DetailScreen(Asset asset):
    _detail = Detail.from(asset);

  // - Lifecycle - 

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      backgroundColor: _detail.backgroundColor ?? Colors.black,
      body: SafeArea(
        top: false,
        child: Container(
          constraints: new BoxConstraints.expand(),
          child: Stack(children: [
            _content(context),
            _backButton(context)
          ]),
        )
      ),
    );
  }

  // - Content states - 

  Widget _content(BuildContext context) {
    return Center(
      child: () {
        if (_detail == null) {
          return Text("Loading error, please try again later.");
        }
        return _loaded(context);
      }(),
    );
  }

  // TODO #3: Implement detail UI. Show title, image and description

  Widget _loaded(BuildContext context) {
    return Text("${_detail.title}");
  }

  // SOLUTION #3:

//   Widget _loaded(BuildContext context) {
//     return Stack(children: [
//       ImageWithGradient(
//         link: _detail.imageLink,
//         height: _imageHeight,
//         gradientColor: _detail.backgroundColor
//       ),
//       _heading(context),
//     ]);
//   }
//
//   Widget _heading(BuildContext context) {
//     final watchButton = _watchButton(context);
//     return Container(
//       padding: const EdgeInsets.all(16.0),
//       child: new Container(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _gap(height: _imageHeight - 50),
//             _title(),
//             _gap(height: 5),
//             if (watchButton != null) watchButton, // brand new 2.3 dart feature introduced by need from Flutter
//             _gap(height: 15),
//             _description(context)
//           ],
//         ),
//       ),
//     );
//   }

   Widget _title() {
     return Text(
       '${_detail.title}',
       style: TextStyle(
         fontSize: 36,
         fontWeight: FontWeight.bold,
         color: _detail.foregroundColor
       ),
     );
   }

   Widget _description(BuildContext context) {
     return Text(
       _detail.description,
       style: Theme.of(context).textTheme.body1,
     );
   }

   Widget _watchButton(BuildContext context) {
     if (_detail.watchButtonVideo == null) {
       return null;
     }
     return RoundedButton(
       title: "Watch Now",
       onPressed: () {
         Navigator.push(context, MaterialPageRoute(builder: (context) => PlayerScreen()));
       },
     );
   }

   Widget _gap({int height}) {
     return SizedBox(height: height.toDouble());
   }

   Widget _backButton(BuildContext context) {
     return Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: BackButton(color: _detail.foregroundColor ?? Colors.white)
     );
   }
}

final int _imageHeight = 300;

class RoundedButton extends RaisedButton {
  RoundedButton({
    String title,
    Color textColor,
    Color color,
    Function onPressed
  }): super(
     padding: EdgeInsets.symmetric(vertical: 13, horizontal: 16),
     textColor: textColor,
     color: color,
     child: Text(title),
     elevation: 0,
     onPressed: onPressed,
     shape: new RoundedRectangleBorder(
       borderRadius: new BorderRadius.circular(30.0)
     )
  );
}

class ImageWithGradient extends StatelessWidget {

  final String link;
  final int height;
  final Color gradientColor;

  ImageWithGradient({this.link, this.height, this.gradientColor});

  @override
  Widget build(BuildContext context) {
   var fullLink = link;
   if (fullLink!= null) {
     fullLink = '$fullLink/x${height*2}';
   }
   return Container(
     height: max(height.toDouble(), 0),
     child: Stack(
       children: [
         Container(
           child: CachedNetworkImage(
             fit: BoxFit.cover,
             imageUrl: fullLink,
           ),
           constraints: new BoxConstraints.expand(height: max(height.toDouble(), 0)),
         ),
         _imageGradient()
       ],
     ),
   );
  }

  Widget _imageGradient() {
   final height = 110.0;
   final top = _imageHeight.toDouble() - height;
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