
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'customwidgets/showloading.dart';
class signup extends StatefulWidget {
  signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  var myusername;
  var myemail;
  var mypassword;
  GlobalKey<FormState>formstate=GlobalKey<FormState>();
  signup()async{
   var formdata=formstate.currentState;
   if(formdata!.validate()){
   formdata.save();
try {
  showloading(context);
  UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: myemail,
    password: mypassword,
  );
  return credential;
} on FirebaseAuthException catch (e) {
    Navigator.of(context).pop();
  if (e.code == 'weak-password') {
   final snackbar = SnackBar(
          content: Text("weak-password."),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
  } else if (e.code == 'email-already-in-use') {
    final snackbar = SnackBar(
          content: Text("email-already-in-use"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
} catch (e) {
  print(e);
}
   }else{
return "not valid";
   }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
           padding: EdgeInsets.symmetric(horizontal: 20),
      
          child:Column(
            
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 30,),
            Text("Create an account",style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
            SizedBox(height: 40,),
            Container(
              child: Form(
                
                key: formstate,
                child: Column(children: [
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (val){
                      if(val!.isEmpty||val==null){
                          return "username is required";
                      }else if(val.length>20){
                          return "username can't be longer than 20 letters";
                      
                      }else if(val.length<6){
                        return "username can't be little than 6 letters";
                      }
      
                    },
                    onChanged: (val){
                      myusername=val;
                    },
                    
                   decoration: InputDecoration(
                     
                      hintText: "username",
                      border: OutlineInputBorder(borderSide: BorderSide(width: 1),
                      borderRadius: BorderRadius.circular(15),
                      )),
                  ),
                  SizedBox(height: 15,),
                  TextFormField(
                     autovalidateMode: AutovalidateMode.onUserInteraction,
                    onSaved: (val){
                     myemail =val;
                    },
                     validator: (val){
                     if(val!.isEmpty||val==null){
                          return "username is required";
                      }else if(val.length>20){
                          return "username can't be longer than 20 letters";
                      
                      }else if(val.length<6){
                        return "username can't be little than 6 letters";
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "email",
                      border: OutlineInputBorder(borderSide: BorderSide(width: 1),
                      borderRadius: BorderRadius.circular(15),
                      )),
                  ),
                                SizedBox(height: 15,),
      
                  TextFormField(
                     autovalidateMode: AutovalidateMode.onUserInteraction,
                    obscureText: true,
                    onSaved: (val){
                      mypassword=val;
                    },
                     validator: (val){
                      if(val!.isEmpty||val==null){
                          return "username is required";
                      }else if(val.length>20){
                          return "username can't be longer than 20 letters";
                      
                      }else if(val.length<6){
                        return "username can't be little than 6 letters";
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "password",
                      border: OutlineInputBorder(borderSide: BorderSide(width: 1),
                      borderRadius: BorderRadius.circular(15),
                      )),
                  )
                ],)
                ),
            ),
            ElevatedButton(
             
              child:Text("Sign up") ,
              onPressed: ()async{
              
               var response= await signup();
               // response will == null after we have alredy signed up before with the same accounte
              if(response!=null){
                FirebaseFirestore.instance.collection("users").add({
                  "username":myusername,
                  "email":myemail
                });
                  Navigator.of(context).pushReplacementNamed("homepage");
              }else{
                print("signup faild");
              }
              

              },
              ),
            SizedBox(height: 20,),
            Row(children: [
              Text("if you have an account "),
              InkWell(
                onTap:(){
                  Navigator.of(context).pushNamed("login");
                } ,
                child: Text("sign in",style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),),
              ),
            ],)
          ],)),
      ),
    );
  }
}