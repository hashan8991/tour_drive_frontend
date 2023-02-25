import 'package:flutter/material.dart';
import 'package:tour_drive_frontend/constants.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final VoidCallback press;

  const DefaultButton({
    Key? key,
 
    required this.text, 
    required this.press, 
  }) : super(key: key);

 
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: screenHeight * 0.07,
      width: screenWidth,
      child: ElevatedButton(
        onPressed: press,
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(screenHeight * 0.02),
          ),
        ),
        child: Text(text, style: TextStyle(fontSize: screenHeight * 0.022, color: Colors.white),),
      ),
    );
  }
}