import 'dart:math';
import 'package:fire_app/functions/pickimage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'customwidgets/modalbottomsheet.dart';
import 'customwidgets/showmodalbottomsheet.dart';

class notedetails extends StatefulWidget {
  final imageUrl, title, note, docid;
  notedetails({this.docid, this.imageUrl, this.note, this.title});

  @override
  State<notedetails> createState() => _notedetailsState();
}

class _notedetailsState extends State<notedetails> {
  Reference? ref;
  @override
  Widget build(BuildContext context) {
    bool imgageset;
    if (widget.imageUrl != null) {
      imgageset = true;
    } else {
      imgageset = false;
    }
    return Scaffold(
      appBar: AppBar(
          title: Text(
        " Note details",
        style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
      )),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(children: [
            Container(
              width: double.infinity,
              child: imgageset == true
                  ? Image.network(widget.imageUrl)
                  : Text("no image"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    widget.title,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                widget.note,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
