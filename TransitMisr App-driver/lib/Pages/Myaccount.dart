import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class MyAccount extends StatefulWidget {
  MyAccount({Key key, this.uid})
      : super(key: key); //update this to include the uid in the constructor

  final String uid;
  @override
  _ProfilePageState createState() => _ProfilePageState();

}

class _ProfilePageState extends State<MyAccount> {

  File _image;
  dynamic data;
  Future<dynamic> getData() async {

    final DocumentReference document =   Firestore.instance.collection("listofprods").document('ac1');

    await document.get().then<dynamic>(( DocumentSnapshot snapshot) async{
      setState(() {
        data =snapshot.data;
      });
    });
  }

  @override
  void initState() {

    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Profile'),
      ),
        body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 90,

                  child: ClipOval(
                    child: new SizedBox(
                      width: 180.0,
                      height: 180.0,
                      child: (_image!=null)?Image.file(
                        _image,
                        fit: BoxFit.fill,
                      ):Image.asset(
                        'assets/images/person.png',
                        fit: BoxFit.fill,
                      ),

                    ),
                  ),
                ),
              ),


            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Name',
                            style: TextStyle(
                                color: Colors.blueGrey, fontSize: 18.0)),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(data['name'],
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Email',
                            style: TextStyle(
                                color: Colors.blueGrey, fontSize: 18.0)),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(data['email'],
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('National ID',
                            style: TextStyle(
                                color: Colors.blueGrey, fontSize: 18.0)),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(data['nationalId'],
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Age',
                            style: TextStyle(
                                color: Colors.blueGrey, fontSize: 18.0)),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(data['Age'],
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Line Number',
                            style: TextStyle(
                                color: Colors.blueGrey, fontSize: 18.0)),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(data['Line_Number'],
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Phone',
                            style: TextStyle(
                                color: Colors.blueGrey, fontSize: 18.0)),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(data['Phone'],
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ],
      ),
    );

  }

}