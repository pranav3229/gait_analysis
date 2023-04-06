//import 'dart:html';
//not in use
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gait_analysis/homescreen.dart';

import 'preview.dart';

class ScanPage extends StatefulWidget {
  late String text_name;
  late String text_id;
  late String text_dob;
  late String text_gender;
  late String text_height;
  late String text_phone;
  late String text_profurl;
  late String text_weight;
  // const ScanPage({Key? key}) : super(key: key);
  ScanPage(this.text_name, this.text_id, this.text_dob, this.text_gender,
      this.text_height, this.text_phone, this.text_profurl, this.text_weight);

  @override
  ScanPageState createState() => ScanPageState(
      this.text_name,
      this.text_id,
      this.text_dob,
      this.text_gender,
      this.text_height,
      this.text_phone,
      this.text_profurl,
      this.text_weight);
}

class ScanPageState extends State<ScanPage> {
  late String text_name;
  late String text_id;
  late String text_dob;
  late String text_gender;
  late String text_height;
  late String text_phone;
  late String text_profurl;
  late String text_weight;
  ScanPageState(this.text_name, this.text_id, this.text_dob, this.text_gender,
      this.text_height, this.text_phone, this.text_profurl, this.text_weight);
  // ScanPageState(this.text_id);
  bool _isLoading = true;
  bool _isRecording = false;
  late CameraController _cameraController;

  @override
  void initState() {
    _initCamera();
    super.initState();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  _initCamera() async {
    final cameras = await availableCameras();
    final back = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front);
    _cameraController = CameraController(back, ResolutionPreset.max);
    await _cameraController.initialize();
    setState(() => _isLoading = false);
  }

  _recordVideo() async {
    if (_isRecording) {
      final file = await _cameraController.stopVideoRecording();
      setState(() => _isRecording = false);
      final route = MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => PreviewPage(file.path,text_name, text_id, text_dob,
            text_gender, text_height, text_phone, text_profurl, text_weight),
      );
      Navigator.push(context, route);
    } else {
      await _cameraController.prepareForVideoRecording();
      await _cameraController.startVideoRecording();
      setState(() => _isRecording = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          leading: BackButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => homescreen()));
              },
              color: Colors.black),
          centerTitle: true,
          backgroundColor: Colors.green,
          title: Text('Record Video'),
        ),
        body: Container(
          color: Colors.white,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          leading: BackButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => homescreen()));
              },
              color: Colors.black),
          centerTitle: true,
          backgroundColor: Colors.green,
          title: Text('Record Video'),
        ),
        body: Center(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CameraPreview(_cameraController),
              Padding(
                padding: const EdgeInsets.all(25),
                child: FloatingActionButton(
                  backgroundColor: Colors.red,
                  child: Icon(_isRecording ? Icons.stop : Icons.circle),
                  onPressed: () => _recordVideo(),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
