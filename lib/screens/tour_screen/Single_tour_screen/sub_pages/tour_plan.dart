import 'package:flutter/material.dart';
import 'package:tour_drive_frontend/constants.dart';
import 'package:tour_drive_frontend/screens/tour_screen/Single_tour_screen/single_tour_screen.dart';
import 'package:tour_drive_frontend/widgets/header.dart';

class TourPlanScreen extends StatefulWidget {
  const TourPlanScreen({super.key});

  @override
  State<TourPlanScreen> createState() => _TourPlanScreenState();
}

class _TourPlanScreenState extends State<TourPlanScreen> {
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
              Header(text: "Tour Plan", press: () {
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
        
        
                      Row(
                        children: [
                          Container(
                            width: screenWidth * 0.3,
                            height: screenHeight * 0.035,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: kPrimaryColor,
                                width: 5.0,
                                style: BorderStyle.solid
                              ),
                              borderRadius: BorderRadius.circular(15),
                              color: kPrimaryColor,
                            ),
                            child: const Center (
                              child: Text('Day 1', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.02,),
                          SizedBox(width: screenWidth * 0.55,child: Text(' -  Departure',maxLines: 2,style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenHeight * 0.022),)),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02,),
                      Text("🔰 Pretium vitae tempus sem enim enim.Tempus, leo, taciti augue aliquam hendrerit."),
                      SizedBox(height: screenHeight * 0.01,),
                      Text("🔰 Pretium vitae tempus sem enim enim.Tempus, leo, taciti augue aliquam hendrerit."),
                     
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