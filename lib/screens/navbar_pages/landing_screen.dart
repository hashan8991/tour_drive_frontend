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
          centerTitle: false,
          backgroundColor: Colors.transparent, //title eka center krnne meken
          title: Image.asset(
            'assets/images/logoNew.png',
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
                Image.asset('assets/images/drive2.png'),
                SizedBox(height: screenHeight * 0.02),
                GestureDetector(
                  child: Image.asset('assets/images/tour2.png'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const TourHomeScreen()));
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
