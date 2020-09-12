import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../constant.dart';

class PieChartSampleBig extends StatefulWidget {
  // chart values
  double doingGreatStudents;
  double needHelpStudents;
  double frustratedStudents;
  double inactiveStudents;
  // chart titles
  String doingGreatPercentage;
  String needHelpPercentage;
  String frustratedPercentage;
  String inactivePercentage;

  PieChartSampleBig({
    // values
    this.doingGreatStudents,
    this.needHelpStudents,
    this.frustratedStudents,
    this.inactiveStudents,
    // graph title
    this.doingGreatPercentage,
    this.needHelpPercentage,
    this.frustratedPercentage,
    this.inactivePercentage,
  });
  @override
  _PieChartSampleBigState createState() => _PieChartSampleBigState();
}

class _PieChartSampleBigState extends State<PieChartSampleBig> {
  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.6,
      child: Row(
        children: <Widget>[
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: Stack(
                children: [
                  widget.doingGreatPercentage == "100%" ||
                          widget.needHelpPercentage == "100%" ||
                          widget.frustratedPercentage == "100%" ||
                          widget.inactivePercentage == "100%"
                      ? Center(
                          child: Text(
                            '100%',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: widget.doingGreatPercentage == "100%"
                                    ? kPieChartDoingGreatColor
                                    : widget.needHelpPercentage == "100%"
                                        ? kPieChartNeedHelpColor
                                        : widget.frustratedPercentage == "100%"
                                            ? kPieChartFrustratedColor
                                            : kPieChartInactiveColor),
                          ),
                        )
                      : Container(),
                  Center(
                    child: PieChart(
                      PieChartData(
                          pieTouchData:
                              PieTouchData(touchCallback: (pieTouchResponse) {
                            setState(() {
                              if (pieTouchResponse.touchInput
                                      is FlLongPressEnd ||
                                  pieTouchResponse.touchInput is FlPanEnd) {
                                touchedIndex = -1;
                              } else {
                                touchedIndex =
                                    pieTouchResponse.touchedSectionIndex;
                              }
                            });
                          }),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          startDegreeOffset: 0,
                          sectionsSpace:
                              widget.doingGreatPercentage == "100%" ||
                                      widget.needHelpPercentage == "100%" ||
                                      widget.frustratedPercentage == "100%" ||
                                      widget.inactivePercentage == "100%"
                                  ? 0
                                  : 10,
                          // TODO : DISPLAY 100 % Green in the middle of the pie chart
                          // if it is 100 percent of one color
                          // center -space -rad used to be 40
                          centerSpaceRadius: 45,
                          sections: showingSections()),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.only(
          //       right: MediaQuery.of(context).size.width * 0.095,
          //       left: MediaQuery.of(context).size.width * 0.08),
          //   child: Column(
          //     mainAxisSize: MainAxisSize.max,
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: <Widget>[
          //       Indicator(
          //         color: kPieChartDoingGreatColor,
          //         text: 'Doing Great',
          //         isSquare: false,
          //       ),
          //       SizedBox(
          //         height: MediaQuery.of(context).size.height * 0.0135,
          //       ),
          //       Indicator(
          //         color: kPieChartNeedHelpColor,
          //         text: 'Need Help',
          //         isSquare: false,
          //       ),
          //       SizedBox(
          //         height: MediaQuery.of(context).size.height * 0.0135,
          //       ),
          //       Indicator(
          //         color: kPieChartFrustratedColor,
          //         text: 'Frustrated',
          //         isSquare: false,
          //       ),
          //       SizedBox(
          //         height: MediaQuery.of(context).size.height * 0.0135,
          //       ),
          //       Indicator(
          //         color: kPieChartInactiveColor,
          //         text: 'Inactive',
          //         isSquare: false,
          //       ),
          //       SizedBox(
          //         height: 0,
          //       ),
          //     ],
          //   ),
          // ),
          // const SizedBox(
          //   width: 38,
          // ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched
          ? MediaQuery.of(context).size.width * 0.145
          //TODO : used to be 0.118 adjusted to this better style change to 0.08?
          : MediaQuery.of(context).size.width * 0.118;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: kPieChartDoingGreatColor,
            value: widget.doingGreatStudents,
            title: widget.doingGreatStudents != 0 &&
                    widget.doingGreatPercentage != "100%"
                ? widget.doingGreatPercentage
                : '',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: kPieChartNeedHelpColor,
            value: widget.needHelpStudents,
            title: widget.needHelpStudents != 0 &&
                    widget.needHelpPercentage != "100%"
                ? widget.needHelpPercentage
                : '',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: kPieChartFrustratedColor,
            value: widget.frustratedStudents,
            title: widget.frustratedStudents != 0 &&
                    widget.frustratedPercentage != "100%"
                ? widget.frustratedPercentage
                : '',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: kPieChartInactiveColor,
            value: widget.inactiveStudents,
            title: widget.inactiveStudents != 0 &&
                    widget.inactivePercentage != "100%"
                ? widget.inactivePercentage
                : '',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }
}
//

// class PieChartSampleBig extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => PieChart2State();
// }

// class PieChart2State extends State {
//   int touchedIndex;

//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 1.5,
//       child: Row(
//           children: <Widget>[
//             const SizedBox(
//               height: 18,
//             ),
//             Expanded(
//               child: AspectRatio(
//                 aspectRatio: 1,
//                 child: PieChart(
//                   PieChartData(
//                       pieTouchData:
//                           PieTouchData(touchCallback: (pieTouchResponse) {
//                         setState(() {
//                           if (pieTouchResponse.touchInput is FlLongPressEnd ||
//                               pieTouchResponse.touchInput is FlPanEnd) {
//                             touchedIndex = -1;
//                           } else {
//                             touchedIndex = pieTouchResponse.touchedSectionIndex;
//                           }
//                         });
//                       }),
//                       borderData: FlBorderData(
//                         show: false,
//                       ),
//                       sectionsSpace: 0,
//                       centerSpaceRadius: 40,
//                       sections: showingSections()),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(right: 38, left: 30),
//               child: Column(
//                 mainAxisSize: MainAxisSize.max,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: const <Widget>[
//                   Indicator(
//                     color: kPieChartDoingGreatColor,
//                     text: 'Doing Great',
//                     isSquare: false,
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Indicator(
//                     color: kPieChartNeedHelpColor,
//                     text: 'Need Help',
//                     isSquare: false,
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Indicator(
//                     color: kPieChartFrustratedColor,
//                     text: 'Frustrated',
//                     isSquare: false,
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Indicator(
//                     color: kPieChartInactiveColor,
//                     text: 'Inactive',
//                     isSquare: false,
//                   ),
//                   SizedBox(
//                     height: 0,
//                   ),
//                 ],
//               ),
//             ),
//             // const SizedBox(
//             //   width: 38,
//             // ),
//           ],
//         ),

//     );
//   }

//   List<PieChartSectionData> showingSections() {
//     return List.generate(4, (i) {
//       final isTouched = i == touchedIndex;
//       final double fontSize = isTouched ? 25 : 16;
//       final double radius = isTouched ? 60 : 50;
//       switch (i) {
//         case 0:
//           return PieChartSectionData(
//             color: kPieChartDoingGreatColor,
//             value: 25,
//             title: '25%',
//             radius: radius,
//             titleStyle: TextStyle(
//                 fontSize: fontSize,
//                 fontWeight: FontWeight.bold,
//                 color: const Color(0xffffffff)),
//           );
//         case 1:
//           return PieChartSectionData(
//             color: kPieChartNeedHelpColor,
//             value: 25,
//             title: '25%',
//             radius: radius,
//             titleStyle: TextStyle(
//                 fontSize: fontSize,
//                 fontWeight: FontWeight.bold,
//                 color: const Color(0xffffffff)),
//           );
//         case 2:
//           return PieChartSectionData(
//             color: kPieChartFrustratedColor,
//             value: 25,
//             title: '25%',
//             radius: radius,
//             titleStyle: TextStyle(
//                 fontSize: fontSize,
//                 fontWeight: FontWeight.bold,
//                 color: const Color(0xffffffff)),
//           );
//         case 3:
//           return PieChartSectionData(
//             color: kPieChartInactiveColor,
//             value: 25,
//             title: '25%',
//             radius: radius,
//             titleStyle: TextStyle(
//                 fontSize: fontSize,
//                 fontWeight: FontWeight.bold,
//                 color: const Color(0xffffffff)),
//           );
//         default:
//           return null;
//       }
//     });
//   }
// }

///
///    SMALL PIE CHART - USE FOR TEACHER CLASSES SCREEN (VIEWING ALL THE CLASSES)
///

class PieChartSampleSmall extends StatefulWidget {
  // chart values
  double doingGreatStudents;
  double needHelpStudents;
  double frustratedStudents;
  double inactiveStudents;

  PieChartSampleSmall({
    // values
    this.doingGreatStudents,
    this.needHelpStudents,
    this.frustratedStudents,
    this.inactiveStudents,
  });
  @override
  _PieChartSampleSmallState createState() => _PieChartSampleSmallState();
}

class _PieChartSampleSmallState extends State<PieChartSampleSmall> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: PieChart(
          PieChartData(
              borderData: FlBorderData(
                show: false,
              ),
              sectionsSpace: 0,
              startDegreeOffset: 0,
              centerSpaceRadius: 15,
              sections: showingSectionsSmall()),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSectionsSmall() {
    return List.generate(4, (i) {
      final double radius = 20;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: kPieChartDoingGreatColor,
            value: widget.doingGreatStudents,
            title: '',
            radius: radius,
          );
        case 1:
          return PieChartSectionData(
            color: kPieChartNeedHelpColor,
            value: widget.needHelpStudents,
            title: '',
            radius: radius,
          );
        case 2:
          return PieChartSectionData(
            color: kPieChartFrustratedColor,
            value: widget.frustratedStudents,
            title: '',
            radius: radius,
          );
        case 3:
          return PieChartSectionData(
            color: kPieChartInactiveColor,
            value: widget.inactiveStudents,
            title: '',
            radius: radius,
          );
        default:
          return null;
      }
    });
  }
}

///
///   INDICATOR CLASS - USED BY SAMPLE 2 (big chart) FOR THE GRAPH KEY
///

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color textColor;

  const Indicator({
    Key key,
    this.color,
    this.text,
    this.isSquare,
    this.size = 16,
    this.textColor = const Color(0xff505050),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
        )
      ],
    );
  }
}

class GraphKey extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Graph Key : ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.016,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Indicator(
                      color: kPieChartDoingGreatColor,
                      text: 'Doing Great',
                      isSquare: false,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.016,
                    ),
                    Indicator(
                      color: kPieChartNeedHelpColor,
                      text: 'Need Help',
                      isSquare: false,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.016,
                    ),
                    Indicator(
                      color: kPieChartFrustratedColor,
                      text: 'Frustrated',
                      isSquare: false,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.016,
                    ),
                    Indicator(
                      color: kPieChartInactiveColor,
                      text: 'Inactive',
                      isSquare: false,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Text(
            'FAQ : ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.016,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Q : ',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      TextSpan(
                          text: 'Where is the class code?',
                          style: TextStyle(fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.016,
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'A : ',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      TextSpan(
                          text:
                              'The class code is located under the class settings tab.  Scroll to the right on the above tab bar to view the settings tab.',
                          style: TextStyle(fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Q : ',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      TextSpan(
                          text: 'What\'s the gray?',
                          style: TextStyle(fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.016,
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'A : ',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      TextSpan(
                          text:
                              'Students who don\'t change their status will show up as gray on your graph.  Change the gray limit with the max inactive days property in the class settings.',
                          style: TextStyle(fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Q : ',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      TextSpan(
                          text: 'Need additional help?',
                          style: TextStyle(fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.016,
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'A : ',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Contact ',
                            style: TextStyle(fontWeight: FontWeight.w400),
                          ),
                          TextSpan(
                            text: 'support@classvibes.net',
                            style: TextStyle(fontWeight: FontWeight.w400, color: kPrimaryColor),
                          ),
                          TextSpan(
                            text: '.  We will respond shortly!',
                            style: TextStyle(fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
