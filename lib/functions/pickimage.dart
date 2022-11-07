import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
 
 pickimagefromCamera(context)async{
          
 var picked=await ImagePicker().pickImage(source:ImageSource.camera );
  if(picked!=null){
    var file=File(picked.path);
    var rand=Random().nextInt(100000);
    var imagename="$rand"+basename(picked.path);
    var ref=FirebaseStorage.instance.ref("images").child(imagename);
    Navigator.of(context).pop();
   }

}

pickimagefromGallery(context)async{
          
 var picked=await ImagePicker().pickImage(source:ImageSource.gallery );
  if(picked!=null){
  var file=File(picked.path);
  var rand=Random().nextInt(100000);
  var imagename="$rand"+basename(picked.path);
  var ref=FirebaseStorage.instance.ref("images").child(imagename);
    Navigator.of(context).pop();
   }

}