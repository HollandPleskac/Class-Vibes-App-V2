import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'screen1.dart';
import 'screen2.dart';
import 'screen3.dart';

class TabPage extends StatefulWidget {
  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int selectedIndex = 1;

  PageController controller = PageController();

  var screens = [
    Screen1(),
    Screen2(),
    Screen3(),
  ];

  List<Icon> items = [
    Icon(
      Icons.verified_user,
      size: 20,
      color: Colors.black,
    ),
    Icon(
      Icons.verified_user,
      size: 20,
      color: Colors.black,
    ),
    Icon(
      Icons.verified_user,
      size: 20,
      color: Colors.black,
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView.builder(
        onPageChanged: (page) {
          setState(() {
            selectedIndex = page;
          });
        },
        controller: controller,
        itemBuilder: (context, index) {
          return Container(
            child: screens[index],
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: CurvedNavigationBar(
          color: Colors.white,
          backgroundColor: Colors.deepOrange,
          buttonBackgroundColor: Colors.white,
          height: 50,
          items: items, // list of items above
          index:
              selectedIndex, //Do not need to specify index - only if using page controller
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
            controller.jumpToPage(index);
          },
          animationDuration: Duration(
            milliseconds: 200,
          ),
          animationCurve: Curves.bounceInOut,
        ),
      ),
    );
  }
}
