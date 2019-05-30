import 'package:flutter/material.dart';
import 'package:showmax/modules/home/HomeViewModel.dart';
import 'package:showmax/helpers/HexColor.dart';
// TODO #7: Enable library for showing image
// import 'package:cached_network_image/cached_network_image.dart';

// TODO #3: Investigate the change from StatelesslWidget to StatefulWidget. Look when is view model created.

class HomeScreen extends StatefulWidget {

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  
  HomeViewModel _viewModel;

  // - Lifecycle -

  @override
  void initState() {
    super.initState();
    _viewModel = HomeViewModel();
    _viewModel.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SafeArea(
        child: _body(),
      ),
    );
  }

  Widget _body() {
    // TODO #1: Try loaded state, and implement waiting and error state.
    return _loaded([
      HomeItem(title: "Item 1", imageLink: "http://lorempixel.com/300/450/city/1", imageColor: "FFA500"),
      HomeItem(title: "Item 2", imageLink: "http://lorempixel.com/300/450/city/2", imageColor: "FFA500"),
      HomeItem(title: "Item 3", imageLink: "http://lorempixel.com/300/450/city/3", imageColor: "FFA500")
    ]);
  }

//  // SOLUTION #1:
//  Widget _body() {
//    return _loaded([
//      HomeItem(title: "Item 1", imageLink: "http://lorempixel.com/300/450/city/1", imageColor: "FFA500"),
//      HomeItem(title: "Item 2", imageLink: "http://lorempixel.com/300/450/city/2", imageColor: "FFA500"),
//      HomeItem(title: "Item 3", imageLink: "http://lorempixel.com/300/450/city/3", imageColor: "FFA500")
//    ]);
//    return _waiting();
//    return _error("No internet connection");
//  }
//
//  Widget _waiting() {
//    return Center(child: CircularProgressIndicator());
//  }
//
//  Widget _error(Object error) {
//    final textTheme = Theme.of(context).textTheme;
//    return Center(
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text("Loading error", style: textTheme.title),
//         SizedBox(height: 5),
//         Text("Please try again later.", style: textTheme.subtitle),
//         SizedBox(height: 5),
//         Text("Reason: $error", style: textTheme.caption)
//       ]
//     )
//    );
//  }

  // TODO #4: Setup listening on view model items stream of events

// SOLUTION #4:
// Widget _body() {
//   return StreamBuilder<List<HomeItem>>(
//     stream: _viewModel.items,
//     builder: (BuildContext context, AsyncSnapshot<List<HomeItem>> snapshot) {
//       if (snapshot.hasError) {
//         return _error(snapshot.error);
//       }
//       switch (snapshot.connectionState) {
//         case ConnectionState.none:
//         case ConnectionState.waiting:
//           return _waiting();
//         case ConnectionState.active:
//         case ConnectionState.done:
//           return _loaded(snapshot.data);
//       }
//     },
//   );
// }

  // - Helpers -

  Widget _loaded(List<HomeItem> homeItems) {
    return GridView.count(
      padding: const EdgeInsets.all(16.0),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      crossAxisCount: 3,
      childAspectRatio: 2 / 3,
      primary: true,
      children: homeItems.map<Widget>((item) { return _gridTile(item); }).toList(),
    );
  }

  Widget _gridTile(HomeItem item) {
    return GridTile(
      child: GestureDetector(
        child: Container(
          color: HexColor(item.imageColor),
          child: Stack(
            children: [
              _title(item.title),
              // TODO #7: Show image inside grid tile
              // _image(item.imageLink),
            ],
          ),
        ),
      ),
    );
  }

  // TODO #7: Show image inside grid tile

  Widget _title(String title) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
          color: Colors.black,
        ),
      )),
    );
  }

  Widget _appBar() {
    return AppBar(
      title: Image.asset(
        'assets/showmax_white_logo.png',
        fit: BoxFit.cover,
        height: 30.0,
      ),
      elevation: 0,
      backgroundColor: Colors.black,
      textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.white),
      actions: [
        IconButton(icon: const Icon(Icons.refresh), onPressed: () => _viewModel.load() ),
      ],
    );
  }
}

// SOLUTION #7: Show image inside grid tile
// Widget _image(String path) {
//   return CachedNetworkImage(
//     fit: BoxFit.cover,
//     imageUrl: path,
//   );
// }