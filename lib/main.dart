import 'package:fire_app/editnote.dart';
import 'package:fire_app/loginpage.dart';
import 'package:fire_app/signup.dart';
import 'package:fire_app/test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'addnote.dart';
import 'homepage.dart';
import 'test.dart';

bool? islogin;
void main()async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //indicate if you had logged in to the app
var user=FirebaseAuth.instance.currentUser;
if(user==null){
  islogin=false;
}else{
  islogin=true;
}
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.yellow[300]),
        primaryColor: Colors.blue[100],
       scaffoldBackgroundColor: Colors.yellow[50],
       
      ),
      home:islogin==false?login():homepage(),
      routes: {
        "login":(context) => login(),
        "signup":(context)=> signup(),
        "homepage":(context) => homepage(),
        "addnote":(context) => addnote(),
        "editnote":(context) => editnote(),
      },
    );
  }
}

