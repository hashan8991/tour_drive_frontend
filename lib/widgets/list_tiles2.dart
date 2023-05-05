import 'package:flutter/material.dart';
import 'package:tour_drive_frontend/constants.dart';

class MyListTile2 extends StatelessWidget {
  final IconData iconLeading;
  final String title;
  // final IconData iconTail;
  // final VoidCallback press;

  const MyListTile2({
    Key? key,
    required this.iconLeading,
    required this.title,
    // required this.iconTail,
    // required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(iconLeading),
      title: Text(
        title,
        style: const TextStyle(color: kTextColor),
      ),
      // trailing: Icon(iconTail),
      // onTap: press,
    );
  }
}
