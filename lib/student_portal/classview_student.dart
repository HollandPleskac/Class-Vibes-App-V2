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
          padding: const EdgeInsets.all(0),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: <Widget>[
            Stack(
              children: [
                Container(
                  color: Colors.red,
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.all(7.5),
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 45,
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 25),
                            child: Text(
                              'AP Calculus',
                              style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.055),
                            ),
                          ),
                          Container(
                            height: 60,
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
                                        height: 5,
                                      ),
                                      Text(
                                        ' Doing Great',
                                        style: TextStyle(fontSize: 11),
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
                                        height: 5,
                                      ),
                                      Text(
                                        ' Need Help',
                                        style: TextStyle(fontSize: 11),
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
                                        height: 5,
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
                    child: Container(
                      height: 38,
                      width: 38,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: kPrimaryColor,
                      ),
                      child: Center(
                        child: FaIcon(
                          FontAwesomeIcons.gem,
                          color: Colors.white,
                          size: 20,
                        ),
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
