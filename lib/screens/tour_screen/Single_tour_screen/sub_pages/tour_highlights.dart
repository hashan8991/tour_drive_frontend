import 'package:flutter/material.dart';
import 'package:tour_drive_frontend/screens/tour_screen/single_tour_screen/single_tour_screen.dart';
import 'package:tour_drive_frontend/widgets/header.dart';

class TourhighlightScreen extends StatefulWidget {
  const TourhighlightScreen({super.key});

  @override
  State<TourhighlightScreen> createState() => _TourhighlightScreenState();
}

class _TourhighlightScreenState extends State<TourhighlightScreen> {
  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight= MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(text: "Tour Highlights", press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SingleTourScreen()));
              } ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      
                      SizedBox(height: screenHeight * 0.02,),
                      Text("🔰  Be enveloped in the beauty of towering trees, remote beaches, and mountains of the Canadian wilderness"),
                      SizedBox(height: screenHeight * 0.02,),
                      Text("🔰  Be enveloped in the beauty of towering trees, remote beaches, and mountains of the Canadian wilderness"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}