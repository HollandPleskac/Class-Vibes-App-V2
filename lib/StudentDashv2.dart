
import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  void _showModalSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return 
              Container(
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Mr. Shea',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w800),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      'Ap Calc',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 55,
                          width: MediaQuery.of(context).size.width / 3 - 20,
                          child: Center(
                            child: Text(
                              "Doing Well",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.grey[600].withOpacity(0.7),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        Container(
                          height: 55,
                          width: MediaQuery.of(context).size.width / 3 - 20,
                          child: Center(
                            child: Text(
                              "Mediocre",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.grey[800].withOpacity(0.7),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        Container(
                          height: 55,
                          width: MediaQuery.of(context).size.width / 3 - 20,
                          child: Center(
                            child: Text(
                              "Confused",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.grey[800].withOpacity(0.7),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width - 50,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.chat_bubble_outline,
                            color: Colors.grey[500],
                            size: 18,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Message",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: Colors.grey[800].withOpacity(0.7),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width - 50,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.bubble_chart,
                            color: Colors.grey[500],
                            size: 18,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Announcments",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: Colors.grey[800].withOpacity(0.7),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width - 50,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.cancel,
                            color: Colors.grey[500],
                            size: 18,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Leave",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: Colors.grey[800].withOpacity(0.7),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ],
                ),
             
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            SizedBox(
              height: 90,
            ),
            Center(
                child: Text(
              "Classes",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w300),
            )),
            SizedBox(
              height: 80,
            ),
            GridView.count(
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              crossAxisCount: 2,
              children: <Widget>[
                GestureDetector(
                  onTap: _showModalSheet,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          "Ap Calc",
                          style: TextStyle(fontSize: 24),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width - 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                child: Icon(Icons.sim_card,
                                    size: 47.0, color: Colors.grey[400]),
                              ),
                              GestureDetector(
                                child: Icon(Icons.sim_card,
                                    size: 47.0, color: Colors.grey[400]),
                              ),
                              GestureDetector(
                                child: Icon(Icons.sim_card,
                                    size: 47.0, color: Colors.grey[400]),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10)),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[100],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _showModalSheet,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[800].withOpacity(0.6),
                    ),
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          "Ap Calc",
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width - 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                child: Icon(Icons.sim_card,
                                    size: 47.0, color: Colors.grey[400]),
                              ),
                              GestureDetector(
                                child: Icon(Icons.sim_card,
                                    size: 47.0, color: Colors.grey[400]),
                              ),
                              GestureDetector(
                                child: Icon(Icons.sim_card,
                                    size: 47.0, color: Colors.grey[400]),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                              color: Colors.grey[800],
                              borderRadius: BorderRadius.circular(10)),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _showModalSheet,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[800].withOpacity(0.6),
                    ),
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          "Ap Calc",
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width - 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                child: Icon(Icons.sim_card,
                                    size: 47.0, color: Colors.grey[400]),
                              ),
                              GestureDetector(
                                child: Icon(Icons.sim_card,
                                    size: 47.0, color: Colors.grey[400]),
                              ),
                              GestureDetector(
                                child: Icon(Icons.sim_card,
                                    size: 47.0, color: Colors.grey[400]),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                              color: Colors.grey[800],
                              borderRadius: BorderRadius.circular(10)),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _showModalSheet,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          "Ap Calc",
                          style: TextStyle(fontSize: 24),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width - 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                child: Icon(Icons.sim_card,
                                    size: 47.0, color: Colors.grey[400]),
                              ),
                              GestureDetector(
                                child: Icon(Icons.sim_card,
                                    size: 47.0, color: Colors.grey[400]),
                              ),
                              GestureDetector(
                                child: Icon(Icons.sim_card,
                                    size: 47.0, color: Colors.grey[400]),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10)),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[100],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _showModalSheet,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[100],
                    ),
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          "Ap Calc",
                          style: TextStyle(fontSize: 24),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width - 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                child: Icon(Icons.sim_card,
                                    size: 47.0, color: Colors.grey[400]),
                              ),
                              GestureDetector(
                                child: Icon(Icons.sim_card,
                                    size: 47.0, color: Colors.grey[400]),
                              ),
                              GestureDetector(
                                child: Icon(Icons.sim_card,
                                    size: 47.0, color: Colors.grey[400]),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10)),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _showModalSheet,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[800].withOpacity(0.6),
                    ),
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          "Ap Calc",
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width - 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                child: Icon(Icons.sim_card,
                                    size: 47.0, color: Colors.grey[400]),
                              ),
                              GestureDetector(
                                child: Icon(Icons.sim_card,
                                    size: 47.0, color: Colors.grey[400]),
                              ),
                              GestureDetector(
                                child: Icon(Icons.sim_card,
                                    size: 47.0, color: Colors.grey[400]),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                              color: Colors.grey[800],
                              borderRadius: BorderRadius.circular(10)),
                        )
                      ],
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
