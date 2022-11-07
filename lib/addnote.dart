import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_app/customwidgets/showmodalbottomsheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/scheduler.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'customwidgets/showloading.dart';

class addnote extends StatefulWidget {
  addnote({Key? key}) : super(key: key);

  @override
  State<addnote> createState() => _addnoteState();
}

class _addnoteState extends State<addnote> {
  final GlobalKey<FormState> formstate = GlobalKey<FormState>();
  //final List<GlobalObjectKey<FormState>> formKeyList = List.generate(10, (index) => GlobalObjectKey<FormState>(index));
  Reference? ref;
  CollectionReference noteref = FirebaseFirestore.instance.collection("notes");
  File? file;
  var title, note, imagename, imageUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Add note",
        style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
      )),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(
            height: 30,
          ),
          Container(
              padding: EdgeInsets.only(bottom: 60),
              child: Text(
                "Add note",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              )),
          Form(
              key: formstate,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (val) {
                        if (val!.length > 20) {
                          return "title is too long";
                        } else if (val.length < 3) {
                          return "title is too short";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (val) {
                        title = val;
                      },
                      maxLength: 50,
                      maxLines: 1,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.note_add_outlined),
                          hintText: "add title",
                          hintStyle: TextStyle(fontSize: 20),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 2))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (val) {
                          if (val!.length > 2000) {
                            return "note is too long";
                          } else if (val.length < 5) {
                            return "note is too short";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (val) {
                          note = val;
                        },
                        minLines: 1,
                        maxLines: 100,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.note_add),
                            hintText: "add note",
                            hintStyle: TextStyle(fontSize: 20),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 2)))),
                  ),
                ],
              )),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          color: Colors.yellow[50],
                          padding: EdgeInsets.all(10),
                          height: 200,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "please choose photo",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                Divider(thickness: 1.5),
                                SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                    onTap: () async {
                                      var picked = await ImagePicker()
                                          .pickImage(
                                              source: ImageSource.gallery);
                                      if (picked != null) {
                                        file = File(picked.path);
                                        var rand = Random().nextInt(100000);
                                        var imagename =
                                            "$rand" + basename(picked.path);
                                        ref = FirebaseStorage.instance
                                            .ref("images")
                                            .child(imagename);
                                        Navigator.of(context).pop();
                                      }
                                    },
                                    child: Container(
                                        padding: EdgeInsets.all(8),
                                        width: double.infinity,
                                        child: Row(
                                          children: [
                                            Icon(Icons.photo),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              "from gallery",
                                              style: TextStyle(
                                                fontSize: 23,
                                              ),
                                            ),
                                          ],
                                        ))),
                                InkWell(
                                    onTap: () async {
                                      var picked = await ImagePicker()
                                          .pickImage(
                                              source: ImageSource.camera);
                                      if (picked != null) {
                                        file = File(picked.path);
                                        var rand = Random().nextInt(100000);
                                        var imagename =
                                            "$rand" + basename(picked.path);
                                        ref = FirebaseStorage.instance
                                            .ref("images")
                                            .child(imagename);
                                        Navigator.of(context).pop();
                                        final snackbar = SnackBar(
                                          content: Text("sucsses"),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackbar);
                                      }
                                    },
                                    child: Container(
                                        padding: EdgeInsets.all(8),
                                        width: double.infinity,
                                        child: Row(
                                          children: [
                                            const Icon(Icons.camera),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            const Text(
                                              "from camera",
                                              style: TextStyle(
                                                fontSize: 23,
                                              ),
                                            ),
                                          ],
                                        )))
                              ]),
                        );
                      });
                },
                child: Text("add photo")),
          ),
          SizedBox(
            height: 100,
          ),
          ElevatedButton(
            onPressed: () async {
              if (file == null) {
                AwesomeDialog(
                    context: context,
                    body: Text("please choose image"),
                    dialogType: DialogType.ERROR,
                    btnOk: ElevatedButton(
                      child: Text("ok"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ))
                  ..show();
              } else {
                var formdata = formstate.currentState;
                if (formdata!.validate()) {
                  showloading(context);
                  formdata.save();
                  await ref?.putFile(file!);
                  imageUrl = await ref?.getDownloadURL();
                  noteref.add({
                    "title": title,
                    "note": note,
                    "imageUrl": imageUrl,
                    "userid": FirebaseAuth.instance.currentUser?.uid
                  }).then(
                    (value) {
                      Navigator.of(context).pushReplacementNamed("homepage");
                    },
                  ).catchError((e) {
                    print("$e");
                  });
                }
              }
            },
            child: Text("Add Note"),
          )
        ]),
      ),
    );
  }
}
