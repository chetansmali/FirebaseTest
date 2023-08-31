import 'package:flutter/material.dart';
import 'package:login_app/screens/login_screen.dart';
import 'package:login_app/screens/order_screen.dart';
import 'package:login_app/screens/profile_screen.dart';
import 'package:login_app/screens/signup_screen.dart';
import 'package:login_app/screens/dashboard_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: const TextTheme(
        bodyMedium: TextStyle(
          fontFamily: 'Ubuntu',
        ),
      )),
      initialRoute:   LoginScreen.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        DashboardScreen.id: (context) => DashboardScreen(),
        OrderPage.id: (context) => OrderPage(),
        ProfilePage.id: (context) => ProfilePage(),

      },
    );
  }
}
