import 'package:flutter/material.dart';

class DividerContainer extends StatelessWidget {
  final String text;
  final VoidCallback press;
  const DividerContainer({
    Key? key,
     required this.text, required this.press,
  }) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: press,
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        child: Column(
          children:  [
            const Divider(thickness: 1.0),
            SizedBox(height: screenHeight * 0.02,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text( text, style: TextStyle(fontSize: screenHeight * 0.02,fontWeight: FontWeight.bold)),
                SizedBox(width: screenHeight * 0.02,),
                Icon(Icons.arrow_forward_ios, size: screenHeight * 0.021,),
              ],
            ),
            SizedBox(height: screenHeight * 0.02,),
          ],
        ),
      ),
    );
  }
}
