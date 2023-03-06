import 'package:flutter/material.dart';
import 'package:tour_drive_frontend/screens/tour_home_screen/tour_home_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  List pages = [
    // HomePage(),
    // ExplorePage(),
    // DrivePage(),
    // ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent, //title eka center krnne meken
          title: Image.asset(
            'assets/images/logoPic.png',
            fit: BoxFit.fill,
            height: screenHeight * 0.04,
            width: screenWidth * 0.6,
          ),
        ),
        body: Container(
          margin: EdgeInsets.all(screenWidth * 0.04),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: screenHeight * 0.1),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(screenWidth * 0.04),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: screenWidth * 0.02,
                        blurRadius: screenWidth * 0.04,
                        offset: const Offset(10, 13),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(screenWidth * 0.04),
                      child: Image.asset('assets/images/drivePic3.png')),
                ),
                SizedBox(height: screenHeight * 0.05),
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(screenWidth * 0.04),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: screenWidth * 0.02,
                          blurRadius: screenWidth * 0.04,
                          offset: const Offset(10, 13),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(screenWidth * 0.04),
                      child: Image.asset('assets/images/tourPic2.png'),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TourHomeScreen()));
                  },
                ),
              ],
            ),
          ),
        ),
        // bottomNavigationBar: BottomNavigationBar(items: items),
      ),
    );
  }
}
