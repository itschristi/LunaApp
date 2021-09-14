// @dart=2.9

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:luna/themeColor.dart';

import 'CameraScreen.dart';
import 'GalleryScreen.dart';
import 'WelcomeScreen.dart';

class NavigationScreen extends StatefulWidget {
  static String id = 'NavigationScreen';

  const NavigationScreen({Key key}) : super(key: key);

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {

  GlobalKey bottomNavigationKey = GlobalKey();
  int currentTabIndex = 0;
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  int _currentTabIndex = 0;

  final widgetOptions = [
    new WelcomeScreen(),
    new CameraScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _currentTabIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: Center(
          child: widgetOptions.elementAt(_currentTabIndex),
        ),

        bottomNavigationBar: BottomNavigationBar(
          elevation: 0.0,
          onTap: _onTap,
          currentIndex: _currentTabIndex,
          backgroundColor: Colors.white,
          items: [
            BottomNavigationBarItem(
                icon: Container(
                  decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      shape: BoxShape.circle
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Icon(Icons.image,
                      color: Colors.white,
                    ),
                  ),
                ),
                title: new Text('')
            ),
            BottomNavigationBarItem(
                icon: Container(
                  decoration: BoxDecoration(
                      color: ThemeColor.Red,
                      shape: BoxShape.circle
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Icon(Icons.camera_enhance,
                        color: Colors.white,
                     ),
                  ),
                ),
                title: new Text('')
            ),

          ],

        ),
      ),
    );
  }
  _onTap(int tabIndex) {
    setState(() {
      print('current : ' + tabIndex.toString());
      if(tabIndex == 1){
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => CameraScreen()));
      }else if(tabIndex == 0){
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => GalleryScreen()));
      }
    });
  }
}

