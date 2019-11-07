import 'package:flutter/material.dart';
import 'package:timestampphy/ui/widgets/bottom_tab_navigation.dart';

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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Offstage(
              offstage: _selectedTabIndex != 0,
              child: Center(
                child: Text("Page 1")
              )
            ),
            Offstage(
                offstage: _selectedTabIndex != 1,
                child: Center(
                    child: Text("Page 2")
                )
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomTabNavigation(
        notchedShape: CircularNotchedRectangle(),
        selectedColor: Colors.lightBlue,
        onTabSelected: _setSelectedTabIndex,
        items: [
          BottomTabNavigationItem(iconData: Icons.history, text: "Photo history"),
          BottomTabNavigationItem(iconData: Icons.search, text: "Photo search")
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
            Icons.camera,
            color: Colors.lightBlueAccent
        ),
        onPressed: () => {/*Will open camera*/},
        backgroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}