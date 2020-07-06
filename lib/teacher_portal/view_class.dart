import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/pie_charts.dart';
import '../widgets/filtered_tabs.dart';
import '../constant.dart';

class ViewClass extends StatefulWidget {
  static const routeName = 'individual-class-teacher';
  @override
  _ViewClassState createState() => _ViewClassState();
}

class _ViewClassState extends State<ViewClass> {
  bool _isTouchedAll = true;
  bool _isTouchedDoingGreat = false;
  bool _isTouchedNeedHelp = false;
  bool _isTouchedFrustrated = false;
  bool _isTouchedInactive = false;

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
                  child: FilterAll(this),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: FilterDoingGreat(this),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: FilterNeedHelp(this),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: FilterFrustrated(this),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 10),
                  child: FilterInactive(this),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 360,
            child: _isTouchedAll == true
                ? ListView(
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
                  )
                : _isTouchedDoingGreat
                    ? DoingGreatTab()
                    : _isTouchedNeedHelp
                        ? Text('need help')
                        : _isTouchedFrustrated
                            ? Text('frustrated')
                            : _isTouchedInactive
                                ? Text('inactive')
                                : Text('IMPORTANT - this text will never show since the first values will always be true'),
          ),
        ],
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

///
///                                            Filter Buttons
///

//NOTE ON PASSING PARENT
// need to pass parent so we can update the parent stl widget instead of keeping the scope in this one
// passing the parent fixes error where external stf widgets can't update each other

class FilterAll extends StatelessWidget {
  _ViewClassState parent;

  FilterAll(this.parent);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 92,
      child: FlatButton(
        padding: EdgeInsets.all(2),
        color: this.parent._isTouchedAll == true
            ? Colors.grey[300]
            : Colors.grey[200],
        onPressed: () {
          this.parent.setState(() {
            this.parent._isTouchedAll = true;
            this.parent._isTouchedDoingGreat = false;
            this.parent._isTouchedNeedHelp = false;
            this.parent._isTouchedFrustrated = false;
            this.parent._isTouchedInactive = false;
          });
        },
        child: Text(
          'All',
          style: TextStyle(
              color: this.parent._isTouchedAll == true
                  ? kPrimaryColor
                  : Colors.grey[700],
              fontWeight: FontWeight.w600,
              fontSize: 13.5),
        ),
      ),
    );
  }
}

class FilterDoingGreat extends StatelessWidget {
  _ViewClassState parent;

  FilterDoingGreat(this.parent);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 92,
      child: FlatButton(
        padding: EdgeInsets.all(2),
        color: this.parent._isTouchedDoingGreat == true
            ? Colors.grey[300]
            : Colors.grey[200],
        onPressed: () {
          this.parent.setState(() {
            this.parent._isTouchedAll = false;
            this.parent._isTouchedDoingGreat = true;
            this.parent._isTouchedNeedHelp = false;
            this.parent._isTouchedFrustrated = false;
            this.parent._isTouchedInactive = false;
          });
        },
        child: Text(
          'Doing Great',
          style: TextStyle(
              color: this.parent._isTouchedDoingGreat == true
                  ? kPrimaryColor
                  : Colors.grey[700],
              fontWeight: FontWeight.w600,
              fontSize: 13.5),
        ),
      ),
    );
  }
}

class FilterNeedHelp extends StatelessWidget {
  _ViewClassState parent;

  FilterNeedHelp(this.parent);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 92,
      child: FlatButton(
        padding: EdgeInsets.all(2),
        color: this.parent._isTouchedNeedHelp == true
            ? Colors.grey[300]
            : Colors.grey[200],
        onPressed: () {
          this.parent.setState(() {
            this.parent._isTouchedAll = false;
            this.parent._isTouchedDoingGreat = false;
            this.parent._isTouchedNeedHelp = true;
            this.parent._isTouchedFrustrated = false;
            this.parent._isTouchedInactive = false;
          });
        },
        child: Text(
          'Need Help',
          style: TextStyle(
              color: this.parent._isTouchedNeedHelp == true
                  ? kPrimaryColor
                  : Colors.grey[700],
              fontWeight: FontWeight.w600,
              fontSize: 13.5),
        ),
      ),
    );
  }
}

class FilterFrustrated extends StatelessWidget {
  _ViewClassState parent;

  FilterFrustrated(this.parent);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 92,
      child: FlatButton(
        padding: EdgeInsets.all(2),
        color: this.parent._isTouchedFrustrated == true
            ? Colors.grey[300]
            : Colors.grey[200],
        onPressed: () {
          this.parent.setState(() {
            this.parent._isTouchedAll = false;
            this.parent._isTouchedDoingGreat = false;
            this.parent._isTouchedNeedHelp = false;
            this.parent._isTouchedFrustrated = true;
            this.parent._isTouchedInactive = false;
          });
        },
        child: Text(
          'Frustrated',
          style: TextStyle(
              color: this.parent._isTouchedFrustrated == true
                  ? kPrimaryColor
                  : Colors.grey[700],
              fontWeight: FontWeight.w600,
              fontSize: 13.5),
        ),
      ),
    );
  }
}

class FilterInactive extends StatelessWidget {
  _ViewClassState parent;

  FilterInactive(this.parent);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 92,
      child: FlatButton(
        padding: EdgeInsets.all(2),
        color: this.parent._isTouchedInactive == true
            ? Colors.grey[300]
            : Colors.grey[200],
        onPressed: () {
          this.parent.setState(() {
            this.parent._isTouchedAll = false;
            this.parent._isTouchedDoingGreat = false;
            this.parent._isTouchedNeedHelp = false;
            this.parent._isTouchedFrustrated = false;
            this.parent._isTouchedInactive = true;
          });
        },
        child: Text(
          'Inactive',
          style: TextStyle(
              color: this.parent._isTouchedInactive == true
                  ? kPrimaryColor
                  : Colors.grey[700],
              fontWeight: FontWeight.w600,
              fontSize: 13.5),
        ),
      ),
    );
  }
}
