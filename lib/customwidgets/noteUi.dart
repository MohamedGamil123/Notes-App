
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_app/editnote.dart';
import 'package:fire_app/notedetails.dart';
import 'package:flutter/material.dart';
class noteUi extends StatelessWidget {
  final imageUrl,title, note,docid;
 
   noteUi({this.title,this.note,this.imageUrl,this.docid});
  CollectionReference noteref=FirebaseFirestore.instance.collection("notes");

  @override
  Widget build(BuildContext context) {
    bool imgageset;
    if(imageUrl!=null){
         imgageset=true;
    }else{
      imgageset=false;
    }
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> notedetails(docid: docid,imageUrl: imageUrl,note: note,title: title,) 
         
        ,));
      },
      child: Container(
      margin: EdgeInsets.only(left: 15,right: 15,bottom: 30),
      child: Stack(
        clipBehavior:Clip.none,
        children: [
        Container(
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(blurRadius: 10,offset: Offset(5,5),spreadRadius: - 5)],
             color: Colors.yellow[200],
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(15))),
          padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
          
          width: double.infinity,
          child: Column(
               mainAxisAlignment: MainAxisAlignment.start,
            children: [
            Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(icon: Icon(Icons.edit),
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => (editnote(docid:docid ,title: title,note: note,)),));
                },
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("$title",style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
              SizedBox(height: 110,),
              ],
            ),
            Divider(
              
              color: Colors.black,),
            Container(
              alignment: Alignment.topLeft,
              child: Text("$note",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),))
    
          ]),
        ),
     Positioned(
       top: 35,
       right: 25,
        child:imgageset==true? CircleAvatar(
          radius: 60,
          backgroundImage:NetworkImage("$imageUrl"),
          backgroundColor: Colors.transparent,
          ):Container(
            
            child: Text("no image"),
           
          )
         )
      
      ],),
      ),
    );
}
  }


/*Widget noteUi({String? imageUrl,String? title,String? note, context}){
  
  return Container(
    margin: EdgeInsets.only(left: 15,right: 15,bottom: 30),
    child: Stack(
      overflow: Overflow.visible,
      children: [
      Container(
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(blurRadius: 10,offset: Offset(5,5),spreadRadius: - 5)],
           color: Colors.yellow[200],
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(15))),
        padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
        
        width: double.infinity,
        child: Column(
             mainAxisAlignment: MainAxisAlignment.start,
          children: [
          Row(
           mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(icon: Icon(Icons.edit),
              onPressed: (){
                Navigator.of(context).pushNamed("editnote");
              },
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("$title",style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
            SizedBox(height: 110,),
            ],
          ),
          Divider(
            
            color: Colors.black,),
          Container(
            alignment: Alignment.topLeft,
            child: Text("$note"))

        ]),
      ),
 Positioned(
   
     right: 0,
      child: Container(
       decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
        
        height: 100,
        width: 200,
        child: Image.network("$imageUrl",fit: BoxFit.cover,),
      ),
    )
    ],),
  );
}*/