// import 'dart:js_util';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './models/patients.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class NewPatientForm extends StatefulWidget {
  const NewPatientForm ({super.key});

  @override 
  NewPatientFormState createState(){
    return NewPatientFormState();
  }

}

class NewPatientFormState extends State <NewPatientForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController pA;
  late final TextEditingController pG;
  late final TextEditingController pD;
  late final TextEditingController pH;
  late final TextEditingController pID;
  late final TextEditingController pN;
  late final TextEditingController pPN;
  late final TextEditingController pW;
  void initState() {
    pA = TextEditingController();
    pG = TextEditingController();
    pD = TextEditingController();
    pH = TextEditingController();
    pID = TextEditingController();
    pN = TextEditingController();
    pPN = TextEditingController();
    pW = TextEditingController();

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    pA.dispose();
    pG.dispose();
    pD.dispose();
    pH.dispose();
    pID.dispose();
    pN.dispose();
    pPN.dispose();
    pW.dispose();// TODO: implement dispose
    super.dispose();
  }
  String dropdownValue = 'Choose an option';
  Patient patient = Patient(patientAddress: '', patientGender: '', patientDOB: '', patientHeight:'', patientID: '', patientName: '', patientPhoneNumber: '', patientWeight: '',);
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('patients');
    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return users
          .add({
        'name': pN.text, // John Doe
        'id': pID.text,
        'gender': patient.patientGender,// Stokes and Sons
        'dob': pD.text,
        'height': pH.text,
        'name':pN.text,
        'phone':pPN.text,
        'weight':pW.text,// 42
      })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }
    return Scaffold(
      body:SingleChildScrollView(
      child: Form(
      key: _formKey,
      child: Column(children: <Widget>[
        GestureDetector(
          onTap:(){
            print('Upload Image');
          },
          child: CircleAvatar(
            radius: 110,
          ),
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Patient Name*',
          ),
          // onSaved: (String? value){
          //   patient.patientName = value!;
          // },
            controller: pN,
          validator: (String? value){
            return (value!.isEmpty) ?'This field is mandatory':null;
          }
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Patient ID*',
          ),
          // onSaved: (String? value){
          //   patient.patientID = value!;
          // },
            controller: pID,
          validator: (String? value){
            return (value!.isEmpty) ?'This field is mandatory':null;
          }
        ),
        TextFormField(
            decoration:const InputDecoration(
            labelText: 'Enter Patient Phone Number',
          ) ,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            validator: (String? value){
            return (value!.length!=10) ?'Enter Valid Phone Number':null;
          },
          controller: pPN,
          // onSaved: (String? value){
          //   patient.patientPhoneNumber = value! as int;
          // }, // Only numbers can be entered
          ),
          TextFormField(
            decoration:const InputDecoration(
            labelText: 'Enter Patient Address',
          ) ,
            keyboardType: TextInputType.multiline,
          //   onSaved: (String? value){
          //     patient.patientAddress = value!;
          // }
            controller: pA,
             // Only numbers can be entered
          ),
          TextFormField(
            decoration:const InputDecoration(
            labelText: 'Enter Patient Date of Birth (DD-MM-YYYY)',
           ) ,
          controller: pD,
          //  onSaved: (String? value){
          //     patient.patientDOB = value!;
          // },
          ),
          DropdownButtonFormField(
            decoration: const InputDecoration(
              labelText: 'Enter Gender'
            ),
            onChanged:(String? newValue){
              setState( () {
                dropdownValue = newValue!;
                patient.patientGender=dropdownValue;
              });
            },
            items: <String>['Male','Female','Others'].map<DropdownMenuItem<String>>((String value){
              return DropdownMenuItem<String>(
                value: value,
                child:Text(
                  value,
                )
              );
            }).toList(),
          //   onSaved: (String? value){
          //     patient.patientGender = value!;
          // }

          ),
          TextFormField(
            decoration:const InputDecoration(
            labelText: 'Enter Patient Height (in cm)',
            
          ) ,
          keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
          ],
          controller: pH,
          // onSaved: (String? value){
          //     patient.patientHeight = value! as int;
          // }
          ),
          TextFormField(
            decoration:const InputDecoration(
            labelText: 'Enter Patient Weight (in kg)',
          ) ,
          keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
          ],
          // onSaved: (String? value){
          //     patient.patientWeight = value! as int;
          // }
            controller: pW,
             // Only numbers can be entered
          ),
          ElevatedButton(
            onPressed:() async{
              addUser();
              if (_formKey.currentState!.validate()){
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );
                patient.patientName=pN.text;
                patient.patientID=pID.text;
                patient.patientGender=pG.text;
                patient.patientAddress=pA.text;
                patient.patientDOB=pD.text;
                patient.patientHeight=pH.text;
                patient.patientWeight=pW.text;
                patient.patientPhoneNumber=pPN.text;


              print("Patient Name:" + patient.patientName);
              print("Patient ID:" + patient.patientID);
              print("Patient Phone Number: " + patient.patientPhoneNumber.toString());
              print("Patient Address:" + patient.patientAddress);
              print("Patient DOB:" + patient.patientDOB);
              print("Patient Gender:" + patient.patientGender);
              print("Patient Height:" + patient.patientHeight.toString());
              print("Patient Weight:" + patient.patientWeight.toString());
              }
            },
            child: const Text('Add Patient'),
          ),
          
      ],)
      )
    )
  );
  }
}