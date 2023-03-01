import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
     
    required this.text, 
    required this.press,
  }) : super(key: key);

  
  final String text;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    //final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Row(
      children: [
        IconButton(onPressed: press, icon: const Icon(Icons.arrow_back, )),
        Text(text, style: TextStyle(fontSize: screenHeight*0.03, fontWeight: FontWeight.bold),),
      ],
    );
  }
}
