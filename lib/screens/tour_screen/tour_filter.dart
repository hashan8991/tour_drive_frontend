// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tour_drive_frontend/screens/tour_screen/tour_home_screen.dart';
import 'package:tour_drive_frontend/widgets/default_button.dart';
import '../../constants.dart';

class TourFilter extends StatefulWidget {
  const TourFilter({super.key});

  @override
  State<TourFilter> createState() => _TourFilterState();
}

class _TourFilterState extends State<TourFilter> {

  List<String> catergories = [];
  List<int> reviewScore = [];
  int _minPrice = 0;
  int _maxPrice = 500 ;
  
  final List<String> _catergoryOptions = ['city', 'hiking', 'adventure', 'historical', 'cultural'];
  final List<bool> _categorySelected = [false, false, false, false, false];
  final List<String> _reviewScore = ['⭐⭐⭐⭐⭐', '⭐⭐⭐⭐', '⭐⭐⭐', '⭐⭐', '⭐'];
  final List<bool> _reviewSelected = [false, false, false, false, false];

  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.01,),
                Row(
                  children: [
                    TextButton(onPressed: () {
                      Navigator.pop(context,MaterialPageRoute(builder: (context) => const TourHomeScreen()));
                    }, child: Text("❌", style: TextStyle(fontSize: screenHeight * 0.02, fontWeight: FontWeight.bold),),),
                    SizedBox(width: screenWidth * 0.14,),
                    Text("Catergories", style: TextStyle(fontSize: screenHeight * 0.025, fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: screenHeight * 0.01,),

                Column(
                children: _catergoryOptions.map((option) {
                  int index = _catergoryOptions.indexOf(option);
                  return CheckboxListTile(
                    visualDensity:  const VisualDensity(horizontal: -4, vertical: -4),
                    title: Text(option),
                    activeColor: kPrimaryColor,
                    value: _categorySelected[index],
                    onChanged: (value) {
                      setState(() {
                        _categorySelected[index] = value!;
                        if(value){
                          catergories.add(option);
                        } else {
                          catergories.remove(option);
                        }
                      });
                    },
                  );
                }).toList(),
                ),

                SizedBox(height: screenHeight * 0.02,),
                // Text("Reviews Score", style: TextStyle(fontSize: screenHeight * 0.025, fontWeight: FontWeight.bold)),
                // SizedBox(height: screenHeight * 0.01,),

                // Column(
                //   children: _reviewScore.map((option) {
                //     int index = _reviewScore.indexOf(option);

                //     return CheckboxListTile(
                //       title: Text(option),
                //       visualDensity:  const VisualDensity(horizontal: -4, vertical: -4),
                //       activeColor: kPrimaryColor,
                //       value: _reviewSelected[index],
                //       onChanged: (value) {
                //         setState(() {
                //           _reviewSelected[index] = value!;
                //           if(value){
                //           reviewScore.add((option.length.toInt()));
                //           //print(option);
                //         } else {
                //           reviewScore.remove((option.length.toInt()));
                //         }
                //         });
                //       },
                //     );
                //   }).toList(),
                // ),

                SizedBox(height: screenHeight * 0.02,),
                Text("Filter Price", style: TextStyle(fontSize: screenHeight * 0.025, fontWeight: FontWeight.bold)),
                SizedBox(height: screenHeight * 0.01,),
                
                RangeSlider(
                  values: RangeValues(_minPrice.toDouble(), _maxPrice.toDouble()),
                  min: 0,
                  max: 2000,
                  divisions: 10,
                  activeColor: kPrimaryColor,
                  labels: RangeLabels(_minPrice.toString(), _maxPrice.toString()),
                  onChanged: (values) {
                    setState(() {
                      _minPrice = values.start.toInt();
                      _maxPrice = values.end.toInt();
                     
                    });
                  },
                ),

                SizedBox(height: screenHeight * 0.04,),
                SizedBox(
                  width: screenWidth * 0.5,
                  child: DefaultButton(text: "Filter", press: () async{
                    // save filter values
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setStringList('tourCatergories', catergories);

                    String jsonString = json.encode(reviewScore);
                    await prefs.setString('tourReviewScore', jsonString);

                    await prefs.setInt('tourMinPrice', _minPrice);
                    await prefs.setInt('tourMaxPrice', _maxPrice);
 
                    // ignore: prefer_const_constructors
                    Navigator.push(context,MaterialPageRoute(builder: (context) => TourHomeScreen()));
                  }),
                ),
            ]),
          ),
        ),
      ),
    );
  }
}