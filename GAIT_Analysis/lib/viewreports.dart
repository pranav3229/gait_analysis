// import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';
import 'package:gait_analysis/videoplayerpage.dart';
class viewreports extends StatefulWidget {
  // const viewreports({Key? key}) : super(key: key);
  late String text_id;
  late String videoUrl;
  late String video_id;
  late String text_name;
  viewreports(this.text_id,this.videoUrl,this.video_id,this.text_name);
  @override
  State<viewreports> createState() => _viewreportsState(this.text_id, this.videoUrl,this.video_id,this.text_name);
}

class _viewreportsState extends State<viewreports> {
  late String text_id;
  late String videoUrl;
  late String video_id;
  late String text_name;
  _viewreportsState(this.text_id,this.videoUrl,this.video_id,this.text_name);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => VideoPlayerPage(videoUrl,text_id,video_id,text_name)));
            },
            color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.green,
        title: Text('View Reports'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text(" Name: ${text_name}"),
            SizedBox(width: 20),
            Text("Patient ID: ${text_id}"),
            SizedBox(height: 30),
            Container(
              height: 600,
              width: 368,
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(width: 5, color: Colors.green),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                height: 170,
                width: 175,
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                      border: Border.all(width: 5, color: Colors.black),
                      )

                      ),
                      Text('Corresponding Graph text'),
                    ],
                  ),
                  SizedBox(height:20),
                  Row(
                    children: [
                      Container(
                          height: 170,
                          width: 175,
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(width: 5, color: Colors.black),
                          )

                      ),
                      Text('Corresponding Graph text'),
                    ],
                  ),
                  SizedBox(height:20),
                  Row(
                    children: [
                      Container(
                          height: 170,
                          width: 175,
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(width: 5, color: Colors.black),
                          )

                      ),
                      Text('Corresponding Graph text'),
                    ],
                  )
                ],
              )
            ),
            SizedBox(height:20),

          ],

        ),
      )
    );
  }
}
