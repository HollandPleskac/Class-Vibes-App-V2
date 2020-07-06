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
                ? AllTab()
                : _isTouchedDoingGreat
                    ? DoingGreatTab()
                    : _isTouchedNeedHelp
                        ? NeedHelpTab()
                        : _isTouchedFrustrated
                            ? FrustratedTab()
                            : _isTouchedInactive
                                ? InactiveTab()
                                : Text('IMPORTANT - this text will never show since the first values will always be true'),
          ),
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
