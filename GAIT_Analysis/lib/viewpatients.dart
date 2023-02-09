import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';

import 'homescreen.dart';
class patientviewstless extends StatelessWidget {
  const patientviewstless({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:'View Report',
      
    );
  }
}

class patientview extends StatefulWidget {
  const patientview({Key? key}) : super(key: key);

  @override
  State<patientview> createState() => _patientviewState();
}

class _patientviewState extends State<patientview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: (){
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) =>
                        homescreen()));
          },
          color: Colors.black
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        title: Text('View Patients'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('patients').snapshots(),
        builder: ( context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((document) {
              return Container(
                height:125,
                  child: InkWell(
                    onTap:(){
                      print(document.id);
                      print(document['name']);




                    },
                    child: new Card(child: Center(child: Column(
                      children: [
                        SizedBox(height:25),
                        Text(document['name']),
                        SizedBox(height:35),
                          Text('ID: ${document.id}'),
                        





                      ],
                    ))),
                  )
              );
            }).toList(),
          );
        },




      ),
    );
  }
}
