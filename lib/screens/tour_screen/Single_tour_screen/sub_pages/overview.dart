import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:readmore/readmore.dart';
import 'package:tour_drive_frontend/constants.dart';
import 'package:tour_drive_frontend/screens/tour_screen/single_tour_screen/single_tour_screen.dart';
import 'package:tour_drive_frontend/widgets/header.dart';

class OverviewScreen extends StatefulWidget {
  final String tourDescription;
  const OverviewScreen({super.key, required this.tourDescription});

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
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
              Header(text: "Overview", press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SingleTourScreen()));
              } ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: <Widget>[
                      
                      SizedBox(height: screenHeight * 0.02,),
                      Text(widget.tourDescription, style: TextStyle(fontSize: screenHeight * 0.02,)),
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