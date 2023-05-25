import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tour_drive_frontend/constants.dart';
import 'package:tour_drive_frontend/screens/navbar_pages/drive_option_screen.dart';
import 'package:tour_drive_frontend/screens/navbar_pages/emergency_screen.dart';
import 'package:tour_drive_frontend/screens/navbar_pages/landing_screen.dart';
import 'package:tour_drive_frontend/screens/navbar_pages/profile_page_screens/profile_page_sreen.dart';
import 'package:tour_drive_frontend/screens/navbar_pages/tour_option_new.dart';
import 'package:tour_drive_frontend/screens/navbar_pages/tour_option_screen.dart';

class NavbarMainPage extends StatefulWidget {
  const NavbarMainPage({Key? key}) : super(key: key);

  @override
  State<NavbarMainPage> createState() => _NavbarMainPageState();
}

class _NavbarMainPageState extends State<NavbarMainPage> {
  List pages = [
    const LandingScreen(),
    //const TourOptionScreen(),
    const TourOptionNewScreen(),
    const EmergencyScreen(),
    const DriveOptionScreen(),
    const ProfileScreen(),
  ];

  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   centerTitle: false, //title eka center krnne meken
      //   // backgroundColor: Color(0xFFFFDBCF),// mee app bar eke colour eka
      //   // backgroundColor: Colors.transparent,
      //   backgroundColor: Color(0xFF695E2F),
      //   title: Image.asset(
      //     'assets/images/logo.png',
      //     fit: BoxFit.contain,
      //     height: MediaQuery.of(context).size.height * 0.2,
      //     width: MediaQuery.of(context).size.height * 0.25,
      //   ),
      //   toolbarHeight: MediaQuery.of(context).size.height * 0.1,
      // ),
      body: pages[
          currentIndex], //danata select wechcha ekee index eka meeken pennanne
      bottomNavigationBar: navBar_Widget(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     //action to perform when the button is pressed...
      //   },
      //   label: Text('Customize'),
      //   icon: Image.asset(
      //     // 'assets/images/customize.png',
      //     'assets/images/Vector.png',
      //     width: 24,
      //     height: 24,
      //   ),
      //   backgroundColor: Colors.amber, //floating button colors background
      //   foregroundColor: Colors.white, //floating button colors foreground
      // ),
    );
  }

  // ignore: non_constant_identifier_names
  BottomNavigationBar navBar_Widget() {
    return BottomNavigationBar(
      type: BottomNavigationBarType
          .fixed, //methana wenas klaa bottom nav bar ekt paatak daanna oona nisaa
      backgroundColor:
          Colors.white54, //methanin bottom nav bar color change krnna puluwan
      selectedFontSize: 12, //icon labels hide krnna oona nisai methana zero klee
      unselectedFontSize:
          12, //icon labels hide krnna oona nisai methana zero klee
      onTap:
          onTap, //buttons tap klata passe selection change wenna oona nisa mee onTap method eka hadala call klaa
      currentIndex:
          currentIndex, // default index value eka meka, methana nm zero wenna oona mn hithanne
      selectedItemColor: kPrimaryColor,
      unselectedItemColor: Colors.grey.withOpacity(0.5),
      showSelectedLabels: true, //selected icon labels hide kla
      showUnselectedLabels: true, //unselected icon labels hide kla
      elevation: 0,
      items: const [
        BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
        BottomNavigationBarItem(label: 'Tour', icon: Icon(Icons.explore)),
        BottomNavigationBarItem(label: 'Emergency', icon: Icon(FontAwesomeIcons.truckMedical)),
        BottomNavigationBarItem(label: 'Drive', icon: Icon(Icons.drive_eta)),
        BottomNavigationBarItem(label: 'Profile', icon: Icon(Icons.account_circle)),
      ],
    );
  }
}
