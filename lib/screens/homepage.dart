import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_practce_set_app/screens/data_add_screen.dart';
import 'package:firebase_practce_set_app/screens/user_moden.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

final _auth = FirebaseAuth.instance;
final firebaseFirestore = FirebaseFirestore.instance;
final con = TextEditingController();

final ref = FirebaseFirestore.instance;



   logout(){
    _auth.signOut().then((value){
    });
  }


//   String timeAgo(DateTime d) {
//  Duration diff = DateTime.now().difference(d);
//  if (diff.inDays > 365)
//   return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
//  if (diff.inDays > 30)
//   return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
//  if (diff.inDays > 7)
//   return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
//  if (diff.inDays > 0)
//   return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
//  if (diff.inHours > 0)
//   return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
//  if (diff.inMinutes > 0)
//   return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
//  return "just now";
// }



String timeAgo(DateTime d) {
 Duration diff = DateTime.now().difference(d);
 if (diff.inDays > 365)
  return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
 if (diff.inDays > 30)
  return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
 if (diff.inDays > 7)
  return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
 if (diff.inDays > 0)
  return "${DateFormat.E().add_jm().format(d)}";
 if (diff.inHours > 0)
  return "${(diff.inHours ).floor() != 12 ? "Today ${DateFormat('jm').format(d)}" : "${DateFormat.E().add_jm().format(d)}"}";
 // return "Today ${DateFormat('jm').format(d)}";
 if (diff.inMinutes > 0)
  return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
 return "just now";
}


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: [
         IconButton(onPressed: (){
          logout();
         }, icon: Icon(Icons.logout))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          
          SizedBox(height: 20,),

          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              controller: con,
              decoration: InputDecoration(
                hintText: "Search"
              ),
              onChanged: (String value) {
                setState(() {
                  
                });
              },
            ),
          ),
          Expanded(
            child:StreamBuilder<QuerySnapshot>(
              stream: ref.collection("Users").snapshots(),
              builder: (context,snapshot){
                if(snapshot.connectionState == ConnectionState.waiting)
                return SingleChildScrollView();

                if(snapshot.hasError)
                return Text("some Error");

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                 // Map<String,dynamic> data = snapshot.data!.docs[index].data() as Map<String,dynamic>;
                    
                 // NewModel userdata = NewModel.fromJson(snapshot.data!.docs[index].data() as Map<String,dynamic>);
                   UserModel userdata = UserModel.formMap(snapshot.data!.docs[index].data() as Map<String,dynamic>);
   
                     return ListTile(
                      onTap: ()async{
                       // firebaseFirestore.collection('Somad').doc(userdata.id).delete();
                      },
                      title: Text(userdata.fullname),
                     //subtitle: Text(DateFormat.yMEd().add_jms().format(userdata.time),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                      subtitle: Text(timeAgo(userdata.time),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                     );
                  });
                



              }
              
              
              )
             )

        ],
      ),

      floatingActionButton: FloatingActionButton(onPressed: (){
        // final id = DateTime.now().microsecondsSinceEpoch.toString();
        // firebaseFirestore.collection("User").doc(id).set({
        //   'name':'somad',
        //    'id':id,
        // }).then((value){
        //   print("add");
        // });

        Navigator.push(context,MaterialPageRoute(builder: (context)=>DataAddScreen()));
      },child: Icon(Icons.add),),
      
    );
    
  }
}