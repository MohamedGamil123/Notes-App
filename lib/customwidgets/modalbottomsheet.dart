import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

 customBottomSheetDetails(context){
  return showModalBottomSheet(
   
    backgroundColor: Colors.transparent,
context: context,
builder: (context){
return Container(
   decoration: BoxDecoration(
          boxShadow: [BoxShadow(blurRadius: 10,offset: Offset(5,5),spreadRadius: - 5)],
           color: Colors.yellow[50],
          borderRadius: BorderRadius.only(topRight: Radius.circular(15))),
        padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
        child: ListView(children: [
          Column(
            children: [
              ListTile(
                iconColor: Colors.black,
                leading: Icon(Icons.search),
                trailing: Icon(Icons.arrow_forward_ios),
                tileColor: Colors.yellow[300],
                onTap: () async{
               
              },
                title: Text("search"),
              ),
               ListTile(
                iconColor: Colors.black,
                leading: Icon(Icons.settings),
                trailing: Icon(Icons.arrow_forward_ios),
                tileColor: Colors.yellow[300],
                onTap: () {
                
              },
                title: Text("setting"),
              ),
               ListTile(
                 hoverColor: Colors.yellow,
                focusColor: Colors.yellow,
                iconColor: Colors.black,
                leading: Icon(Icons.info),
                trailing: Icon(Icons.arrow_forward_ios),
                tileColor: Colors.yellow,
                onTap: () {
              
              },
                title: Text("about"),
              ),
               ListTile(
                iconColor: Colors.black,
                leading: Icon(Icons.outbox),
                trailing: Icon(Icons.arrow_forward_ios),
                tileColor: Colors.yellow[300],
                onTap: () async{
                await FirebaseAuth.instance.signOut();
            Navigator.of(context).pushReplacementNamed("login");
              },
                title: Text("sign out"),
              ),
            ],
          ),
        ]),
  );
}
  );
}