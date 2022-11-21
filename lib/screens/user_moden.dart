import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserModel {
  late String id;
  late String fullname;
  late String email;
  late DateTime time;


  UserModel({
    required this.id,
    required this.fullname,
    required this.email,
    required this.time,

   
  });


  // Map to Object
  UserModel.formMap(Map<String,dynamic>map){
    id = map["id"];
    fullname = map["fullname"];
    email = map["email"];
    time = (map["time"] as Timestamp).toDate();
   
  }


  // Object to Map
  Map<String,dynamic> toMap()=>{
      "id":id,
      "fullname":fullname,
      "email":email,
      "time":time,

 
  };
}







class test {
 late  String name;
 late  String id;
 late  String emil;
  test({
    required this.name,
    required this.id,
    required this.emil,
  });
 
  Map<String,dynamic>toMap()=>{
      'name':name,
      'id':id,
      'emil':emil
  };

  test.formMap(Map<String,dynamic>map){
    name = map['name'];
    id = map['id'];
    emil= map['emil'];
  }

  
  
}









class NewModel {
  final String id;
  final String fullname;
  final String email;
  final DateTime time;
  NewModel({
    required this.id,
    required this.fullname,
    required this.email,
    required this.time,
  });



  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullname': fullname,
      'email': email,
      'time': time,
    };
  }

  factory NewModel.fromJson(Map<String, dynamic> json) => NewModel(
        id: json["id"],
        fullname: json["fullname"],
        email: json["email"],
        time:(json["time"] as Timestamp).toDate(),
      );

}
