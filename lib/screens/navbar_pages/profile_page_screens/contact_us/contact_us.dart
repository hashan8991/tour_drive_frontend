import 'package:flutter/material.dart';
import 'package:tour_drive_frontend/constants.dart';
import 'package:tour_drive_frontend/widgets/list_tile_phone_call.dart';
import 'package:tour_drive_frontend/widgets/list_tiles2.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: const Color.fromARGB(0, 255, 255, 255),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
                Icons.arrow_back_ios), //replace with our own icon data.
          ),
          iconTheme: const IconThemeData(color: kPrimaryColor),
          title: const Text(
            "Contact Us",
            style: TextStyle(color: kPrimaryColor),
          ),
        ),
        body: Container(
          margin: EdgeInsets.all(screenWidth * 0.05),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(screenWidth * 0.09),
                  child: Image.asset('assets/images/logoPic.png'),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Column(
                  children: [
                    const Text(
                      'Contact Info',
                      style: TextStyle(color: kTextColor, fontSize: 20),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(screenWidth * 0.05),
                          color: Colors.white,
                          border: Border.all(
                            color: kSecondaryColor,
                            // color: Colors.transparent,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: kSecondaryColor,
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset:
                                  Offset(3, 5), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: const [
                            MyListTile2(
                              iconLeading: Icons.location_on_outlined,
                              title:
                                  'No.455, West Orchard Street, Kings Mountain, NC 280876',
                            ),
                            Divider(),
                            // MyListTile2(
                            //   iconLeading: Icons.phone_in_talk_outlined,
                            //   title: '+088(006)992-99-10',
                            // ),
                            PhoneCallListTile(
                              iconLeading: Icons.phone_in_talk_outlined,
                              title:
                                  '+088(006)992-99-10', // add this phone number to the definition of this list_tile
                            ),
                            Divider(),
                            MyListTile2(
                                iconLeading: Icons.email_outlined,
                                title: 'tourdrive.info@gmail.com')
                          ],
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
