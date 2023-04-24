import 'package:flutter/material.dart';
import 'package:tour_drive_frontend/screens/tour_screen/single_tour_screen/single_tour_screen.dart';
import 'package:tour_drive_frontend/widgets/header.dart';

class IncludeExcludeScreen extends StatefulWidget {
  final String tourIncludes;
  final String tourExcludes;
  const IncludeExcludeScreen({super.key,required this.tourIncludes,required this.tourExcludes});

  @override
  State<IncludeExcludeScreen> createState() => _IncludeExcludeScreenState();
}

class _IncludeExcludeScreenState extends State<IncludeExcludeScreen> {
  List<String> tourIncludesList = [];
  List<String> tourExcludesList = [];

  @override
  void initState()  {
    super.initState();
    tourIncludesList =  widget.tourIncludes.split('\n');
    tourExcludesList =  widget.tourExcludes.split('\n');
  }
  
  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight= MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(text: "Included/Excluded", press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SingleTourScreen()));
              } ),
              SizedBox(height: screenHeight * 0.02,),
              Text("    What's Included", style: TextStyle(fontSize: screenHeight * 0.022,fontWeight: FontWeight.bold),),
              SizedBox(height: screenHeight * 0.02,),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: tourIncludesList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return 
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(title: Text("⭕ ${tourIncludesList[index]}", style: TextStyle(fontSize: screenHeight * 0.02))),
                          SizedBox(height: screenHeight * 0.02,)
                        ],
                      );
                  }
                  ),
              ),
              SizedBox(height: screenHeight * 0.035,),
              Text("    What's Excluded", style: TextStyle(fontSize: screenHeight * 0.022,fontWeight: FontWeight.bold),),
              SizedBox(height: screenHeight * 0.02,),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: tourExcludesList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return 
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(title: Text("⭕ ${tourExcludesList[index]}", style: TextStyle(fontSize: screenHeight * 0.02))),
                          SizedBox(height: screenHeight * 0.02,)
                        ],
                      );
                  }
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}