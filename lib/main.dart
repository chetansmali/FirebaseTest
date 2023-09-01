import 'package:flutter/material.dart';
import 'package:login_app/screens/insert.dart';
import 'package:login_app/screens/login_screen.dart';
import 'package:login_app/screens/order_screen.dart';
import 'package:login_app/screens/profile_screen.dart';
import 'package:login_app/screens/signup_screen.dart';
import 'package:login_app/screens/dashboard_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:login_app/screens/update.dart';

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
        useMaterial3: true,
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
        Order_Page.id: (context) => Order_Page(),
        ProfilePage.id: (context) => ProfilePage(),
      },
    );
  }
}
