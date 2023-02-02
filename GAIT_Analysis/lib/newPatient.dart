import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './models/patients.dart';
class NewPatientForm extends StatefulWidget {
  const NewPatientForm ({super.key});

  @override 
  NewPatientFormState createState(){
    return NewPatientFormState();
  }

}

class NewPatientFormState extends State <NewPatientForm> {
  final _formKey = GlobalKey<FormState>();
  String dropdownValue = 'Choose an option';
  Patient patient = Patient(patientAddress: '', patientGender: '', patientDOB: '', patientHeight:0, patientID: '', patientName: '', patientPhoneNumber: 0, patientWeight: 0,);
  @override
  Widget build(BuildContext context) {
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
          onSaved: (String? value){
            patient.patientName = value!;
          },
          validator: (String? value){
            return (value!.isEmpty) ?'This field is mandatory':null;
          }
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Patient ID*',
          ),
          onSaved: (String? value){
            patient.patientID = value!;
          },
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
          onSaved: (String? value){
            patient.patientPhoneNumber = value! as int;
          }, // Only numbers can be entered
          ),
          TextFormField(
            decoration:const InputDecoration(
            labelText: 'Enter Patient Address',
          ) ,
            keyboardType: TextInputType.multiline,
            onSaved: (String? value){
              patient.patientAddress = value!;
          }
             // Only numbers can be entered
          ),
          TextFormField(
            decoration:const InputDecoration(
            labelText: 'Enter Patient Date of Birth (DD-MM-YYYY)',
           ) ,
           onSaved: (String? value){
              patient.patientDOB = value!;
          },
          ),
          DropdownButtonFormField(
            decoration: const InputDecoration(
              labelText: 'Enter Gender'
            ),
            onChanged:(String? newValue){
              setState( () {
                dropdownValue = newValue!;
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
            onSaved: (String? value){
              patient.patientGender = value!;
          }

          ),
          TextFormField(
            decoration:const InputDecoration(
            labelText: 'Enter Patient Height (in cm)',
            
          ) ,
          keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
          ],
          onSaved: (String? value){
              patient.patientHeight = value! as int;
          }
          ),
          TextFormField(
            decoration:const InputDecoration(
            labelText: 'Enter Patient Weight (in kg)',
          ) ,
          keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
          ],
          onSaved: (String? value){
              patient.patientWeight = value! as int;
          }
             // Only numbers can be entered
          ),
          ElevatedButton(
            onPressed:(){
              if (_formKey.currentState!.validate()){
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );
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