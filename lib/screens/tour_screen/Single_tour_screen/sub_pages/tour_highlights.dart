import 'package:flutter/material.dart';
import 'package:tour_drive_frontend/screens/tour_screen/single_tour_screen/single_tour_screen.dart';
import 'package:tour_drive_frontend/widgets/header.dart';

class TourhighlightScreen extends StatefulWidget {
  final String tourHighlights;
  const TourhighlightScreen({super.key, required this.tourHighlights});

  @override
  State<TourhighlightScreen> createState() => _TourhighlightScreenState();
}

class _TourhighlightScreenState extends State<TourhighlightScreen> {
  List<String> tourHighlightList = [];

  @override
  void initState()  {
    super.initState();
    tourHighlightList =  widget.tourHighlights.split('\n');
  }

  @override
  Widget build(BuildContext context) {

    //final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight= MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(text: "Tour Highlights", press: () {
              Navigator.pop(context, MaterialPageRoute(builder: (context) => const SingleTourScreen()));
            } ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: tourHighlightList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text("🔰 ${tourHighlightList[index]}", style: TextStyle(fontSize: screenHeight * 0.02)),
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