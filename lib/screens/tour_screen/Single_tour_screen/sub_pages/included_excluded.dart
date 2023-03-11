import 'package:flutter/material.dart';
import 'package:tour_drive_frontend/screens/tour_screen/Single_tour_screen/single_tour_screen.dart';
import 'package:tour_drive_frontend/widgets/header.dart';

class IncludeExcludeScreen extends StatefulWidget {
  const IncludeExcludeScreen({super.key});

  @override
  State<IncludeExcludeScreen> createState() => _IncludeExcludeScreenState();
}

class _IncludeExcludeScreenState extends State<IncludeExcludeScreen> {
  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight= MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Header(text: "Included/Excluded", press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SingleTourScreen()));
                } ),

                SizedBox(height: screenHeight * 0.02,),
                Text("What's Included", style: TextStyle(fontSize: screenHeight * 0.022,fontWeight: FontWeight.bold),),
                SizedBox(height: screenHeight * 0.02,),
                Text("⭕  Specialized bilingual guide"),
                SizedBox(height: screenHeight * 0.01,),
                Text("⭕  Specialized bilingual guide"),


                
                SizedBox(height: screenHeight * 0.035,),
                Text("What's Excluded", style: TextStyle(fontSize: screenHeight * 0.022,fontWeight: FontWeight.bold),),
                SizedBox(height: screenHeight * 0.02,),
                Text("❌  Departure Taxese"),
                SizedBox(height: screenHeight * 0.01,),
                Text("❌  Departure Taxese"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}