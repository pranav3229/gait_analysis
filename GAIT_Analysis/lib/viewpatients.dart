import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';
import 'package:gait_analysis/patientprofile.dart';

import 'homescreen.dart';

class patientviewstless extends StatelessWidget {
  const patientviewstless({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Report',
    );
  }
}

class patientview extends StatefulWidget {
  const patientview({Key? key}) : super(key: key);

  @override
  State<patientview> createState() => _patientviewState();
}

class _patientviewState extends State<patientview> {
  late String text_name;
  late String text_id;
  late String text_dob;
  late String text_gender;
  late String text_height;
  late String text_phone;
  late String text_profurl;
  late String text_weight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => homescreen()));
            },
            color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.green,
        title: Text('View Patients'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('patients').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return GlowingOverscrollIndicator(
            // behavior: ScrollBehavior(),
            axisDirection: AxisDirection.down,
            color: Colors.yellowAccent,
            child: ListView(
              children: snapshot.data!.docs.map((document) {
                return Container(
                    height: 125,
                    child: InkWell(
                      onTap: () {
                        print(document.id);
                        print(document['name']);
                        print(document['dob']);
                        print(document['gender']);
                        print(document['height']);
                        print(document['phone']);
                        print(document['profile picture URL']);
                        print(document['weight']);
                        text_id = document.id;
                        text_name = document['name'];
                        text_dob = document['dob'];
                        text_gender = document['gender'];
                        text_height = document['height'];
                        text_phone = document['phone'];
                        text_profurl = document['profile picture URL'];
                        text_weight = document['weight'];
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => patientprofile(
                                text_name,
                                text_id,
                                text_dob,
                                text_gender,
                                text_height,
                                text_phone,
                                text_profurl,
                                text_weight)));
                      },
                      child: new Card(
                          child: Center(
                              child: Column(
                        children: [
                          SizedBox(height: 25),
                          Text(document['name']),
                          SizedBox(height: 35),
                          Text('ID: ${document.id}'),
                        ],
                      ))),
                    ));
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
