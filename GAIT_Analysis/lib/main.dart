import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'homescreen.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
    // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. debug provider
    // 2. safety net provider
    // 3. play integrity provider
    androidProvider: AndroidProvider.debug,
    // androidProvider: AndroidProvider.playIntegrity
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final TextEditingController username;
  late final TextEditingController password;
  void initState() {
    username = TextEditingController();
    password = TextEditingController();
    // TODO: implement initState
    super.initState();
  }


  void dispose() {
    username.dispose();
    password.dispose(); // TODO: implement dispose
    super.dispose();
  }
  bool yeet=false;


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(

        centerTitle: true,
        backgroundColor: Colors.green,
        title: Text('Login'),
      ),
      body: Center(


        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(


            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: username,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(hintText: 'Enter the username'),
              ),
              TextField(
                obscureText: true,
                controller: password,
                decoration: InputDecoration(hintText: 'Enter the password'),
              ),
              SizedBox(height:50),
              // FloatingActionButton(onPressed: () async{
              //
              // },
              //   tooltip: 'Sign In',
              //   child: const Icon(Icons.login),
              // )
              SizedBox(
                width:140,
                height: 45,

                child: ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
                    onPressed: ()async{
                    setState(() {
                      yeet=true;
                    });


                  try {
                    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: username.text,
                        password: password.text,
                    );




                    FirebaseAuth.instance
                        .userChanges()
                        .listen((User? user) {
                      if (user == null) {
                        print('User is currently signed out!');
                      } else {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) =>
                                    homescreen()));
                        // !!!!! Here you know the user is signed-in !!!!!
                        print('User is signed in!');
                      }
                    });

                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      print('No user found for that email.');
                    } else if (e.code == 'wrong-password') {
                      print('Wrong password provided for that user.');
                    }
                  }

                },

                    child: const Icon(Icons.login)),

              ),
              SizedBox(height:20),
              Visibility(
                visible: yeet,
                  child: CircularProgressIndicator())





            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
