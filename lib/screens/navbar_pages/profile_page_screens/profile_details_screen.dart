import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tour_drive_frontend/screens/navbar_main_page/navbar_main_page.dart';
import 'package:tour_drive_frontend/screens/navbar_pages/profile_page_screens/profile_page_edit.dart';
import 'package:tour_drive_frontend/screens/navbar_pages/profile_page_screens/profile_page_sreen.dart';
import 'package:tour_drive_frontend/widgets/default_button.dart';
import '../../../constants.dart';
import '../../../widgets/list_tiles2.dart';


class ProfileDetails extends StatefulWidget {
  const ProfileDetails({super.key});

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {

  String? name,email,country,passportID;
  int? mobileNum;
  bool isloading = true;
  
  void setDetails() async{

    final prefl = await SharedPreferences.getInstance();
    name = await prefl.getString('name');
    email = await prefl.getString('email');
    mobileNum = await prefl.getInt('mobile');
    country = await prefl.getString('country');
    passportID = await prefl.getString('passportID');

    setState(() {
      isloading = false;
    });
    
  }

  @override
  void initState() {
    super.initState();
    setDetails();
    
  }



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
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  const NavbarMainPage()));
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
                isloading 
                ? Center(
                    child:CircularProgressIndicator(
                      backgroundColor: Colors.grey[200], // Set the background color of the widget
                      valueColor: const AlwaysStoppedAnimation<Color>(kPrimaryColor), // Set the color of the progress indicator
                      strokeWidth: 3, // Set the width of the progress indicator
                    )
                  )
                :
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
                                const NetworkImage(kprofilePhoto),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Column(
                  children:  [
                    MyListTile2(
                        iconLeading: Icons.perm_identity,
                        title: '$name'),
                    const Divider(),
                    MyListTile2(
                        iconLeading: Icons.email,
                        title: '$email'),
                    const Divider(),
                    MyListTile2(iconLeading: Icons.call, title: '$mobileNum'),
                    const Divider(),
                    MyListTile2(
                        iconLeading: Icons.person_pin,
                        title:
                            '$country'),
                    const Divider(),
                    MyListTile2(
                        iconLeading: Icons.fingerprint_rounded,
                        title: '$passportID'),
                    const Divider(),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02,),
                SizedBox(
                  width: screenWidth * 0.3,
                  child: DefaultButton(text: "Edit", press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditProfile(),
                      ),
                    );
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
