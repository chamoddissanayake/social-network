// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttershare/widgets/header.dart';
import 'package:fluttershare/widgets/progress.dart';

final usersRef = Firestore.instance.collection('users');

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  List<dynamic> users = [];

  @override
  void initState() {
    // createUser();
    deleteUser();
    // updateUser();
    getUsers();
    // getUserById();
    super.initState();
  }

  getUsers() async {
    final QuerySnapshot snapshot = await usersRef.getDocuments();

    setState(() {
      users = snapshot.documents;
    });
    // snapshot.documents.forEach((DocumentSnapshot doc) {
    //
    //    print(doc.data);
    //    print(doc.documentID);
    //    print(doc.exists);
    // });
  }

  getUserById() async {
    final String id = "aSadtrS8KYTZjLhHbAm6";
    final DocumentSnapshot doc = await usersRef.document(id).get();
    print(doc.data);
    print(doc.documentID);
    print(doc.exists);
  }

  createUser(){
     usersRef.document("addfdfdfss").setData({
      "username":"Jeff",
      "postsCount":0,
      "isAdmin":false
    });
  }


  updateUser() async{
    final doc = await usersRef.document("J9fWr1Plfz7E6MhdCHcY").get();
  if(doc.exists){
    doc.reference.updateData({
        "username":"Jeffffff",
        "postsCount":1,
        "isAdmin":false
      });
  }
}

  deleteUser() async{
    final DocumentSnapshot doc = await usersRef.document("J9fWr1Plfz7E6MhdCHcY").get();
    if(doc.exists){
      doc.reference.delete();
    }
  }


  @override
  Widget build(context) {
    return Scaffold(
      appBar: header(context, isAppTitle: true),
      body: StreamBuilder<QuerySnapshot>(
        stream:  usersRef.snapshots(),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return circularProgress();
          }
          final List<Text> children = snapshot.data.documents.map((doc) => Text(doc['username'])).toList();
          return Container(
            child: ListView(
              children: children,
            ),
          );
        },
      ),
    );
  }
}
