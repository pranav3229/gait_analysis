import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:gait_analysis/homescreen.dart';
import 'package:gait_analysis/patientprofile.dart';
import 'package:video_player/video_player.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'main.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';

late String logurl;
// Future<String> ReduceSizeAndType(videoPath, outDirPath) async {
//   assert(File(videoPath).existsSync());
//   final FlutterFFmpeg _flutterFFmpeg = new FlutterFFmpeg();
//   final arguments = '-y -i $videoPath ' +
//       '-preset ultrafast -g 48 -sc_threshold 0 ' +
//       '-c:v libx264 -b:v 720k ' +
//       '-c:a copy ' +
//       '"$outDirPath/file2.mp4"';

//   final int rc = await _flutterFFmpeg.execute(arguments);
//   assert(rc == 0);

//   return outDirPath;
// }

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class PreviewPage extends StatefulWidget {
  final String filePath;
  late String text_id;
  late String text_dob;
  late String text_gender;
  late String text_height;
  late String text_phone;
  late String text_profurl;
  late String text_weight;
  late String text_name;

  // const PreviewPage({Key? key, required this.filePath}) : super(key: key);
  PreviewPage(
      this.filePath,
      this.text_name,
      this.text_id,
      this.text_dob,
      this.text_gender,
      this.text_height,
      this.text_phone,
      this.text_profurl,
      this.text_weight);

  @override
  PreviewPageState createState() => PreviewPageState(
      this.filePath,
      this.text_name,
      this.text_id,
      this.text_dob,
      this.text_gender,
      this.text_height,
      this.text_phone,
      this.text_profurl,
      this.text_weight);
}

class PreviewPageState extends State<PreviewPage> {
  late String filePath;
  late String text_id;
  late String text_dob;
  late String text_gender;
  late String text_height;
  late String text_phone;
  late String text_profurl;
  late String text_weight;
  late String text_name;
  late String report_url;

  PreviewPageState(
      this.filePath,
      this.text_name,
      this.text_id,
      this.text_dob,
      this.text_gender,
      this.text_height,
      this.text_phone,
      this.text_profurl,
      this.text_weight);
  late VideoPlayerController _videoPlayerController;
  Future<void> uploadVideo(String videoUrl, String desiredName) async {
    final response = await http.get(Uri.parse(videoUrl));
    final bytes = response.bodyBytes;
    final fileName = desiredName;
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    final reference = FirebaseStorage.instance
        .ref()
        .child("videos/${desiredName + now.toString()}.mp4");
    final uploadTask = reference.putData(bytes);
    final snapshot =
        await uploadTask.whenComplete(() => print('Video uploaded'));
    final downloadUrl = await snapshot.ref.getDownloadURL();
    print('Download URL: $downloadUrl');
    logurl = downloadUrl;

    //code for report url fetch begins here
    try {
      final url = 'http://gaitanalysis.bits-pilani.ac.in/finalframe';
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Image data is available in response.bodyBytes
        final imageData = response.bodyBytes;
        final reference2 = FirebaseStorage.instance
            .ref()
            .child("reports/${desiredName + now.toString()}");
        final uploadTask2 = reference2.putData(imageData);
        final snapshot =
        await uploadTask2.whenComplete(() => print('report uploaded'));
        final downloadUrl2 = await snapshot.ref.getDownloadURL();
        print('Report URL: $downloadUrl2');
        report_url=downloadUrl2;
        // Save the image to a file
        // File imageFile = File('path/to/save/finalframe.jpg');
        // await imageFile.writeAsBytes(imageData);

        print('Final frame image downloaded successfully!');
      } else {
        print('Error fetching final frame image: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching final frame image: $e');
    }
    addCollectionAndDocument();
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
          'Accept-Encoding': 'gzip, deflate, br',
          'Content-Type': 'video/mp4'
        },
        body: videoFile.readAsBytesSync(),
      );
      print(response.statusCode);
      // check response status code
      if (response.statusCode == 200) {
        print('Video sent successfully!');
        uploadVideo('http://103.144.92.62/download', text_id);
        print(response.statusCode);
      } else {
        print(
            '\n|||||||||||||||Error sending video: ${response.statusCode}|||||||\n');
        print(response.statusCode);
      }
      print("FIN!!!");
    } catch (e) {
      print('Error sending video: $e');
    }
  }

  Future<void> addCollectionAndDocument() async {
    // Get reference to the document
    DocumentReference documentRef =
        FirebaseFirestore.instance.collection('patients').doc('${text_id}');

    // Create a new collection if it does not exist
    CollectionReference collectionRef = documentRef.collection('videos');
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);

    // Create a new document with url and date created fields
    await collectionRef.add({
      'url': '${logurl}',
      'date_created': now,
      'report_url': '${report_url}'
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future<void> _initVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.file(File(filePath));
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);

    final videoSize = _videoPlayerController.value.size;
    final videoWidth = videoSize.width;
    final videoHeight = videoSize.height;
    final aspectRatio = videoWidth / videoHeight;

    // Get the screen's aspect ratio
    final screenAspectRatio =
        MediaQuery.of(context).size.width / MediaQuery.of(context).size.height;

    // Calculate the target width and height of the video to maintain aspect ratio
    double targetWidth;
    double targetHeight;
    if (aspectRatio > screenAspectRatio) {
      targetWidth = MediaQuery.of(context).size.width;
      targetHeight = targetWidth / aspectRatio;
    } else {
      targetHeight = MediaQuery.of(context).size.height;
      targetWidth = targetHeight * aspectRatio;
    }

    // Set the video player's volume and play it
    await _videoPlayerController.setVolume(1.0);
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
              sendVideo("http://103.144.92.62/success", File(filePath));

              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => patientprofile(
                      text_name,
                      text_id,
                      text_dob,
                      text_gender,
                      text_height,
                      text_phone,
                      text_profurl,
                      text_weight,
                  )));
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: _initVideoPlayer(),
        builder: (context, state) {
          if (state.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return AspectRatio(
              aspectRatio: _videoPlayerController.value.aspectRatio,
              child: VideoPlayer(_videoPlayerController),
            );
          }
        },
      ),
    );
  }
}
