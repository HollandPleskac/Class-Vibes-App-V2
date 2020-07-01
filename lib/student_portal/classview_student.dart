import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constant.dart';

class ClassViewStudent extends StatefulWidget {
  @override
  _ClassViewStudentState createState() => _ClassViewStudentState();
}

class _ClassViewStudentState extends State<ClassViewStudent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(250, 250, 250, 1.0),
      appBar: AppBar(
        backgroundColor: kWetAsphaltColor,
        title: Text(
          'Screen 3',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GridView.count(
          shrinkWrap: true,
          primary: false,
          padding: const EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
          ),
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          crossAxisCount: 2,
          children: <Widget>[
            Stack(
              children: [
                Container(
                  // color: Colors.red,
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 15, left: 5, right: 5),
                  child: Padding(
                    padding: EdgeInsets.all(7),
                    child: Card(
                      elevation: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 35,
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 25),
                            child: Text(
                              'AP Calculus',
                              style: kHeadingTextStyle,
                            ),
                          ),
                          Container(
                            height: 70,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                // to understand what is going on add containers with colors
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.solidSmile,
                                        color: Colors.green,
                                        size: 30,
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Doing',
                                            style: TextStyle(fontSize: 11),
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            'Great',
                                            style: TextStyle(fontSize: 11),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.meh,
                                        color: Colors.grey,
                                        size: 30,
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Need',
                                            style: TextStyle(fontSize: 11),
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            'Help',
                                            style: TextStyle(fontSize: 11),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),

                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.frown,
                                        color: Colors.grey,
                                        size: 30,
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Text(
                                        'Frustrated',
                                        style: TextStyle(fontSize: 11),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(2),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: InkWell(
                    onTap: () {
                      print('tap');
                    },
                    borderRadius: BorderRadius.circular(3000),
                    child: Center(
                      child: FaIcon(
                        FontAwesomeIcons.commentDots,
                        color: kPrimaryColor,
                        size: 50,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                Container(
                  // color: Colors.red,
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 15, left: 5, right: 5),
                  child: Padding(
                    padding: EdgeInsets.all(7),
                    child: Card(
                      elevation: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 35,
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 25),
                            child: Text(
                              'AP Calculus',
                              style: kHeadingTextStyle,
                            ),
                          ),
                          Container(
                            height: 70,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                // to understand what is going on add containers with colors
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.solidSmile,
                                        color: Colors.green,
                                        size: 30,
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Doing',
                                            style: TextStyle(fontSize: 11),
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            'Great',
                                            style: TextStyle(fontSize: 11),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.meh,
                                        color: Colors.grey,
                                        size: 30,
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Need',
                                            style: TextStyle(fontSize: 11),
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            'Help',
                                            style: TextStyle(fontSize: 11),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),

                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.frown,
                                        color: Colors.grey,
                                        size: 30,
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Text(
                                        'Frustrated',
                                        style: TextStyle(fontSize: 11),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(2),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: InkWell(
                    onTap: () {
                      print('tap');
                    },
                    borderRadius: BorderRadius.circular(3000),
                    child: Center(
                      child: FaIcon(
                        FontAwesomeIcons.commentDots,
                        color: kPrimaryColor,
                        size: 50,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                Container(
                  // color: Colors.red,
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 15, left: 5, right: 5),
                  child: Padding(
                    padding: EdgeInsets.all(7),
                    child: Card(
                      elevation: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 35,
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 25),
                            child: Text(
                              'AP Calculus',
                              style: kHeadingTextStyle,
                            ),
                          ),
                          Container(
                            height: 70,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                // to understand what is going on add containers with colors
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.solidSmile,
                                        color: Colors.green,
                                        size: 30,
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Doing',
                                            style: TextStyle(fontSize: 11),
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            'Great',
                                            style: TextStyle(fontSize: 11),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.meh,
                                        color: Colors.grey,
                                        size: 30,
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Need',
                                            style: TextStyle(fontSize: 11),
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            'Help',
                                            style: TextStyle(fontSize: 11),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),

                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.frown,
                                        color: Colors.grey,
                                        size: 30,
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Text(
                                        'Frustrated',
                                        style: TextStyle(fontSize: 11),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(2),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: InkWell(
                    onTap: () {
                      print('tap');
                    },
                    borderRadius: BorderRadius.circular(3000),
                    child: Center(
                      child: FaIcon(
                        FontAwesomeIcons.commentDots,
                        color: kPrimaryColor,
                        size: 50,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
