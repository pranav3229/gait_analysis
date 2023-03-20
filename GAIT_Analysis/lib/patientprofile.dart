import 'package:flutter/material.dart';
import 'package:gait_analysis/scan.dart';

import 'homescreen.dart';
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
  patientprofile(
      this.text_name,
      this.text_id,
      this.text_dob,
      this.text_gender,
      this.text_height,
      this.text_phone,
      this.text_profurl,
      this.text_weight

      );

  @override
  State<patientprofile> createState() => _patientprofileState(
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
      this.text_weight
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
            onPressed: (){
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) =>
                          homescreen()));
            },
            color: Colors.black
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        title: Text('Patient Profile'),
      ),
      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height:50
            ),
            Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 65,
                backgroundImage:
                NetworkImage(text_profurl),
              ),
            ),
            SizedBox(height:20),
            Align(
              alignment: Alignment.center,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(width:5, color: Colors.green),
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
                    SizedBox(height:1),
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
                    SizedBox(height:1),
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
                        SizedBox(width:1),
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
                    SizedBox(height:1),
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
                    SizedBox(height:1),
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
            SizedBox(height:10),
            Row(
              children: [
                Container(
                  height:300,
                  width: 368,
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(width:5, color: Colors.green),
                  ),
                  child: Column(
                    children: [
                      Text('Video Log',
                      style: TextStyle(fontSize: 30)
                      ),
                      Divider(
                        height: 20,
                        thickness: 5,
                        indent: 20,
                        endIndent: 0,
                        color: Colors.black,
                      ),
                      SingleChildScrollView(
                        child: Row(),
                      )
                    ],
                  ),

                )
              ],
            ),
            Row(
              children: [
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
                  onPressed: ()async{
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) =>
                                ScanPage()));


                  },
                  child: Text('Scan'),
                ),
              ],

            ),

          ],
        ),
      )
    );
  }
}
class DescriptionTextWidget extends StatefulWidget {
  final String text;

  DescriptionTextWidget({required this.text});

  @override
  _DescriptionTextWidgetState createState() => new _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 50) {
      firstHalf = widget.text.substring(0, 50);
      secondHalf = widget.text.substring(50, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: secondHalf.isEmpty
          ? new Text(firstHalf)
          : new Column(
        children: <Widget>[
          new Text(flag ? (firstHalf + "...") : (firstHalf + secondHalf)),
          new InkWell(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Text(
                  flag ? "show more" : "show less",
                  style: new TextStyle(color: Colors.blue),
                ),
              ],
            ),
            onTap: () {
              setState(() {
                flag = !flag;
              });
            },
          ),
        ],
      ),
    );
  }}
