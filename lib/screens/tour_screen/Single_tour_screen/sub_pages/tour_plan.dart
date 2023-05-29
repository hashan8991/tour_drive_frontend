import 'package:flutter/material.dart';
import 'package:tour_drive_frontend/constants.dart';
import 'package:tour_drive_frontend/screens/tour_screen/single_tour_screen/single_tour_screen.dart';
import 'package:tour_drive_frontend/widgets/header.dart';

class TourPlanScreen extends StatefulWidget {
  final List<String> tourPlan;
  const TourPlanScreen({super.key, required this.tourPlan});

  @override
  State<TourPlanScreen> createState() => _TourPlanScreenState();
}

class _TourPlanScreenState extends State<TourPlanScreen> {
  List<String>? tourPlan;
  

  @override
  void initState()  {
    super.initState();
    tourPlan = widget.tourPlan;
  }  
   
  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight= MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(text: "Tour Plan", press: () {
              Navigator.pop(context, MaterialPageRoute(builder: (context) => const SingleTourScreen()));
            } ),
            SizedBox(height: screenHeight * 0.01,),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: tourPlan!.length,
                itemBuilder: (BuildContext context, int index) {
                  List<String> splitList = tourPlan![index].split(',');
                  
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
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
                              child:  Center (
                                child: Text(splitList[0], style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.02,),
                            SizedBox(width: screenWidth * 0.55,child: Text("- ${splitList[1]}",maxLines: 2,style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenHeight * 0.022),)),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.01,),
                        Text("🔰 ${splitList[2]}"),
                        SizedBox(height: screenHeight * 0.02,),

                       
                      ],
                    ),
                  );
                }
              ),
          ),
          ],
        ),
      ),
    );
  }
}