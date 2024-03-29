import 'package:flutter/material.dart';

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
      title: Text(title),
      // trailing: Icon(iconTail),
      // onTap: press,
    );
  }
}
