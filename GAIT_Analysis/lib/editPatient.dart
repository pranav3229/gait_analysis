import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gait_analysis/viewpatients.dart';
// import 'package:permission_handler/permission_handler.dart';
import './models/patients.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
// import 'package:path/path.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:dropdown_search/dropdown_search.dart';
import 'package:path/path.dart' as Path;

import 'homescreen.dart';
class editPatient extends StatefulWidget {
  late String text_name;
  late String text_id;
  late String text_dob;
  late String text_gender;
  late String text_height;
  late String text_phone;
  late String text_profurl;
  late String text_weight;
  editPatient(
      this.text_name,
      this.text_id,
      this.text_dob,
      this.text_gender,
      this.text_height,
      this.text_phone,
      this.text_profurl,
      this.text_weight

      );


  // const editPatient({Key? key}) : super(key: key);

  @override
  State<editPatient> createState() => _editPatientState(
      this.text_name,
      this.text_id,
      this.text_dob,
      this.text_gender,
      this.text_height,
      this.text_phone,
      this.text_profurl,
      this.text_weight
  );
}

class _editPatientState extends State<editPatient> {
  late String text_name;
  late String text_id;
  late String text_dob;
  late String text_gender;
  late String text_height;
  late String text_phone;
  late String text_profurl;
  late String text_weight;
  _editPatientState(
      this.text_name,
      this.text_id,
      this.text_dob,
      this.text_gender,
      this.text_height,
      this.text_phone,
      this.text_profurl,
      this.text_weight
      );

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController pA;
  late final TextEditingController pG;
  late final TextEditingController pD;
  late final TextEditingController pH;
  late final TextEditingController pID;
  late final TextEditingController pN;
  late final TextEditingController pPN;
  late final TextEditingController pW;
  late final name;
  late final dob;
  late final height;
  late final number;
  late final weight;
  void initState() {
    pA = TextEditingController();
    pG = TextEditingController();
    pD = TextEditingController(text: text_dob);
    pH = TextEditingController(text: text_height);
    // pID = TextEditingController();
    pN = TextEditingController(text: text_name);
    pPN = TextEditingController(text: text_phone);
    pW = TextEditingController(text: text_weight);
    name=widget.text_name;
    dob=widget.text_dob;
    height=widget.text_height;
    number=widget.text_phone;
    weight=widget.text_weight;
    pD.text=dob;
    pH.text=height;
    pPN.text=number;
    pN.text=name;
    pW.text=weight;

    // TODO: implement initState
    super.initState();
  }
  void dispose() {
    pA.dispose();
    pG.dispose();
    pD.dispose();
    pH.dispose();
    // pID.dispose();
    pN.dispose();
    pPN.dispose();
    pW.dispose(); // TODO: implement dispose
    super.dispose();
  }
  String dropdownValue = 'Choose an option';
  Patient patient = Patient(
      patientAddress: '',
      patientGender: '',
      patientDOB: '',
      patientHeight: '',
      patientName: '',
      patientPhoneNumber: '',
      patientWeight: '',
      profImageUrl: '',
      patientID: '');

  @override

  Widget build(BuildContext context) {

    print(text_name);
    print(text_weight);
    CollectionReference users =
    FirebaseFirestore.instance.collection('patients');
    setState(() {
      patient.patientID = users.id;
    });
    Future<void> updateUser() {
      // patient.profImageUrl=uploadPic(imagefile) as String;
      // Call the user's CollectionReference to add a new user
      return users.doc('${text_id}')
          .update({
        // 'profile picture URL': patient.profImageUrl,
        'name': pN.text,

        // 'id': pID.text,
        'gender': dropdownValue, // Stokes and Sons
        'dob': pD.text,
        'height': pH.text,
        'name': pN.text,
        'phone': pPN.text,
        'weight': pW.text, // 42
      })
          .then((value) => {
        print('User Editted'),
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => patientview()))
      }) //('User Added')
          .catchError((error) => print("Failed to edit user: $error"));
    }
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => patientview()));
            },
            color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.green,
        title: Text('Edit Patient'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Align(
                      //   alignment: Alignment.center,
                      //   child: CircleAvatar(
                      //     radius: 80,
                      //     backgroundColor: Colors.black,
                      //     child: ClipOval(
                      //       // ignore: unnecessary_new
                      //       child: new SizedBox(
                      //         width: 180.0,
                      //         height: 240.0,
                      //         child: (_image != null)
                      //             ? Image.file(
                      //           imagefile,
                      //           fit: BoxFit.fill,
                      //         )
                      //             : Image.network(
                      //           "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Container(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(top: 150.0),
                            child: IconButton(
                              icon: Icon(
                                FontAwesomeIcons.camera,
                                size: 25.0,
                                color: Colors.black38,
                              ),
                              onPressed: () {
                                // getImage();
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Patient Name',

                      ),


                      controller: pN,
                      validator: (String? value) {
                        return (value!.isEmpty)
                            ? 'This field is mandatory'
                            : null;
                      }),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Enter Patient Phone Number',
                    ),
                    // initialValue: text_phone,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validator: (String? value) {
                      return (value!.length != 10)
                          ? 'Enter Valid Phone Number'
                          : null;
                    },
                    controller: pPN,
                    // onSaved: (String? value){
                    //   patient.patientPhoneNumber = value! as int;
                    // }, // Only numbers can be entered
                  ),
                  // TextFormField(
                  //   decoration: const InputDecoration(
                  //     labelText: 'Enter Patient Address',
                  //   ),
                  //   initialValue: text,
                  //   keyboardType: TextInputType.multiline,
                  //   validator: (String? value) {
                  //     return (value!.isEmpty)
                  //         ? 'This field is mandatory'
                  //         : null;
                  //   },
                  //   //   onSaved: (String? value){
                  //   //     patient.patientAddress = value!;
                  //   // }
                  //   controller: pA,
                  //   // Only numbers can be entered
                  // ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Enter Patient Date of Birth (DD-MM-YYYY)',
                    ),
                    // initialValue: text_dob,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a date';
                      }
                      final dateRegExp = RegExp(r'^(\d{2})-(\d{2})-(\d{4})$');
                      if (!dateRegExp.hasMatch(value)) {
                        return 'Please enter date in dd-mm-yyyy format';
                      }
                      return null;
                    },
                    controller: pD,
                    //  onSaved: (String? value){
                    //     patient.patientDOB = value!;
                    // },
                  ),
                  DropdownButtonFormField(
                    decoration:
                    const InputDecoration(labelText: 'Enter Gender'),
                    onChanged: (String? newValue) {
                      patient.patientGender = newValue!;
                      setState(() {
                        //print(newValue);
                        dropdownValue = newValue!;
                        //print(dropdownValue);
                        patient.patientGender = dropdownValue;
                      });
                    },
                    items: <String>['Male', 'Female', 'Others']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                          ));
                    }).toList(),
                    onSaved: (String? value) {
                      patient.patientGender = value!;
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Gender is required';
                      }
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Enter Patient Height (in cm)',
                    ),
                    // initialValue: text_height,
                    keyboardType: TextInputType.number,
                    validator: (String? value) {
                      return (value!.length > 3 || value!.length == 0)
                          ? 'Enter Valid Height'
                          : null;
                    },
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    controller: pH,
                    // onSaved: (String? value){
                    //     patient.patientHeight = value! as int;
                    // }
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Enter Patient Weight (in kg)',
                    ),
                    // initialValue: text_weight,
                    keyboardType: TextInputType.number,
                    validator: (String? value) {
                      return (value!.length > 3 || value!.length == 0)
                          ? 'Enter Valid Weight'
                          : null;
                    },
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    // onSaved: (String? value){
                    //     patient.patientWeight = value! as int;
                    // }
                    controller: pW,
                    // Only numbers can be entered
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    width: 125,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                      ),
                      onPressed: () async {
                        updateUser();
                        // uploadPic(imagefile);

                        // print(uploadPic(imagefile));

                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );

                          // sleep(Duration(seconds: 5));
                          patient.patientName = pN.text;
                          // patient.patientID=pID.text;
                          patient.patientGender = pG.text;
                          patient.patientAddress = pA.text;
                          patient.patientDOB = pD.text;
                          patient.patientHeight = pH.text;
                          patient.patientWeight = pW.text;
                          patient.patientPhoneNumber = pPN.text;

                          sleep(Duration(seconds: 5));

                          print("Patient profile pic URL: " +
                              patient.profImageUrl);

                          print("Patient Name:" + patient.patientName);
                          // print("Patient ID:" + patient.patientID);
                          print("Patient Phone Number: " +
                              patient.patientPhoneNumber.toString());
                          print("Patient Address:" + patient.patientAddress);
                          print("Patient DOB:" + patient.patientDOB);
                          print("Patient Gender:" +
                              dropdownValue); //patient.patientGender
                          print("Patient Height:" +
                              patient.patientHeight.toString());
                          print("Patient Weight:" +
                              patient.patientWeight.toString());
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const patientview()));
                        }
                      },
                      child: const Text('Edit Patient'),
                    ),
                  ),
                ],
              ),
            )),
      )
    );
  }
}
