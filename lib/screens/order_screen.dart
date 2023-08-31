import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});
  static String id = 'order_screen';


  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {

  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref("users/123");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          "Orders",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        )),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        color: Colors.black12,
        child: Center(
            child: TextButton(
          onPressed: () {},
          child: Text(
            'order now',
            style: TextStyle(color: Colors.black54, fontSize: 25),
          ),
        )),
      ),
    );
  }
}
