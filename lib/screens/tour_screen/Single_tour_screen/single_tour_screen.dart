import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:readmore/readmore.dart';
import 'package:tour_drive_frontend/screens/tour_screen/single_tour_screen/sub_pages/tour_check_availability.dart';
import 'package:tour_drive_frontend/screens/tour_screen/single_tour_screen/sub_pages/included_excluded.dart';
import 'package:tour_drive_frontend/screens/tour_screen/single_tour_screen/sub_pages/overview.dart';
import 'package:tour_drive_frontend/screens/tour_screen/single_tour_screen/sub_pages/tour_highlights.dart';
import 'package:tour_drive_frontend/screens/tour_screen/single_tour_screen/sub_pages/tour_map.dart';
import 'package:tour_drive_frontend/screens/tour_screen/single_tour_screen/sub_pages/tour_plan.dart';
import 'package:tour_drive_frontend/screens/tour_screen/tour_home_screen.dart';
import 'package:tour_drive_frontend/screens/tour_screen/single_tour_screen/sub_pages/tour_feedback_screen.dart';
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

       floatingActionButton: SizedBox(
        width: screenWidth * 0.4,
        height: screenHeight * 0.1,
         child: FittedBox(
           child: FloatingActionButton.extended(
              backgroundColor: kPrimaryColor,
              foregroundColor: Colors.white,
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) =>const TourCheckAvailabilityScreen())); 
              },
              label: Text('Check availability'),
            ),
         ),
       ),
       
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
                      offset: const Offset(0, 3), // offset of the shadow
                    ),
                  ],
                ),
                height: screenHeight * 0.3,
                //color: Colors.white,
                //margin: EdgeInsets.all(screenWidth * 0.05),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Image.asset('assets/images/sigiriya.jpeg', fit: BoxFit.fill, height: screenHeight * 0.3, width: screenWidth * 0.7, ),
                    SizedBox(width: screenWidth * 0.04),
                    Image.network('https://media-cdn.tripadvisor.com/media/photo-s/1b/39/e3/9e/sigiriya-ancient-rock.jpg', fit: BoxFit.fill, height: screenHeight * 0.3, width: screenWidth * 0.7,),
                    SizedBox(width: screenWidth * 0.04),
                    Image.network('https://images.unsplash.com/photo-1612862862126-865765df2ded?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8c2lnaXJpeWElMjByb2NrfGVufDB8fDB8fA%3D%3D&w=1000&q=80', fit: BoxFit.fill, height: screenHeight * 0.3,width: screenWidth * 0.7, ),
                    
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
                  Text("2 Reviews")
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
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                           Text("Duration",style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenHeight * 0.017),),
                           Text("12 days", style: TextStyle( fontSize: screenHeight * 0.017),),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(width: screenWidth * 0.25,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                           Text("Max People",style: TextStyle(fontWeight: FontWeight.bold,fontSize: screenHeight * 0.017),),
                           Text("15", style: TextStyle( fontSize: screenHeight * 0.017) ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: screenHeight * 0.025),

                Row(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                           Text("Min Age",style: TextStyle(fontWeight: FontWeight.bold,fontSize: screenHeight * 0.017),),
                           Text("17+",style: TextStyle( fontSize: screenHeight * 0.017)),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(width: screenWidth * 0.25,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                           Text("Pick up",style: TextStyle(fontWeight: FontWeight.bold,fontSize: screenHeight * 0.017),),
                          SizedBox(width: screenWidth * 0.3,   child: Text("Air port ",maxLines: 4,style: TextStyle( fontSize: screenHeight * 0.017)),), 
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
                                const TourFeedbackForm()));
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
                      fontSize: screenHeight * 0.022,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
 //######################## Touroverview ...  #######################################################################################################               
                DividerContainer(text: "Overview", press: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context) =>const OverviewScreen()));
                }
                ),
                DividerContainer(text: "Tour Highlights", press: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context) =>const TourhighlightScreen()));
                }),
                DividerContainer(text: "Included / Excluded", press: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context) =>const IncludeExcludeScreen()));
                }),
                DividerContainer(text: "Tour Plan", press: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context) =>const TourPlanScreen()));
                }),
                const Divider(thickness: 1.0),
  //#####################################      Tour Map   ##################################################################################        
                SizedBox(height: screenHeight * 0.012),
                Text( "Tour Map", style: TextStyle(fontSize: screenHeight * 0.025,fontWeight: FontWeight.bold)),
                SizedBox(height: screenHeight * 0.023),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context) =>const TourMapScreen()));
                  },
                  child: Image.asset('assets/images/map.jpeg', fit: BoxFit.fill, height: screenHeight * 0.15, width: screenWidth,)
                ),
                SizedBox(height: screenHeight * 0.023),
                const Divider(thickness: 1.0),
                SizedBox(height: screenHeight * 0.016),
                Text( "Reviews", style: TextStyle(fontSize: screenHeight * 0.025,fontWeight: FontWeight.bold)),
                SizedBox(height: screenHeight * 0.02),
      //#####################################      Tour Review   ##################################################################################                    
                Row(
                  children: [
                    RatingBarIndicator(
                      rating: 2.75,
                      itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: kPrimaryColor,
                      ),
                      itemCount: 5,
                      itemSize: screenHeight * 0.03,
                      direction: Axis.horizontal,
                    ),
                    SizedBox(width: screenWidth * 0.05),
                    Text("2 reviews", style: TextStyle(fontSize: screenHeight * 0.022)),
                  ],
                ),
                 SizedBox(height: screenHeight * 0.02),
                Row(
                  children: [
                    Text("Location ", style: TextStyle(fontSize: screenHeight * 0.022)),
                    SizedBox(width: screenWidth * 0.02,),
                    LinearPercentIndicator(
                      width: screenWidth * 0.5,
                      barRadius: Radius.circular(screenHeight * 0.02),
                      animation: true,
                      lineHeight: screenHeight * 0.022,
                      animationDuration: 2500,
                      percent: 0.8,
                      center: Text("80.0%", style: TextStyle(fontSize: screenHeight * 0.015,color: Colors.white),),
                      progressColor: kPrimaryColor,
                    ),
                  ],
                ),
  //#####################################      Person revieew   ##################################################################################                    

                SizedBox(height: screenHeight * 0.02,),
                const Divider(thickness: 1.0),
                Container(
                  width: screenWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:NetworkImage('https://e7.pngegg.com/pngimages/799/987/png-clipart-computer-icons-avatar-icon-design-avatar-heroes-computer-wallpaper.png'),
                          ),
                          SizedBox(width: screenWidth * 0.05,),
                          Text("Name here", style: TextStyle(fontSize: screenHeight * 0.02,fontWeight: FontWeight.bold),),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.01,),
                      RatingBarIndicator(
                        rating: 2.75,
                        itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: kPrimaryColor,
                        ),
                        itemCount: 5,
                        itemSize: screenHeight * 0.03,
                        direction: Axis.horizontal,
                      ),
                      SizedBox(height: screenHeight * 0.01,),
                      ReadMoreText(
                        'Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.',
                        trimLines: 2,
                        colorClickableText: kPrimaryColor,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Read more',
                        trimExpandedText: "",
                        moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        //lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: screenHeight * 0.01,),
                      Row(
                        children: [
                          Icon(Icons.calendar_month_outlined, color: kPrimaryColor,),
                          SizedBox(width: screenWidth * 0.02),
                          Text("March 10, 2020"),
                      ],)
                    ],
                  ),
                ),

              ]
            ),
          ),
        ),
      ),
    );
  }
}


