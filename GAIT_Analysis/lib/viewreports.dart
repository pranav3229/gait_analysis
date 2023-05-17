import 'package:flutter/material.dart';
import 'package:gait_analysis/videoplayerpage.dart';

class ViewReports extends StatefulWidget {
  final String textId;
  final String videoUrl;
  final String videoId;
  final String textName;
  final String reportUrl;

  ViewReports(
      this.textId, this.videoUrl, this.videoId, this.textName, this.reportUrl);

  @override
  _ViewReportsState createState() => _ViewReportsState();
}

class _ViewReportsState extends State<ViewReports> {
  final TransformationController _transformationController =
  TransformationController();

  void _resetImage() {
    _transformationController.value = Matrix4.identity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => VideoPlayerPage(
                widget.videoUrl,
                widget.textId,
                widget.videoId,
                widget.textName,
              ),
            ));
          },
          color: Colors.black,
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        title: Text('View Reports'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text(" Name: ${widget.textName}"),
            SizedBox(width: 20),
            Text("Patient ID: ${widget.textId}"),
            SizedBox(height: 80),
            Text("You can use your fingers to zoom in"),
            SizedBox(height: 80),
            InteractiveViewer(
              transformationController: _transformationController,
              minScale: 0.5,
              maxScale: 5.0,
              boundaryMargin: EdgeInsets.all(double.infinity),
              child: Container(
                height: 300,
                width: 368,
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(width: 5, color: Colors.green),
                ),
                child: Image.network(
                  widget.reportUrl,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _resetImage,
              child: Text('Reset Image'),
            ),
          ],
        ),
      ),
    );
  }
}
