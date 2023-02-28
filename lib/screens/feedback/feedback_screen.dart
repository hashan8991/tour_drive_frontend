import "package:flutter/material.dart";
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tour_drive_frontend/screens/loading/loading_screen.dart';
import 'package:tour_drive_frontend/screens/sign_in/login_screen.dart';
import 'package:tour_drive_frontend/widgets/default_button.dart';
import 'package:tour_drive_frontend/widgets/header.dart';

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({Key? key}) : super(key: key);

  @override
  State<FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {

  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _email = '';
  String _comment = '';
  double _rating = 0;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Send feedback data to backend or display it on the screen
      print('Feedback form submitted');
      print('Name: $_name');
      print('Email: $_email');
      print('Comment: $_comment');
      print('Rating: $_rating');
    }
  }
  @override
  Widget build(BuildContext context) {
    
     final double screenWidth = MediaQuery.of(context).size.width;
     final double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.all(screenWidth * 0.04),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                
              Header(text: "Create Review", press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoadingScreen()));
                } ),
              SizedBox(height: screenHeight *0.02,),
              Center(child: Text("Hey, Leave feedback about this",)),
              SizedBox(height: screenHeight *0.02,),
              Text(
                'Name',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onChanged: (value) {
                  _name = value;
                },
              ),
              SizedBox(height: 16.0),
              Text(
                'Email',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email address';
                  } else if (!value.contains('@')) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                onChanged: (value) {
                  _email = value;
                },
              ),
              SizedBox(height: 16.0),
              Text(
                'Comment',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                maxLines: null,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your comment';
                  }
                  return null;
                },
                onChanged: (value) {
                  _comment = value;
                },
              ),
              SizedBox(height: 18.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Location',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  RatingBar.builder(
                initialRating: _rating,
                minRating: 0,
                maxRating: 5,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                },
              ),
                ],
              ),
              SizedBox(height: screenHeight *0.03,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Service',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  RatingBar.builder(
                initialRating: _rating,
                minRating: 0,
                maxRating: 5,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                },
              ),
                ],
              ),
              SizedBox(height: screenHeight *0.03,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Price',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  RatingBar.builder(
                initialRating: _rating,
                minRating: 0,
                maxRating: 5,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                },
              ),
                ],
              ),
              
              SizedBox(height: screenHeight *0.1,),
                SizedBox(
                  width: screenWidth *0.5,
                  child: DefaultButton(text: "Submit Review", press: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LogInScreen()));
                  })
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}