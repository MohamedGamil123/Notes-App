import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'customwidgets/modalbottomsheet.dart';
import 'customwidgets/noteUi.dart';
import 'customwidgets/showloading.dart';

class homepage extends StatefulWidget {
  homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  CollectionReference noteref = FirebaseFirestore.instance.collection("notes");

  getuserdata() {
    var user = FirebaseAuth.instance.currentUser;
    print(user?.email);
    return user?.email;
  }

  @override
  void initState() {
    getuserdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        drawer: Drawer(
            child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("images/1.jpg"),
                radius: 50,
              ),
              accountEmail: Text("${getuserdata()}"),
              accountName: Text("mohamed gamil"),
            ),
            Column(
              children: [
                ListTile(
                  tileColor: Colors.grey[200],
                  title: Text("sign out"),
                )
              ],
            )
          ],
        )),
        floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.add,
              color: Colors.yellow,
            ),
            backgroundColor: Colors.black,
            onPressed: () {
              Navigator.of(context).pushNamed("addnote");
            }),
        body: Column(
          children: [
            SizedBox(
              height: 62,
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                        color: Colors.yellow[300],
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 0.5,
                              offset: Offset(4, 5),
                              spreadRadius: -5)
                        ],
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(15))),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "My note",
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  IconButton(
                    color: Colors.black,
                    onPressed: () {
                      customBottomSheetDetails(context);
                    },
                    icon: Icon(
                      Icons.menu,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 9,
              child: StreamBuilder<QuerySnapshot>(
                stream: noteref
                    .where("userid",
                        isEqualTo: FirebaseAuth.instance.currentUser?.uid)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, i) {
                        return Dismissible(
                          onDismissed: (right) async {
                            await noteref
                                .doc(snapshot.data!.docs[i].id)
                                .delete();
                            await FirebaseStorage.instance
                                .refFromURL(snapshot.data!.docs[i]["imageUrl"])
                                .delete();
                            print("=====================");
                            print("delete");
                          },
                          child: noteUi(
                            title: "${snapshot.data!.docs[i].data()!["title"]}",
                            note: "${snapshot.data!.docs[i].data()!["note"]}",
                            imageUrl:
                                "${snapshot.data!.docs[i].data()!["imageUrl"]?.toString()}",
                            docid: "${snapshot.data!.docs[i].id}",
                          ),
                          key: UniqueKey(),
                        );

                        /*noteUi(title:"${snapshot.data!.docs[i].data()!["title"]}" ,note:"${snapshot.data!.docs[i].data()!["note"]}",
                    imageUrl: "${snapshot.data!.docs[i].data()!["imageurl"]}",docid:"${snapshot.data!.docs[i].id}" ,
                     );*/
                      },
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            )
          ],
        ));
  }
}
