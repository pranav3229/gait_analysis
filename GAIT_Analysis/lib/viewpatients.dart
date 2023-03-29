import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';
import 'package:gait_analysis/patientprofile.dart';

import 'homescreen.dart';

class patientviewstless extends StatelessWidget {
  const patientviewstless({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Report',
    );
  }
}

class patientview extends StatefulWidget {
  const patientview({Key? key}) : super(key: key);

  @override
  State<patientview> createState() => _patientviewState();
}

class _patientviewState extends State<patientview> {
  late String text_name;
  late String text_id;
  late String text_dob;
  late String text_gender;
  late String text_height;
  late String text_phone;
  late String text_profurl;
  late String text_weight;
  bool _searchBoolean = false;
  Widget _searchTextField() {
    return TextField(
      onChanged: (query) => setState(() => _searchQuery = query),
      autofocus: true, //Display the keyboard when TextField is displayed
      cursorColor: Colors.white,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      textInputAction:
          TextInputAction.search, //Specify the action button on the keyboard
      decoration: InputDecoration(
        //Style of TextField
        enabledBorder: UnderlineInputBorder(
            //Default TextField border
            borderSide: BorderSide(color: Colors.white)),
        focusedBorder: UnderlineInputBorder(
            //Borders when a TextField is in focus
            borderSide: BorderSide(color: Colors.white)),
        hintText: 'Search', //Text that is displayed when nothing is entered.
        hintStyle: TextStyle(
          //Style of hintText
          color: Colors.white60,
          fontSize: 20,
        ),
      ),
    );
  }

  // Widget _defaultListView(){
  //   return StreamBuilder(
  //     stream: FirebaseFirestore.instance.collection('patients').orderBy('name').snapshots(),
  //     builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //       if (!snapshot.hasData) {
  //         return Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       }
  //       // final List<DocumentSnapshot<Object?>>? documents = snapshot.data?.docs.cast<DocumentSnapshot<Object?>>();
  //       // final filteredDocuments = documents?.where((document) {
  //       //   final name = document.get('name').toString();
  //       //   return name.contains(_searchQuery.toLowerCase());
  //       // }).toList();
  //       final List<DocumentSnapshot> documents = snapshot.data!.docs;
  //       List<DocumentSnapshot> filteredDocuments = [];
  //
  //       if (_searchController.text.isNotEmpty) {
  //         for (var document in documents) {
  //           if (document['name']
  //               .toString()
  //               .toLowerCase()
  //               .contains(_searchController.text.toLowerCase())) {
  //             filteredDocuments.add(document);
  //           }
  //         }
  //       } else {
  //         filteredDocuments = documents;
  //       }
  //
  //
  //       return ListView(
  //         shrinkWrap: true,
  //         children: snapshot.data!.docs.map((document) {
  //           return Container(
  //               height: 125,
  //               child: Ink(
  //
  //                 child: InkWell(
  //                   splashColor: Colors.tealAccent,
  //                   onTap: () {
  //                     print(document.id);
  //                     print(document['name']);
  //                     print(document['dob']);
  //                     print(document['gender']);
  //                     print(document['height']);
  //                     print(document['phone']);
  //                     print(document['profile picture URL']);
  //                     print(document['weight']);
  //                     text_id = document.id;
  //                     text_name = document['name'];
  //                     text_dob = document['dob'];
  //                     text_gender = document['gender'];
  //                     text_height = document['height'];
  //                     text_phone = document['phone'];
  //                     text_profurl = document['profile picture URL'];
  //                     text_weight = document['weight'];
  //                     Navigator.of(context).pushReplacement(MaterialPageRoute(
  //                         builder: (context) => patientprofile(
  //                             text_name,
  //                             text_id,
  //                             text_dob,
  //                             text_gender,
  //                             text_height,
  //                             text_phone,
  //                             text_profurl,
  //                             text_weight)));
  //                   },
  //                   child: new Card(
  //
  //                       child: Center(
  //                           child: Column(
  //                             children: [
  //                               SizedBox(height: 25),
  //                               Text(document['name']),
  //                               SizedBox(height: 35),
  //                               Text('ID: ${document.id}'),
  //                             ],
  //                           ))),
  //                 ),
  //               ));
  //         }).toList(),
  //       );
  //     },
  //   );
  // }
  Widget _searchListView() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('patients')
          .orderBy('name')
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final List<DocumentSnapshot> documents = snapshot.data!.docs;
        List<DocumentSnapshot> filteredDocuments = [];

        if (_searchController.text.isNotEmpty) {
          for (var document in documents) {
            if (document['name']
                    .toString()
                    .toLowerCase()
                    .contains(_searchController.text.toLowerCase()) ||
                document.id
                    .toLowerCase()
                    .contains(_searchController.text.toLowerCase()) ||
                document['phone']
                    .toString()
                    .toLowerCase()
                    .contains(_searchController.text.toLowerCase())) {
              filteredDocuments.add(document);
            }
          }
        } else {
          filteredDocuments = documents;
        }

        return Column(
          children: [
            AppBar(
              leading: BackButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => homescreen()));
                  },
                  color: Colors.white),
              backgroundColor: Colors.green,
              actions: !_searchBoolean
                  ? [
                      IconButton(
                          // color: Colors.black,
                          icon: Icon(Icons.search),
                          onPressed: () {
                            setState(() {
                              _searchBoolean = true;
                            });
                          })
                    ]
                  : [
                      IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              _searchBoolean = false;
                            });
                          })
                    ],
              centerTitle: true,
              title: !_searchBoolean
                  ? Text('View Patients')
                  : TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                      style: TextStyle(color: Colors.white),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: filteredDocuments.length,
                itemBuilder: (context, index) {
                  var document = filteredDocuments[index];
                  return Container(
                    height: 125,
                    child: Ink(
                      child: InkWell(
                        splashColor: Colors.tealAccent,
                        onTap: () {
                          print(document.id);
                          print(document['name']);
                          print(document['dob']);
                          print(document['gender']);
                          print(document['height']);
                          print(document['phone']);
                          print(document['profile picture URL']);
                          print(document['weight']);
                          text_id = document.id;
                          text_name = document['name'];
                          text_dob = document['dob'];
                          text_gender = document['gender'];
                          text_height = document['height'];
                          text_phone = document['phone'];
                          text_profurl = document['profile picture URL'];
                          text_weight = document['weight'];
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => patientprofile(
                                      text_name,
                                      text_id,
                                      text_dob,
                                      text_gender,
                                      text_height,
                                      text_phone,
                                      text_profurl,
                                      text_weight)));
                        },
                        child: Card(
                          child: Center(
                            child: Column(
                              children: [
                                SizedBox(height: 15),
                                Text(document['name']),
                                SizedBox(height: 25),
                                Text('Phone number: ${document['phone']}'),
                                SizedBox(height: 25),
                                Text('ID: ${document.id}'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   actions: !_searchBoolean
      //       ? [
      //     IconButton(
      //       // color: Colors.black,
      //         icon: Icon(Icons.search),
      //         onPressed: () {
      //           setState(() {
      //             _searchBoolean = true;
      //           });
      //         })
      //   ]
      //       : [
      //     IconButton(
      //
      //         icon: Icon(Icons.clear),
      //         onPressed: () {
      //           setState(() {
      //             _searchBoolean = false;
      //           });
      //         }
      //     )
      //   ],
      //
      //
      //   centerTitle: true,
      //   backgroundColor: Colors.green,
      //   title: !_searchBoolean ? Text('View Patients') : _searchTextField(),
      // ),
      body: Container(
        child: _searchListView(),
        // child: StreamBuilder(
        //   stream: FirebaseFirestore.instance.collection('patients').snapshots(),
        //   builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //     if (!snapshot.hasData) {
        //       return Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     }
        //
        //     return ListView(
        //       shrinkWrap: true,
        //       children: snapshot.data!.docs.map((document) {
        //         return Container(
        //             height: 125,
        //             child: Ink(
        //
        //               child: InkWell(
        //                 splashColor: Colors.tealAccent,
        //                 onTap: () {
        //                   print(document.id);
        //                   print(document['name']);
        //                   print(document['dob']);
        //                   print(document['gender']);
        //                   print(document['height']);
        //                   print(document['phone']);
        //                   print(document['profile picture URL']);
        //                   print(document['weight']);
        //                   text_id = document.id;
        //                   text_name = document['name'];
        //                   text_dob = document['dob'];
        //                   text_gender = document['gender'];
        //                   text_height = document['height'];
        //                   text_phone = document['phone'];
        //                   text_profurl = document['profile picture URL'];
        //                   text_weight = document['weight'];
        //                   Navigator.of(context).pushReplacement(MaterialPageRoute(
        //                       builder: (context) => patientprofile(
        //                           text_name,
        //                           text_id,
        //                           text_dob,
        //                           text_gender,
        //                           text_height,
        //                           text_phone,
        //                           text_profurl,
        //                           text_weight)));
        //                 },
        //                 child: new Card(
        //
        //                     child: Center(
        //                         child: Column(
        //                   children: [
        //                     SizedBox(height: 25),
        //                     Text(document['name']),
        //                     SizedBox(height: 35),
        //                     Text('ID: ${document.id}'),
        //                   ],
        //                 ))),
        //               ),
        //             ));
        //       }).toList(),
        //     );
        //   },
        // ),
      ),
    );
  }
}
