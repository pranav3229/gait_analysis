import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gait_analysis/editPatient.dart';
import 'package:gait_analysis/preview.dart';
import 'package:gait_analysis/scan.dart';
import 'package:gait_analysis/videoplayerpage.dart';
import 'package:gait_analysis/viewpatients.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'homescreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class patientprofile extends StatefulWidget {
  // const patientprofile({Key? key}) : super(key: key);
  late String text_name;
  late String text_id;
  late String text_dob;
  late String text_gender;
  late String text_height;
  late String text_phone;
  late String text_profurl;
  late String text_weight;
  patientprofile(this.text_name, this.text_id, this.text_dob, this.text_gender,
      this.text_height, this.text_phone, this.text_profurl, this.text_weight);

  @override
  State<patientprofile> createState() => _patientprofileState(
      this.text_name,
      this.text_id,
      this.text_dob,
      this.text_gender,
      this.text_height,
      this.text_phone,
      this.text_profurl,
      this.text_weight);
}

class _patientprofileState extends State<patientprofile> {
  late String text_name;
  late String text_id;
  late String text_dob;
  late String text_gender;
  late String text_height;
  late String text_phone;
  late String text_profurl;
  late String text_weight;

  _patientprofileState(
      this.text_name,
      this.text_id,
      this.text_dob,
      this.text_gender,
      this.text_height,
      this.text_phone,
      this.text_profurl,
      this.text_weight);
  String videoUrl = '';

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
          title: Text('Patient Profile'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 65,
                  backgroundImage: NetworkImage(text_profurl),
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(width: 5, color: Colors.green),
                  ),
                  // child: const Text(
                  //   "FlutterBeads",
                  //   style: TextStyle(fontSize: 34.0),
                  // ),
                  child: Column(
                    children: [
                      //  Text(
                      //   'Name: ${text_name}',
                      //   style: TextStyle(fontSize: 15),
                      // ),
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              border: Border.all(),
                            ),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'ID: ${text_id}',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 1),
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              border: Border.all(),
                            ),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Name: ${text_name}',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 1),
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              border: Border.all(),
                            ),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Height: ${text_height}',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                          SizedBox(width: 1),
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              border: Border.all(),
                            ),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Weight: ${text_weight}',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 1),
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              border: Border.all(),
                            ),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Gender: ${text_gender}',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 1),
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              border: Border.all(),
                            ),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Phone Number: ${text_phone}',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(height:5),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 300,
                      width: 368,
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(width: 5, color: Colors.green),
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('patients')
                              .doc(text_id)
                              .collection('videos')
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            return ListView(
                              shrinkWrap: true,
                              children: snapshot.data!.docs.map((document) {
                                return Container(
                                    height: 35,
                                    child: Ink(
                                      child: InkWell(
                                        splashColor: Colors.tealAccent,
                                        onTap: () {
                                          // print(document.id);
                                          // print(document['name']);
                                          // print(document['dob']);
                                          // print(document['gender']);
                                          // print(document['height']);
                                          // print(document['phone']);
                                          // print(document['profile picture URL']);
                                          // print(document['weight']);
                                          // text_id = document.id;
                                          // text_name = document['name'];
                                          // text_dob = document['dob'];
                                          // text_gender = document['gender'];
                                          // text_height = document['height'];
                                          // text_phone = document['phone'];
                                          // text_profurl = document['profile picture URL'];
                                          // text_weight = document['weight'];
                                          // Navigator.of(context).pushReplacement(
                                          //     MaterialPageRoute(
                                          //         builder: (context) =>
                                          //             patientprofile(
                                          //                 text_name,
                                          //                 text_id,
                                          //                 text_dob,
                                          //                 text_gender,
                                          //                 text_height,
                                          //                 text_phone,
                                          //                 text_profurl,
                                          //                 text_weight)));
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      VideoPlayerPage(
                                                          videoUrl: document[
                                                              'url'])));
                                        }, //hello
                                        child: new Card(
                                            color: Colors.tealAccent,
                                            child: Center(
                                                child: Column(
                                              children: [
                                                // SizedBox(height: 25),
                                                // Text(document['url']),
                                                // SizedBox(height: 35),
                                                Text(document['date_created']
                                                    .toDate()
                                                    .toString())
                                                // .toString()),
                                              ],
                                            ))),
                                      ),
                                    ));
                              }).toList(),
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green)),
                    onPressed: () async {
                      XFile? video = await ImagePicker().pickVideo(source: ImageSource.camera);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => PreviewPage(
                              video!.path,
                              text_name,
                              text_id,
                              text_dob,
                              text_gender,
                              text_height,
                              text_phone,
                              text_profurl,
                              text_weight)));
                    },
                    child: Text('Scan'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green)),
                    onPressed: () async {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => editPatient(
                              text_name,
                              text_id,
                              text_dob,
                              text_gender,
                              text_height,
                              text_phone,
                              text_profurl,
                              text_weight)));
                    },
                    child: Text('Edit Patient'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green),
                    ),
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Confirm Delete'),
                            content: Text(
                                'Are you sure you want to delete this patient?'),
                            actions: [
                              TextButton(
                                child: Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text('Delete'),
                                onPressed: () async {
                                  try {
                                    // Get a reference to the document you want to delete
                                    DocumentReference docRef = FirebaseFirestore
                                        .instance
                                        .collection('patients')
                                        .doc('${text_id}');
                                    print(text_profurl);
                                    final FirebaseStorage storage =
                                        FirebaseStorage.instance;
                                    final ref =
                                        storage.refFromURL(text_profurl);
                                    await ref.delete();
                                    debugPrint('Image deleted successfully.');

                                    // Delete the document
                                    await docRef.delete();
                                    print('Document deleted successfully');
                                  } catch (e) {
                                    debugPrint('Error deleting image: $e');
                                    print('Error deleting document: $e');
                                  }
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => patientview(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text('Delete Patient'),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
