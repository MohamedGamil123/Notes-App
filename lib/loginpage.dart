import 'package:fire_app/customwidgets/showloading.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class login extends StatefulWidget {
  login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  var myemail;
  var mypassword;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  signin() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save();
    }
    try {
      showloading(context);
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: myemail, password: mypassword);
         
      return credential;
      
    } on FirebaseAuthException catch (e) {
       Navigator.of(context).pop();
      if (e.code == 'user-not-found') {
        final snackbar = SnackBar(
          content: Text("No user found for that email."),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      } else if (e.code == 'wrong-password') {
        final snackbar = SnackBar(
          content: Text("Wrong password provided for that user."),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 100,),
              Text(
                "sign in",
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 50,
              ),
              Form(
                key: formstate,
                child: Column(
                  children: [
                    TextFormField(
                      
                       autovalidateMode: AutovalidateMode.onUserInteraction,
                      onSaved: (val) {
                        myemail = val;
                      },
                     validator: (val) {
                        if (val!.length > 30) {
                         return "email is too long";
                        } else if (val.length < 6) {
                          return "email is too short";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          hintText: "email",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1),
                            borderRadius: BorderRadius.circular(15),
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: true,
                      onSaved: (val) {
                        mypassword = val;
                      },
                      validator: (val) {
                        if (val!.length > 30) {
                         return "password is too long";
                        } else if (val.length < 6) {
                          return "password is too short";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          hintText: "password",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1),
                            borderRadius: BorderRadius.circular(15),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text("if don't have an account"),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          child: Text(
                            "sign up",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed("signup");
                          },
                        )
                      ],
                    ),
      
                    InkWell(
                      onTap:(){} ,
                      child: Text("forget password", style: TextStyle(fontWeight: FontWeight.bold),)),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      child: Text("sign in"),
                      onPressed: () async {
                        var user = await signin();
                        if (user != null) {
                          Navigator.of(context).pushReplacementNamed("homepage");
                        }
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
