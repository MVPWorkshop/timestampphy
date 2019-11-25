import 'package:flutter/material.dart';
import 'package:timestampphy/ui/widgets/bottom_tab_navigation.dart';
import 'package:timestampphy/ui/screens/home/tabs/photo_history.dart';
import 'package:timestampphy/ui/screens/home/tabs/photo_search.dart';
import 'package:timestampphy/router/router.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _selectedTabIndex = 0;

  void _setSelectedTabIndex(index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  void _openCameraScreen(BuildContext context) {
    Navigator.pushNamed(context, Routes.TakePictureScreen);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Offstage(
              offstage: _selectedTabIndex != 0,
              child: PhotoHistoryTab()
            ),
            Offstage(
                offstage: _selectedTabIndex != 1,
                child: PhotoSearchTab()
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomTabNavigation(
        notchedShape: CircularNotchedRectangle(),
        selectedColor: Theme.of(context).accentColor,
        backgroundColor: Color(0xFFEDEFF2),
        onTabSelected: _setSelectedTabIndex,
        items: [
          BottomTabNavigationItem(iconData: Icons.history, text: "Photo history"),
          BottomTabNavigationItem(iconData: Icons.search, text: "Photo search")
        ],
      ),
      appBar: AppBar(
        title: Text(
            _selectedTabIndex == 0 ? "Pictures you took" : "Search for a picture"
        ),
        backgroundColor: Theme.of(context).appBarTheme.color
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
            Icons.camera,
            color: Colors.white
        ),
        onPressed: () => this._openCameraScreen(context),
        backgroundColor: Theme.of(context).accentColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}