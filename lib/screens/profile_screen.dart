import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  static String id = 'profile_screen';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
              "Profile",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        color: Colors.black12,
        child: Column(
          children: [
            Text('User profile Details',style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.black,
            ),),
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text('Name : ',style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black54,
              )),
                SizedBox(width: 10,),
                Text(user.displayName!,style: TextStyle(
                fontWeight: FontWeight.normal,
                    fontSize: 20,
                    color: Colors.black,
                )),
              ],
            ),
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Email : ',style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.black54,
                )),
                SizedBox(width: 10,),
                Text(user.email!,style: TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 20,
    color: Colors.black,
    )),
              ],
            ),
            SizedBox(height: 25,),
            ElevatedButton(onPressed: (){
            }, child: Text('Update')),
          ],
        )
      ),
    );
  }
}
