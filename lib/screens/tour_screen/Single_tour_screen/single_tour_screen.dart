import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tour_drive_frontend/screens/tour_screen/tour_home_screen.dart';
import 'package:tour_drive_frontend/screens/feedback/feedback_screen.dart';
import 'package:tour_drive_frontend/widgets/divider_container.dart';
import 'package:tour_drive_frontend/widgets/favorite_icon.dart';
import 'package:tour_drive_frontend/constants.dart';
import 'package:tour_drive_frontend/models/tour/tour_data.dart';

class SingleTourScreen extends StatefulWidget {
  const SingleTourScreen({super.key});

  @override
  State<SingleTourScreen> createState() => _SingleTourScreenState();
}

class _SingleTourScreenState extends State<SingleTourScreen> {

  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    Text buildRatingStars(double rating) {
      String stars = '';
      for (double i = 0; i < rating; i++) {
        stars += '⭐ ';
      }
      stars.trim();
      return Text(stars, style: TextStyle(fontSize: screenHeight * 0.015),);
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () { Navigator.push(context,MaterialPageRoute(builder: (context) =>const TourHomeScreen())); }, 
            icon: const Icon(Icons.arrow_back, color:Colors.black, )
            ),
          actions: <Widget>[
            IconButton(
              icon: const MyFavoriteIconWidget(),
              onPressed: () {},
              alignment: Alignment.centerLeft,
            ),
          ],
        ),

        body: Container(
          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(thickness: 1.0),
                Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15), // shadow color
                      spreadRadius: 1.0, // how wide the shadow is
                      blurRadius: 5.0, // how soft the shadow is
                      offset: Offset(0, 3), // offset of the shadow
                    ),
                  ],
                ),
                height: screenHeight * 0.3,
                //color: Colors.white,
                //margin: EdgeInsets.all(screenWidth * 0.05),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ClipRRect( 
                      borderRadius: BorderRadius.circular(screenWidth * 0.02),
                      child: Image.asset('assets/images/sigiriya.jpeg', fit: BoxFit.fill, height: screenHeight * 0.3, )
                    ),
                    SizedBox(width: screenWidth * 0.04),
                    ClipRRect( 
                      borderRadius: BorderRadius.circular(screenWidth * 0.02),
                      child: Image.asset('assets/images/sigiriya.jpeg', fit: BoxFit.fill, height: screenHeight * 0.3, )
                    ),
                  ]
                  ),
                ),
          
                SizedBox(height: screenHeight * 0.02),
          //######################## Tour name #######################################################################################################               
                Text("Wonder of Sigiriya", style: TextStyle(fontSize: screenHeight *0.03, fontWeight: FontWeight.bold)),
                SizedBox(height: screenHeight * 0.02),
          
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, color: kPrimaryColor, size: 15.0,),
                    SizedBox(width: screenWidth * 0.005),
          //######################## Tour location #######################################################################################################               
                    SizedBox(width: screenWidth * 0.85, child: Text("Central Province, Sri Lanka", style: TextStyle(fontSize: screenHeight * 0.017 ),maxLines: 2, overflow: TextOverflow.ellipsis),), 
                  ],
                ),
          //######################## Tour Reviews #######################################################################################################               
                SizedBox(height: screenHeight * 0.02),
                Row(children: [
                  buildRatingStars(5),
                  SizedBox(width: screenWidth * 0.05,),
                  Text("2 reviews")
                ]
                ), 
                SizedBox(height: screenHeight * 0.025),
                Row(
                  children: [
                    const Icon(Icons.sell_outlined, color: kPrimaryColor, size: 20.0,),
                    SizedBox(width: screenWidth * 0.02),
          //######################## Tour Price #######################################################################################################               
                     Text("\$200", style: TextStyle(fontSize: screenHeight * 0.03, fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: screenHeight * 0.025),
          //######################## Tour sub details duration, max people, min age, pick up #######################################################################################################               
                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Column(
                          children: const[
                            Icon(Icons.date_range, color: kPrimaryColor,),
                          ],
                        ),
                        SizedBox(width: screenWidth * 0.015,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                           Text("Duration",style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenHeight * 0.015),),
                           Text("12 days", style: TextStyle( fontSize: screenHeight * 0.015),),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(width: screenWidth * 0.1,),
                    Row(
                      children: [
                        Column(
                          children: const [
                             Icon(Icons.group_outlined, color: kPrimaryColor,),
                          ],
                        ),
                        SizedBox(width: screenWidth * 0.015,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                           Text("Max People",style: TextStyle(fontWeight: FontWeight.bold,fontSize: screenHeight * 0.015),),
                           Text("5", style: TextStyle( fontSize: screenHeight * 0.015) ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.025),
                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start ,
                          children: const[
                            Icon(Icons.man_sharp, color: kPrimaryColor,),
                          ],
                        ),
                        SizedBox(width: screenWidth * 0.015,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                           Text("Min Age",style: TextStyle(fontWeight: FontWeight.bold,fontSize: screenHeight * 0.015),),
                           Text("17+",style: TextStyle( fontSize: screenHeight * 0.015)),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(width: screenWidth * 0.1,),
                    Row(
                      children: [
                        Column(
                          children: const [
                             Icon(Icons.location_on, color: kPrimaryColor,),
                          ],
                        ),
                        SizedBox(width: screenWidth * 0.015,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                           Text("Pick up",style: TextStyle(fontWeight: FontWeight.bold,fontSize: screenHeight * 0.015),),
                          SizedBox(height: 16.0,   child: Text("Air port",maxLines: 2,style: TextStyle( fontSize: screenHeight * 0.015)),), 
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
               SizedBox(height: screenHeight * 0.021),
                
               
          //######################## submit review  #######################################################################################################               
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const FeedbackForm()));
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: kPrimaryColor,
                      textStyle: const TextStyle(
                      decoration: TextDecoration.underline, // add underline style
                    ),
                    ),
                    child: Text(
                      'Submit Review',
                      style: TextStyle(
                        fontSize: screenHeight * 0.02,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                  DividerContainer(text: "Overeview", press: ()
                    {Navigator.push(context,MaterialPageRoute(builder: (context) =>const FeedbackForm()));}
                  ),
                  DividerContainer(text: "Tour Highlights", press: () {}),
                  DividerContainer(text: "Included/Excluded", press: () {}),
                  DividerContainer(text: "Tour Plan", press: () {}),
                  const Divider(thickness: 1.0),

              ]
            ),
          ),
        ),
      ),
    );
  }
}


