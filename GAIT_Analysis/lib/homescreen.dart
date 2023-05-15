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
      backgroundColor: Color(0xFFFFE5B4),
      appBar: AppBar(
          elevation: 0,
        leading: ElevatedButton(
            onPressed: (){
              signOut();
            },
            style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFFE5B4))),
        child: Icon(Icons.arrow_back_ios,
          color: Colors.black,
        ),
        ),

        centerTitle: true,
        backgroundColor: Color(0xFFFFE5B4),
        title: Text(
          'Select an option',
          style: TextStyle(
            color: Colors.black,
            fontSize: 35

          ),
        )
      ),
      body: Center(
        child:
          Padding(
            padding: const EdgeInsets.all(35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // SizedBox(
                // height:150,
                //  ),
                SizedBox(
                  height:125,
                  width:310,
                  child: ElevatedButton(
                 style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.deepOrange)),
                 onPressed: ()async{
                 Navigator.of(context).pushReplacement(
                     MaterialPageRoute(
                         builder: (context) => NewPatientForm()));

                  },
                   child: Text('New Patient'),
                  ),
                ),
                SizedBox(
                  height:10,
                  width : 10
                ),
                SizedBox(
                  height:125,
                  width:310,
                  child: ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.deepOrange)),
                    onPressed: ()async{

                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => const patientview()));

                    },
                    child: Text('View Patients'),
                  ),
                ),
                Row(children: [
                  SizedBox(
                    height:200,
                  ),

                  SizedBox(
                    height: 150,
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () async {},
                      child: Text(
                        'Settings',
                        style: TextStyle(
                          color: Colors.deepOrange,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFFE5B3)),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.deepOrange,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        elevation: MaterialStateProperty.all<double>(0),
                      ),
                    ),
                  ),

                  SizedBox(
                  height:200,
                  width: 10),
                SizedBox(
                  height:150,
                  width:150,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFFE5B3)),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.deepOrange,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      elevation: MaterialStateProperty.all<double>(0),
                    ),
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
                    child: Text(
                        style: TextStyle(
                          color: Colors.deepOrange,
                        ),
                        'Logout'),
                  ),
                ),

                ],)
              ],
            ),
          )
      ),
    );
  }
}
