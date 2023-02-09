import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';
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
                  child: Center(child: Text(document['name']))
              );
            }).toList(),
          );
        },




      ),
    );
  }
}
