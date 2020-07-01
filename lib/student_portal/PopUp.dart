import 'dart:ui';

import 'package:flutter/material.dart';

// Light Theme

showDialog(
                      context: context,
                      builder: (context) {
                        return Center(
                          child: Material(
                            type: MaterialType.transparency,
                            child: ClipRect(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: 30.0, sigmaY: 30.0),
                                child: Container(
                                    width: 300.0,
                                    height: 200.0,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white
                                            .withOpacity(01)),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          "Current Mood",
                                          style: TextStyle(
                                              fontSize: 22,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "How do you currently feel about class? ",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[500],
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          height: 80,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width/3+120,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              GestureDetector(
                                                child: Column(
                                                  children: [
                                                    Icon(
                                                        LineAwesomeIcons.smile_o,
                                                        size: 55.0,
                                                        color: Colors.green),
                                                        Text("Great",style: TextStyle(
                                                      color: Colors.green,fontWeight: FontWeight.w500
                                                    ),)
                                                  ],
                                                ),
                                              ),
                                              GestureDetector(
                                                child: Column(
                                                  children: [
                                                    Icon(
                                                        LineAwesomeIcons.meh_o,
                                                        size: 55.0,
                                                        color: Colors.orange[500]),
                                                        Text("Need Help",style: TextStyle(
                                                      color: Colors.orange[500],fontWeight: FontWeight.w500
                                                    ),)
                                                  ],
                                                ),
                                              ),
                                              GestureDetector(
                                                child: Column(
                                                  children: [
                                                    Icon(
                                                        LineAwesomeIcons.frown_o,
                                                        size: 55.0,
                                                        color: Colors.red[700]),
                                                    Text("frustrated",style: TextStyle(
                                                      color: Colors.red[700],fontWeight: FontWeight.w500
                                                    ),)
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                              color: Colors.grey[500].withOpacity(0.15),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        )
                                      ],
                                    )),
                              ),
                            ),
                          ),
                        );
                      },
                    );




// Dark Mode

showDarkDialog(
                      context: context,
                      builder: (context) {
                        return Center(
                          child: Material(
                            type: MaterialType.transparency,
                            child: ClipRect(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: 30.0, sigmaY: 30.0),
                                child: Container(
                                    width: 300.0,
                                    height: 200.0,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.grey.shade900
                                            .withOpacity(0.65)),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          "Current Mood",
                                          style: TextStyle(
                                              fontSize: 22,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "How do you currently feel about class? ",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          height: 80,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width/3+120,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              GestureDetector(
                                                child: Column(
                                                  children: [
                                                    Icon(
                                                        LineAwesomeIcons.smile_o,
                                                        size: 55.0,
                                                        color: Colors.green),
                                                        Text("Great",style: TextStyle(
                                                      color: Colors.green,fontWeight: FontWeight.w500
                                                    ),)
                                                  ],
                                                ),
                                              ),
                                              GestureDetector(
                                                child: Column(
                                                  children: [
                                                    Icon(
                                                        LineAwesomeIcons.meh_o,
                                                        size: 55.0,
                                                        color: Colors.orange[500]),
                                                        Text("Need Help",style: TextStyle(
                                                      color: Colors.orange[500],fontWeight: FontWeight.w500
                                                    ),)
                                                  ],
                                                ),
                                              ),
                                              GestureDetector(
                                                child: Column(
                                                  children: [
                                                    Icon(
                                                        LineAwesomeIcons.frown_o,
                                                        size: 55.0,
                                                        color: Colors.red[700]),
                                                    Text("frustrated",style: TextStyle(
                                                      color: Colors.red[700],fontWeight: FontWeight.w500
                                                    ),)
                                                  ],
                                                ),
                                              ),
                                          decoration: BoxDecoration(
                                              color: Colors.grey[700].withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        )
                                      ],
                                    )),
                              ),
                            ),
                          ),
                        );
                      },
                    );
