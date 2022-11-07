 import 'package:fire_app/functions/pickimage.dart';
import 'package:flutter/material.dart';
 showmodalbottomsheatPicker(context){
   return showModalBottomSheet( 
                
                context: context, builder: (context){
                return Container(
                  color: Colors.yellow[50],
                  padding: EdgeInsets.all(10),
                  height: 200,
                  child: Column(
                    
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                    Text("please choose photo",style:TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                    Divider(
                    thickness: 1.5),
                   SizedBox(height: 10,),
                    InkWell(
                      onTap: ()async{
                     await pickimagefromGallery(context);
                      },
                      child: Container(
                         padding:EdgeInsets.all(8) ,
                        width: double.infinity,
                        child: Row(
                          children: [
                            Icon(Icons.photo),
                            SizedBox(width: 20,),
                            Text("from gallery",style:TextStyle(fontSize: 23,),),
                          ],
                        ))),
                   
                    InkWell(
                     onTap: ()async{
                      await pickimagefromCamera(context);
                     },
                      child: Container(
                        padding:EdgeInsets.all(8) ,
                          width: double.infinity,
                        child: Row(
                          children: [
                           const Icon(Icons.camera),
                           const SizedBox(width: 20,),
                            const Text("from camera",style:TextStyle(fontSize: 23, ),),
                          ],
                        )))
                  ]),
                );
      
              });
      
 }