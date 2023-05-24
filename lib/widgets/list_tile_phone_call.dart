// create this widget and continue ..........................

// make this a pressable one
import 'package:flutter/material.dart';
import 'package:tour_drive_frontend/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class PhoneCallListTile extends StatefulWidget {
  final IconData iconLeading;
  final String title;
  // final IconData iconTail;
  // final VoidCallback press;

  const PhoneCallListTile({
    Key? key,
    required this.iconLeading,
    required this.title,
    // required this.iconTail,
    // required this.press,
  }) : super(key: key);

  @override
  State<PhoneCallListTile> createState() => _PhoneCallListTileState();
}

class _PhoneCallListTileState extends State<PhoneCallListTile> {
  bool _hasCallSupport = false;
  Future<void>? _launched;
  String _phone = '011 123 4567'; // add the relevant phone number here

  @override
  void initState() {
    super.initState();
    // Check for phone call support.
    canLaunchUrl(Uri(scheme: 'tel', path: '123')).then((bool result) {
      setState(() {
        _hasCallSupport = result;
      });
    });
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(widget.iconLeading),
      title: Text(
        widget.title,
        style: const TextStyle(
          color: kPrimaryColor,
          decoration: TextDecoration.underline,
        ),
      ),
      onTap: () {
        _launched = _makePhoneCall(_phone);
      },
      // trailing: Icon(iconTail),
      // onTap: press,
    );
  }
}
