import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:login_app/components/ui_components.dart';
import 'package:login_app/screens/order_screen.dart';


class UpdateRecord extends StatefulWidget {
  String Contact_Key;
  UpdateRecord({required this.Contact_Key});

  @override
  State<UpdateRecord> createState() => _UpdateRecordState();
}

class _UpdateRecordState extends State<UpdateRecord> {
  TextEditingController Uname = new TextEditingController();
  TextEditingController Uprice = new TextEditingController();
  DatabaseReference? db_Ref;

  @override
  void initState() {
    super.initState();
    db_Ref = FirebaseDatabase.instance.ref().child('items');
    Contactt_data();
  }

  void Contactt_data() async {
    DataSnapshot snapshot = await db_Ref!.child(widget.Contact_Key).get();

    Map Contact = snapshot.value as Map;

    setState(() {
      Uname.text = Contact['name'];
      Uprice.text = Contact['number'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Product'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              CustomTextfield(controller: Uname, hintText: 'Name'),
              SizedBox(
                height: 20,
              ),
              CustomTextfield(controller: Uprice, hintText: 'Name'),
              SizedBox(
                height: 20,
              ),
              CustomButton(buttonText: 'Add', onPressed: (){
                if (Uname.text != null && Uprice.text != null ) {
                  directupdate();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }


  directupdate() {
      Map<String, String> items = {
        'name': Uname.text,
        'number': Uprice.text,
      };

      db_Ref!.child(widget.Contact_Key).update(items).whenComplete(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => Order_Page(),
          ),
        );
      });

  }
}