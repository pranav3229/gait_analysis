import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gait_analysis/homescreen.dart';
import 'package:video_player/video_player.dart';

import 'main.dart';
import 'dart:convert'; 
import 'package:http/http.dart' as http; 

Future<void> sendVideo(String url, File videoFile) async { 
  // create multipart request 
  var request = http.MultipartRequest('POST', Uri.parse(url)); 
  print('Sending request to ${Uri.parse(url)}');
  // add video file to request 
  var videoStream = http.ByteStream(videoFile.openRead()); 
  var videoLength = await videoFile.length(); 
  var videoMultipart = http.MultipartFile('video', videoStream, videoLength, filename: videoFile.path.split('/').last); 
  print("Addidng multipart request");
  request.files.add(videoMultipart); 
  // send request 
  print("\nREQUEST SENT!!!\n");
  var response = await request.send(); 
  // check response status code 
  if (response.statusCode == 200) { 
    print('Video sent successfully!'); 
  }
  else { 
    print('\n|||||||||||||||Error sending video: ${response.statusCode}|||||||\n'); 
  } 
  print("FIN!!!");
}

class PreviewPage extends StatefulWidget {
  final String filePath;

  const PreviewPage({Key? key, required this.filePath}) : super(key: key);

  @override
  PreviewPageState createState() => PreviewPageState();
}

class PreviewPageState extends State<PreviewPage> {
  late VideoPlayerController _videoPlayerController;

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future _initVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.file(File(widget.filePath));
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview'),
        elevation: 0,
        backgroundColor: Colors.black26,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) =>
                          homescreen()));
              // print('do something with the file');
              sendVideo("https://172.20.17.92:5000/success", File(widget.filePath));
            },
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: FutureBuilder(
        future: _initVideoPlayer(),
        builder: (context, state) {
          if (state.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return VideoPlayer(_videoPlayerController);
          }
        },
      ),
    );
  }
}