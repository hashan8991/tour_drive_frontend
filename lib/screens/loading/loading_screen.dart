import "package:flutter/material.dart";
import 'package:tour_drive_frontend/screens/sign_in/login_screen.dart';
import 'package:tour_drive_frontend/widgets/default_button.dart';


class LoadingScreen extends StatelessWidget {

  static String routeName = "/loading";
  const LoadingScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    
     final double screenWidth = MediaQuery.of(context).size.width;
     final double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.all(screenWidth * 0.01),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: screenWidth,
                  height: screenHeight * 0.3,
                  child: Image.asset('assets/images/logo.png')
                ),
                SizedBox(
                  width: screenWidth,
                  height: screenHeight * 0.3,
                  child: Image.asset('assets/images/cover.png')
                  ),
                SizedBox(height: screenHeight * 0.1),
                SizedBox(
                  width: screenWidth *0.5,
                  child: DefaultButton(text: "Get Started", press: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LogInScreen()));
                  })
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


