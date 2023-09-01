import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:login_app/components/ui_components.dart';
import 'package:login_app/screens/order_screen.dart';


class AddPage extends StatefulWidget {
  @override
  State<AddPage> createState() => AddPageState();
}

class AddPageState extends State<AddPage> {
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  DatabaseReference? dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('items');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add product',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              CustomTextfield(controller: name, hintText: 'Name'),
              SizedBox(
                height: 20,
              ),
              CustomTextfield(controller: price, hintText: 'Price'),
              SizedBox(
                height: 20,
              ),
              CustomButton(buttonText: 'Add', onPressed: (){
                if (name.text != null && price.text != null ) {
                  uploadFile();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }


  uploadFile() async {
    try {
        Map<String, String> items = {
          'name': name.text,
          'number': price.text,
        };

        dbRef!.push().set(items).whenComplete(() {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => Order_Page(),
            ),
          );
        });

    } on Exception catch (e) {
      print(e);
    }
  }
}
