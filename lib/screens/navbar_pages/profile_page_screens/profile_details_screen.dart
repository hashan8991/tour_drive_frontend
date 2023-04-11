import 'package:flutter/material.dart';
import 'package:tour_drive_frontend/screens/navbar_pages/profile_page_screens/profile_page_edit.dart';
// import 'package:proftest1/components/list_tile2.dart';

import '../../../constants.dart';
import '../../../widgets/list_tiles2.dart';
// import '../constants.dart';

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({super.key});

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(color: kPrimaryColor),
          backgroundColor: const Color.fromARGB(0, 255, 255, 255),
          // shadowColor: const Color.fromARGB(0, 37, 97, 107),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
                Icons.arrow_back_ios), //replace with our own icon data.
          ),
          title: const Text(
            'My Account',
            textAlign: TextAlign.center,
            style: TextStyle(color: kPrimaryColor),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditProfile(),
                    ),
                  );
                },
                icon: const Icon(Icons.edit))
          ],
        ),
        body: Container(
          margin: EdgeInsets.all(screenWidth * 0.05),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: screenWidth * 0.05,
                    ),
                    Container(
                      height: screenHeight * 0.12,
                      width: screenWidth * 0.3,
                      color: const Color.fromARGB(0, 0, 97, 3),
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: screenWidth * 0.1,
                            backgroundColor: kTextColor,
                            backgroundImage:
                                const AssetImage('assets/images/avatar2.png'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Column(
                  children: const [
                    MyListTile2(
                        iconLeading: Icons.perm_identity,
                        title: 'Udaya Anushanka'),
                    Divider(),
                    MyListTile2(
                        iconLeading: Icons.email,
                        title: 'beligahamullage@gmail.com'),
                    Divider(),
                    MyListTile2(iconLeading: Icons.call, title: '0775632256'),
                    Divider(),
                    MyListTile2(
                        iconLeading: Icons.person_pin,
                        title:
                            'No.136, Mulana, Narawala, Poddala, Galle, Sri Lanka'),
                    Divider(),
                    MyListTile2(
                        iconLeading: Icons.fingerprint_rounded,
                        title: '970671870v'),
                    Divider(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
