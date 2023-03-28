import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gait_analysis/homescreen.dart';
import 'package:video_player/video_player.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'main.dart';
import 'dart:convert'; 
import 'package:http/http.dart' as http;
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

Future<void> sendVideo(String url, File videoFile) async {
  HttpOverrides.global = MyHttpOverrides();
  // final client = http.Client();
  // final timeout = Duration(seconds: 120000); // Increase the timeout to 30 seconds

  try {
  print("Sending request!!!\n");
  http.Response response = await http.post(
  Uri.parse(url),
  headers: {
    'Accept': "*/*",
    'Content-Length': videoFile.lengthSync().toString(),
    'Connection': 'keep-alive',
  },
  body: videoFile.readAsBytesSync(),
  );
  print (response.statusCode);
    // check response status code 
    if (response.statusCode == 200) { 
      print('Video sent successfully!');
      print (response.statusCode);
    }
    else { 
      print('\n|||||||||||||||Error sending video: ${response.statusCode}|||||||\n');
      print (response.statusCode);
    } 
    print("FIN!!!");
  } catch (e) {
    print('Error sending video: $e');

  }
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
            onPressed: () async {
              // XFile? video = await ImagePicker().pickVideo(source: ImageSource.gallery);
              // print('do something with the file');
              sendVideo("https://172.20.17.92:5000/success", File(widget.filePath));
              // sendVideo("https://172.20.17.92:5000/success", File(video!.path));
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) =>
                          homescreen()));
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