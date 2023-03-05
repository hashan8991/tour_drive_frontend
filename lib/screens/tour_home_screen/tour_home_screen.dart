import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tour_drive_frontend/constants.dart';

class TourHomeScreen extends StatefulWidget {
  const TourHomeScreen({super.key});

  @override
  State<TourHomeScreen> createState() => _TourHomeScreenState();
}

class _TourHomeScreenState extends State<TourHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.all(
              screenWidth * 0.05), // common code section for all codes
          child: SingleChildScrollView(
            child: Stack(children: [
              Column(
                children: <Widget>[
                  SizedBox(height: screenHeight * 0.04),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Container(
                          height: screenHeight * 0.22,
                          width: screenWidth,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                                BorderRadius.circular(screenWidth * 0.03),
                          ),
                          child: Container(
                            margin: EdgeInsets.all(screenWidth * 0.025),
                            child: Row(
                              children: [
                                Container(
                                  //margin: EdgeInsets.all(screenWidth * 0.000000001),
                                  height: screenHeight * 0.3,
                                  width: screenWidth * 0.38,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(
                                        screenWidth * 0.03),
                                  ),
                                ),
                                SizedBox(
                                  width: screenWidth * 0.03,
                                ),
                                Container(
                                  height: screenHeight * 0.3,
                                  width: screenWidth * 0.44,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(
                                        screenWidth * 0.03),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        Container(
                          height: screenHeight * 0.22,
                          width: screenWidth,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                                BorderRadius.circular(screenWidth * 0.03),
                          ),
                          child: Container(
                            margin: EdgeInsets.all(screenWidth * 0.025),
                            child: Row(
                              children: [
                                Container(
                                  //margin: EdgeInsets.all(screenWidth * 0.000000001),
                                  height: screenHeight * 0.3,
                                  width: screenWidth * 0.42,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(
                                        screenWidth * 0.03),
                                  ),
                                ),
                                SizedBox(
                                  width: screenWidth * 0.03,
                                ),
                                Container(
                                  height: screenHeight * 0.3,
                                  width: screenWidth * 0.48,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(
                                        screenWidth * 0.03),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Container(
                          height: screenHeight * 0.22,
                          width: screenWidth,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                                BorderRadius.circular(screenWidth * 0.03),
                          ),
                          child: Container(
                            margin: EdgeInsets.all(screenWidth * 0.025),
                            child: Row(
                              children: [
                                Container(
                                  //margin: EdgeInsets.all(screenWidth * 0.000000001),
                                  height: screenHeight * 0.3,
                                  width: screenWidth * 0.42,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(
                                        screenWidth * 0.03),
                                  ),
                                ),
                                SizedBox(
                                  width: screenWidth * 0.03,
                                ),
                                Container(
                                  height: screenHeight * 0.3,
                                  width: screenWidth * 0.48,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(
                                        screenWidth * 0.03),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Container(
                          height: screenHeight * 0.22,
                          width: screenWidth,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                                BorderRadius.circular(screenWidth * 0.03),
                          ),
                          child: Container(
                            margin: EdgeInsets.all(screenWidth * 0.025),
                            child: Row(
                              children: [
                                Container(
                                  //margin: EdgeInsets.all(screenWidth * 0.000000001),
                                  height: screenHeight * 0.3,
                                  width: screenWidth * 0.42,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(
                                        screenWidth * 0.03),
                                  ),
                                ),
                                SizedBox(
                                  width: screenWidth * 0.03,
                                ),
                                Container(
                                  height: screenHeight * 0.3,
                                  width: screenWidth * 0.48,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(
                                        screenWidth * 0.03),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Container(
                          height: screenHeight * 0.22,
                          width: screenWidth,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                                BorderRadius.circular(screenWidth * 0.03),
                          ),
                          child: Container(
                            margin: EdgeInsets.all(screenWidth * 0.025),
                            child: Row(
                              children: [
                                Container(
                                  //margin: EdgeInsets.all(screenWidth * 0.000000001),
                                  height: screenHeight * 0.3,
                                  width: screenWidth * 0.42,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(
                                        screenWidth * 0.03),
                                  ),
                                ),
                                SizedBox(
                                  width: screenWidth * 0.03,
                                ),
                                Container(
                                  height: screenHeight * 0.3,
                                  width: screenWidth * 0.48,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(
                                        screenWidth * 0.03),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        Container(
                          height: screenHeight * 0.22,
                          width: screenWidth,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                                BorderRadius.circular(screenWidth * 0.03),
                          ),
                          child: Container(
                            margin: EdgeInsets.all(screenWidth * 0.025),
                            child: Row(
                              children: [
                                Container(
                                  //margin: EdgeInsets.all(screenWidth * 0.000000001),
                                  height: screenHeight * 0.3,
                                  width: screenWidth * 0.42,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(
                                        screenWidth * 0.03),
                                  ),
                                ),
                                SizedBox(
                                  width: screenWidth * 0.03,
                                ),
                                Container(
                                  height: screenHeight * 0.3,
                                  width: screenWidth * 0.48,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(
                                        screenWidth * 0.03),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_back,
                        )),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.search,
                            )),
                        IconButton(
                          onPressed: () {},
                          icon: const FaIcon(
                            FontAwesomeIcons.filter,
                            size: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Top Experinces On TourDrive",
                      style: TextStyle(
                          fontSize: screenHeight * 0.03,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ]),
            ]),
          ),
        ),
      ),
    );
  }
}
