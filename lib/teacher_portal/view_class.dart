import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/pie_charts.dart';
import '../constant.dart';

class ViewClass extends StatefulWidget {
  static const routeName = 'individual-class-teacher';
  @override
  _ViewClassState createState() => _ViewClassState();
}

class _ViewClassState extends State<ViewClass> {
  bool isTouchedAll = true;
  bool isTouchedDoingGreat = false;
  bool isTouchedNeedHelp = false;
  bool isTouchedFrustrated = false;
  bool isTouchedInactive = false;
  @override
  Widget build(BuildContext context) {
    final routeArguments = ModalRoute.of(context).settings.arguments as Map;
    final String className = routeArguments['class name'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWetAsphaltColor,
        title: Text(className),
        centerTitle: true,
      ),
      body: Column(
        children: [
          PieChartSampleBig(),
          Container(
            height: 32.5,
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Button(
                    name: 'All',
                    isTouched: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Button(
                    name: 'Doing Great',
                    isTouched: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Button(
                    name: 'Need Help',
                    isTouched: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Button(
                    name: 'Frustrated',
                    isTouched: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 10),
                  child: Button(
                    name: 'Inactive',
                    isTouched: false,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 360,
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Student(
                  name: 'Holland Pleskac',
                  status: 'Doing Great',
                  profilePictureLink:
                      'https://cdn.fastly.picmonkey.com/contentful/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=800&q=70',
                ),
                Student(
                  name: 'Shabd Veyyakula',
                  status: 'Need Help',
                  profilePictureLink:
                      'https://img-cdn.tid.al/o/4858a4b2723b7d0c7d05584ff57701f7b0c54ce3.jpg',
                ),
                Student(
                  name: 'Kushagra Singh',
                  status: 'Inactive',
                  profilePictureLink:
                      'https://lh3.googleusercontent.com/proxy/s4loFI-1bt-dxkFqW8EnFXewl1hnBisUyUiQ_Mo6ucc8tSOSMvud02ylLQpj03vF8I_I9Qrb5qHCRyB20xrz0uy5_rE-1NuKdCWvEcHSo4jCB4guthqJqNnDIe-9K-5-zNamW3efFyfHuD-SQ6D_O8LFICvL9Lyi-g',
                ),
                Student(
                  name: 'Pranav Krishna',
                  status: 'Frustrated',
                  profilePictureLink: null,
                ),
                Student(
                  name: 'Advithi Kethidi',
                  status: 'Inactive',
                  profilePictureLink:
                      'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Button extends StatefulWidget {
  final String name;
  bool isTouched;

  Button({this.name, this.isTouched});

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 92,
      child: FlatButton(
        padding: EdgeInsets.all(2),
        color: widget.isTouched == true ? Colors.grey[300] : Colors.grey[200],
        onPressed: () {
          setState(() {
            widget.isTouched = true;
          });
        },
        child: Text(
          widget.name,
          style: TextStyle(
              color:
                  widget.isTouched == true ? kPrimaryColor : Colors.grey[700],
              fontWeight: FontWeight.w600,
              fontSize: 13.5),
        ),
      ),
    );
  }
}

class Student extends StatelessWidget {
  final String name;
  final String status;
  final String profilePictureLink;

  Student({this.name, this.status, this.profilePictureLink});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: Row(
        children: [
          SizedBox(
            width: 20,
          ),
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(9999),
            ),
            child: profilePictureLink == null
                ? Center(
                    child: FaIcon(
                      FontAwesomeIcons.userAlt,
                      color: kPrimaryColor,
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(9999),
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: Image.network(
                        profilePictureLink,
                      ),
                    ),
                  ),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(),
              Container(),
              Text(
                name,
                style: TextStyle(fontSize: 16.5),
              ),
              Text(
                'Last updated: 7 days ago',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              Container(),
              Container(),
            ],
          ),
          Spacer(),
          FaIcon(
            FontAwesomeIcons.solidComments,
            color: kPrimaryColor,
            size: 35,
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
    );
  }
}
