import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gait_analysis/viewreports.dart';
import 'package:video_player/video_player.dart';
import 'package:gait_analysis/viewpatients.dart';

class VideoPlayerPage extends StatefulWidget {
  late String videoUrl;
  late String text_id;
  late String video_id;
  late String text_name;
  // late String report_url;

  // const VideoPlayerPage({Key? key, required this.videoUrl}) : super(key: key);
  VideoPlayerPage(this.videoUrl, this.text_id,  this.video_id,this.text_name);
  @override
  _VideoPlayerPageState createState() =>
      _VideoPlayerPageState(this.videoUrl, this.text_id,this.video_id,this.text_name);
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late String videoUrl;
  late String text_id;
  late String video_id;
  late String text_name;
  late String report_url;
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  _VideoPlayerPageState(this.videoUrl, this.text_id,this.video_id,this.text_name);

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
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
        title: Text('Patient Video'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text(" Name: ${text_name}"),
            SizedBox(width: 20),
            Text("Patient ID: ${text_id}"),
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                  IconButton(
                    icon: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      size: 50,
                    ),
                    onPressed: () {
                      setState(() {
                        if (_controller.value.isPlaying) {
                          _controller.pause();
                        } else {
                          _controller.play();
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      size: 50,
                    ),
                    onPressed: () {
                      setState(() {
                        if (_controller.value.isPlaying) {
                          _controller.pause();
                        } else {
                          _controller.play();
                        }
                      });
                    },
                  ),
                  SizedBox(width: 30),
                  ElevatedButton(
                      onPressed: ()async{
                        try {
                          DocumentReference docRef2 = FirebaseFirestore.instance
                              .collection('patients')
                              .doc(text_id)
                              .collection('videos')
                              .doc(video_id);

                          DocumentSnapshot snapshot = await docRef2.get();

                          if (snapshot.exists) {
                            report_url = snapshot.get('report_url');
                            print('Report URL: $report_url');
                            // Do something with the reportUrl value
                          } else {
                            print('Document does not exist');
                          }
                        } catch (e) {
                          print('Error accessing report_url: $e');
                        }
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => ViewReports(text_id,videoUrl,video_id,text_name,report_url),
                          ),
                        );

                  },
                      child: Text('View Reports'),
                  ),
                  SizedBox(width: 30),
                  ElevatedButton(
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Confirm Delete'),
                              content: Text(
                                  'Are you sure you want to delete this video?'),
                              actions: [
                                TextButton(
                                  child: Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text('Delete'),
                                  onPressed: () async {
                                    try {
                                      // Get a reference to the document you want to delete
                                      DocumentReference docRef =
                                          FirebaseFirestore.instance
                                              .collection('patients')
                                              .doc('${text_id}')
                                              .collection('videos')
                                              .doc('${video_id}');
                                      // print(text_profurl);
                                      final FirebaseStorage storage =
                                          FirebaseStorage.instance;
                                      final ref = storage.refFromURL(videoUrl);
                                      await ref.delete();
                                      debugPrint('Image deleted successfully.');

                                      // Delete the document
                                      await docRef.delete();
                                      print('Document deleted successfully');
                                    } catch (e) {
                                      debugPrint('Error deleting image: $e');
                                      print('Error deleting document: $e');
                                    }
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) => patientview(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text("Delete Video")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
