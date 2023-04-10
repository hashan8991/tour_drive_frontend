import 'package:flutter/material.dart';
import 'package:tour_drive_frontend/constants.dart';
import 'package:tour_drive_frontend/widgets/list_tiles1.dart';
// import 'package:profilepg_content/widgets/constants.dart';
// import 'package:profilepg_content/widgets/my_list_tile.dart';
// import 'package:tour_drive_frontend/constants.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

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
            "About Us",
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
                SizedBox(height: screenHeight * 0.02),
                const Text(
                  "Our Story",
                  style: TextStyle(fontSize: 20, color: kTextColor),
                ),
                SizedBox(height: screenHeight * 0.02),
                Container(
                  padding: EdgeInsets.all(screenWidth * 0.05),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    color: Colors.white,
                    border: Border.all(color: kSecondaryColor),
                    boxShadow: const [
                      BoxShadow(
                        color: kSecondaryColor,
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(3, 5), // changes position of shadow
                      ),
                    ],
                  ),
                  child: const Text(
                    "✪ Welcome to our travel and vehicle managing company. We offer seamless, stress-free travel experiences and specialize in providing transportation solutions tailored to your needs. Our experienced team can help you plan your itinerary and book all your reservations in advance. Sit back, relax, and let us take care of the details so you can enjoy your journey. Contact us to learn more.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: kTextColor),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                const Divider(),
                MyListTile(
                  iconLeading: Icons.tips_and_updates_outlined,
                  title: 'Travel Blog & Tips',
                  iconTail: Icons.navigate_next,
                  press: () {
                    showDialog(
                      barrierColor: const Color.fromARGB(100, 80, 132, 11),
                      context: context,
                      builder: (context) => AlertDialog(
                        icon: const Icon(
                          Icons.tips_and_updates_outlined,
                          color: kPrimaryColor,
                        ),
                        title: const Text(
                          'Travel Bolg & Tips',
                          style: TextStyle(color: kPrimaryColor),
                        ),
                        content: Container(
                          padding: EdgeInsets.all(screenWidth * 0.02),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(screenWidth * 0.02),
                            color: Colors.white,
                            border: Border.all(color: kSecondaryColor),
                          ),
                          child: const Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                            style: TextStyle(color: kTextColor),
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Ok'),
                          )
                        ],
                      ),
                    );
                  },
                ),
                const Divider(),
                MyListTile(
                  iconLeading: Icons.group_work_outlined,
                  title: 'Working With Us',
                  iconTail: Icons.navigate_next,
                  press: () {
                    showDialog(
                      barrierColor: const Color.fromARGB(100, 80, 132, 11),
                      context: context,
                      builder: (context) => AlertDialog(
                        icon: const Icon(
                          Icons.tips_and_updates_outlined,
                          color: kPrimaryColor,
                        ),
                        title: const Text(
                          'Working With Us',
                          style: TextStyle(color: kPrimaryColor),
                        ),
                        content: Container(
                          padding: EdgeInsets.all(screenWidth * 0.02),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(screenWidth * 0.02),
                            color: Colors.white,
                            border: Border.all(color: kSecondaryColor),
                          ),
                          child: const Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                            style: TextStyle(color: kTextColor),
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Ok'),
                          )
                        ],
                      ),
                    );
                  },
                ),
                const Divider(),
                MyListTile(
                  iconLeading: Icons.corporate_fare_outlined,
                  title: 'Be Our Partner',
                  iconTail: Icons.navigate_next,
                  press: () {
                    showDialog(
                      barrierColor: const Color.fromARGB(100, 80, 132, 11),
                      context: context,
                      builder: (context) => AlertDialog(
                        icon: const Icon(
                          Icons.tips_and_updates_outlined,
                          color: kPrimaryColor,
                        ),
                        title: const Text(
                          'Be Our Partner',
                          style: TextStyle(color: kPrimaryColor),
                        ),
                        content: Container(
                          padding: EdgeInsets.all(screenWidth * 0.02),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(screenWidth * 0.02),
                            color: Colors.white,
                            border: Border.all(color: kSecondaryColor),
                          ),
                          child: const Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                            style: TextStyle(color: kTextColor),
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Ok'),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
