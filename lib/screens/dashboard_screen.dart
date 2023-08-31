import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:login_app/components/home_screen_components.dart';
import 'package:modern_form_line_awesome_icons/modern_form_line_awesome_icons.dart';

import 'login_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  static String id = 'welcome_screen';

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  int index = 0;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //leading: IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_back_ios_new),),
        centerTitle: true,
        title: Text(
          'Profile',
        ),
        actions: [
          // SizedBox(
          //   width: 100,
          //   child: MaterialButton(
          //     onPressed: () {
          //
          //     },
          //     color: Colors.blueAccent,
          //     child: Text('SIGN OUT'),
          //   ),
          // ),
          IconButton(onPressed: (){
            FirebaseAuth.instance.signOut();
            Navigator.pushNamed(context, LoginScreen.id);
          }, icon: Icon(Icons.logout,color: Colors.black,size: 25,))
        ],
        backgroundColor: Get.isDarkMode ? Colors.grey[700] : Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: FadeInImage(
                  image: NetworkImage(
                      "https://ik.imagekit.io/altajfood/ar_asset/5184638_2669812.jpg"),
                  placeholder: const AssetImage("assets/images/welcome.png"),
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset('assets/images/welcome.png',
                        fit: BoxFit.fitWidth);
                  },
                  fit: BoxFit.fitWidth,
                ),
              ),
              const SizedBox(height: 50),
              Text(user.email!,style: TextStyle(fontSize: 20),),
              Text(user.displayName!,style: TextStyle(fontSize: 20),),
               GridViewComponwnt(),
               HorizontalListViewComponwnt(),
               VerticalListViewComponwnt()

            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: "Order"),
          BottomNavigationBarItem(
            icon: Icon(Icons.face),
            label: "Profile",
          )
        ],
        currentIndex: index,
        onTap: (int i) {
          setState(() {
            index = i;
          });
        },
        fixedColor: Colors.white,
      ),
    );
  }
}
