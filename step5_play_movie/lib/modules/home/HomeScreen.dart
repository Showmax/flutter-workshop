import 'package:flutter/material.dart';
import 'package:showmax/helpers/HexColor.dart';
import 'package:showmax/modules/home/HomeViewModel.dart';
import 'package:showmax/modules/home/HomeLoader.dart';
import 'package:showmax/api/API.dart';
import 'package:showmax/modules/detail/DetailScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {

  final HomeViewModel _viewModel;
  HomeScreen():
    this._viewModel = HomeViewModel(HomeLoader(API()));

  @override
  HomeScreenState createState() => HomeScreenState(_viewModel);
}

class HomeScreenState extends State<HomeScreen> {
  final HomeViewModel _viewModel;

  HomeScreenState(this._viewModel);

  // - Lifecycle -

  @override
  void initState() {
    _viewModel.load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/showmax_white_logo.png',
          fit: BoxFit.cover,
          height: 30.0,
        ),
        elevation: 0,
        backgroundColor: Colors.black,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.white),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                _viewModel.load();
              }),
        ],
      ),
      body: Center(
        child: StreamBuilder<List<HomeItem>>(
          stream: _viewModel.items,
          builder: (BuildContext context, AsyncSnapshot<List<HomeItem>> snapshot) {
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
    );
  }

  // - Content states -

  Widget _waiting() {
    return CircularProgressIndicator();
  }

  Widget _empty() {
    return Text("No results.");
  }

  Widget _error(Object error) {
    return Text("Loading error, please try again later.");
  }

  Widget _content(List<HomeItem> homeItems) {
    return GridView.count(
      padding: const EdgeInsets.all(16.0),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      crossAxisCount: 3,
      childAspectRatio: 2 / 3,
      primary: true,
      children: homeItems.map<Widget>((item) {
        return _gridTile(item);
      }).toList(),
    );
  }

  // - Helpers -

  Widget _gridTile(HomeItem item) {
    return GridTile(
      child: GestureDetector(
        child: Container(
          color: HexColor(item.imageColor),
          child: Stack(
            children: [
              _titleWidget(item.title),
              _imageWidget(item.imageLink),
            ],
          ),
        ),
        onTapUp: (tap) { 
          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(item.asset)));
        },
      ),
    );
  }

  Widget _imageWidget(String path) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: path,
    );
  }

  Widget _titleWidget(String title) {
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
}
