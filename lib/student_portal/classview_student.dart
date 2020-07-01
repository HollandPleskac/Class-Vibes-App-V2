import 'dart:ui';
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
        actions: [
          Center(
            child: GestureDetector(
              onTap: () {
                print('press question');
                showStudentInfoPopUp(context);
              },
              child: FaIcon(
                FontAwesomeIcons.question,
                size: 25,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(30),
          crossAxisSpacing: 15,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: <Widget>[
            Stack(
              children: [
                Container(
                  // color: Colors.red,
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 35,
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 0),
                            child: Text(
                              'Honors Biology',
                              style: kSubTextStyle.copyWith(fontSize: 20),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  print('touched happy face');
                                },
                                child: FaIcon(
                                  FontAwesomeIcons.solidSmile,
                                  color: Colors.green,
                                  size: 35,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  print('tapped meh');
                                },
                                child: FaIcon(
                                  FontAwesomeIcons.meh,
                                  color: Colors.yellow[800],
                                  size: 35,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  print('tapped frown');
                                },
                                child: FaIcon(
                                  FontAwesomeIcons.frown,
                                  color: Colors.red,
                                  size: 35,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(14),
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
                    child: FaIcon(
                      FontAwesomeIcons.solidComments,
                      size: 50,
                      color: kPrimaryColor,
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
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 35,
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 0),
                            child: Text(
                              'AP History',
                              style: kSubTextStyle.copyWith(fontSize: 20),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  print('touched happy face');
                                },
                                child: FaIcon(
                                  FontAwesomeIcons.smile,
                                  color: Colors.green,
                                  size: 35,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  print('tapped meh');
                                },
                                child: FaIcon(
                                  FontAwesomeIcons.meh,
                                  color: Colors.yellow[800],
                                  size: 35,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  print('tapped frown');
                                },
                                child: FaIcon(
                                  FontAwesomeIcons.solidFrown,
                                  color: Colors.red,
                                  size: 35,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(14),
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
                    child: FaIcon(
                      FontAwesomeIcons.solidComments,
                      size: 50,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void showStudentInfoPopUp(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Material(
          type: MaterialType.transparency,
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
              child: Container(
                  width: 300.0,
                  height: 200.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white.withOpacity(01)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Current Mood",
                        style: TextStyle(
                            fontSize: 24.5,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "How do you currently feel about class? ",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 80,
                        width: MediaQuery.of(context).size.width / 3 + 120,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.smile,
                                  size: 43.0,
                                  color: Colors.green,
                                ),
                                Text(
                                  "Doing Great",
                                  style: TextStyle(
                                    fontSize: 15,
                                      color: Colors.green,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.meh,
                                  size: 43.0,
                                  color: Colors.orange[600],
                                ),
                                Text(
                                  " Need Help ",
                                  style: TextStyle(
                                    fontSize: 15,
                                      color: Colors.orange[600],
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.frown,
                                  size: 43.0,
                                  color: Colors.red[700],
                                ),
                                Text(
                                  "Frustrated",
                                  style: TextStyle(
                                    fontSize: 15,
                                      color: Colors.red[700],
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Colors.grey[500].withOpacity(0.15),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ],
                  )),
            ),
          ),
        ),
      );
    },
  );
}
