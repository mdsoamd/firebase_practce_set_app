import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_practce_set_app/screens/user_moden.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'homepage.dart';



class DataAddScreen extends StatefulWidget {
  // final userModel;
  const DataAddScreen({Key? key, }) : super(key: key);

  @override
  State<DataAddScreen> createState() => _DataAddScreenState();
}

class _DataAddScreenState extends State<DataAddScreen> {

  final nameCon = TextEditingController();
  final emailCon = TextEditingController();
  
  final ref = FirebaseDatabase.instance.ref("User");

  final firebase = FirebaseFirestore.instance.collection("Users");


  addData(){     // <-- FirebaseDatabase add data Method

      final id = DateTime.now().microsecondsSinceEpoch.toString();
      ref.child(id).set(
       { 'id':id,
        "Name":nameCon.text.toString(),
        'email':emailCon.text.toString()
        }
      ).then((value){
        print("Data Add");
        Navigator.popUntil(context, (route) => route.isFirst );
        Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => HomePage())));
      });
  }


 Uuid idd = Uuid();

DataAdd(){    // FirebaseFirestore add data Method
 final id = DateTime.now().microsecondsSinceEpoch.toString();
 NewModel add = NewModel(id: id, fullname: nameCon.text, email:emailCon.text,time: DateTime.now());
  firebase.doc(id).set(add.toMap()).then((value){
    print("data Add");
  });
}


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data add Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 20,),

            TextField(
              controller: nameCon,
              decoration: InputDecoration(
                hintText: 'Name'
              ),
            ),
            SizedBox(height: 20,),
            TextField(
              controller: emailCon,
              decoration: InputDecoration(
                hintText: 'Email'
              ),
            ),
             SizedBox(height: 20,),
             TextButton(onPressed: ()async{
              // addData();
              DataAdd();
              
 
             }, 
             child: Text("Add Data"),style: TextButton.styleFrom(backgroundColor: Colors.red,))
        ]),
      ),
    );
  }
}