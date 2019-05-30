import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              // TODO 1: remove Text widget and uncomment Image.asset to get image logo into appbar
              // note you need to include asset in pubspec.yaml to be packaged in the app as well
              Text("Showmax"),
//        Image.asset(
//          'assets/showmax_white_logo.png',
//          fit: BoxFit.cover,
//          height: 30.0,
//        ),
          elevation: 0,
          backgroundColor: Colors.black,
          textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.white),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  // _viewModel.load();
                }),
          ],
        ),
        body: SafeArea(
          child: Center(
            child:
                // TODO 3: wrap GridView.count with OrientationBuilder and use orientation value
//                OrientationBuilder(builder: (context, orientation) {
//                  return
                GridView.count(
                    padding: const EdgeInsets.all(16.0),
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    crossAxisCount: 3,
                    // TODO 3: use: orientation == Orientation.portrait ? 3 : 6,
                    childAspectRatio: 2 / 3,
                    primary: true,
                    children: List.generate(100, (index) {
                      // TODO 2: modify returned widget with centered title and background
                      return Text("Item #$index");
//                          return Center(child:Text("Item #$index")); // centered
//                          return Container(color: Colors.orange,child: Center(child:Text("Item long super long #$index", textAlign: TextAlign.center,))); // centered + background
                    })) // add ; here when inside OrientationBuilder
//                }) // uncomment this when uncommenting OrientationBuilder
            )
        )
    );
  }
}
