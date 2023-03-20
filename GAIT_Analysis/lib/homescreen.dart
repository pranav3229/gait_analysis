import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gait_analysis/main.dart';
import 'package:gait_analysis/scan.dart';
import 'package:gait_analysis/viewpatients.dart';

import 'newPatient.dart';
class homescreen extends StatefulWidget {
  const homescreen({Key? key}) : super(key: key);

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {

  signOut() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MyHomePage(title: 'yeet')));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ElevatedButton(
            onPressed: (){
              signOut();
            },
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
        child: Icon(Icons.logout),
        ),

        centerTitle: true,
        backgroundColor: Colors.green,
        title: Text('Please select an option'),
      ),
      body: Center(
        child:
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(
                  height:150,
                ),
                SizedBox(
                  height:75,
                  width:150,
                  child: ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
                    onPressed: ()async{
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => NewPatientForm()));

                  },
                      child: Text('New Patient'),
                  ),
                ),
                SizedBox(height:20),
                SizedBox(
                  height:75,
                  width:150,
                  child: ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
                    onPressed: ()async{

                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => const patientview()));

                  },
                    child: Text('View Patients'),
                  ),
                ),
                SizedBox(height:20),
                SizedBox(
                  height:75,
                  width:150,
                  child: ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
                    onPressed: ()async{


                  },
                    child: Text('Settings'),
                  ),
                ),
                SizedBox(height:20),
                SizedBox(
                  height:75,
                  width:150,
                  child: ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
                    onPressed: ()async{
                    await FirebaseAuth.instance.signOut();
                    FirebaseAuth.instance
                        .authStateChanges()
                        .listen((User? user) {
                      if (user == null) {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) =>
                                    MyHomePage(title: 'yeet')));
                        print('User is currently signed out!');
                      } else {

                        // !!!!! Here you know the user is signed-in !!!!!
                        print('User is signed in!');
                      }
                    });



                  },
                    child: Text('Logout'),
                  ),
                ),
                SizedBox(height:20),
                SizedBox(
                  height:75,
                  width:150,
                  child: ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
                    onPressed: ()async{
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) =>
                                  ScanPage()));


                    },
                    child: Text('Scan'),
                  ),
                ),

              ],
            ),
          )
      ),
    );
  }
}
