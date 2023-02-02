import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gait_analysis/main.dart';
class homescreen extends StatefulWidget {
  const homescreen({Key? key}) : super(key: key);

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Please select an option'),

      ),
      body: Center(
        child:
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    ElevatedButton(onPressed: ()async{

                    },
                        child: Text('New Patient'),
                    ),
                    SizedBox(width:20),
                    ElevatedButton(onPressed: ()async{

                    },
                      child: Text('View Patients'),
                    ),

                  ],
                ),
                Row(
                  children: [
                    ElevatedButton(onPressed: ()async{


                    },
                      child: Text('Settings'),
                    ),
                    SizedBox(width:20),
                    ElevatedButton(onPressed: ()async{
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

                  ],

                )

              ],
            ),
          )
      ),
    );
  }
}