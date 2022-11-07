import 'package:flutter/material.dart';
 showloading(context){
 return showDialog(
context: context,
builder: (context){
return AlertDialog(
  title:Text("please waite") ,
  content: Container(
    height: 50,
    child: Center(child: CircularProgressIndicator())),
  );
}
  );
}