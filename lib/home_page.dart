import 'dart:html';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'main.dart';
import 'package:tflite/tflite.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CameraImage cameraImg;

  CameraController cameraController;

  bool isWorking = false;

  String result = '';

  bool get mounted => null;

  initCamera() {
    cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {
        cameraController.startImageStream((imageFromStream) => {
              if (!isWorking)
                {
                  isWorking = true,
                  cameraImg = imageFromStream,
                  runModelOnFrame()
                }
            });
      });
    });
  }

  loadModel() async {
    Tflite.loadModel(model: 'assets/model.tflite', labels: 'assets/labels.txt');
  }

  runModelOnFrame() async {
    if (cameraImg != null) {
      var recognitions = await Tflite.runModelOnFrame(
        bytesList: cameraImg.planes.map((plane) {
          return plane.bytes;
        }).toList(),
        imageHeight: cameraImg.height,
        imageWidth: cameraImg.width,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        numResults: 1,
        threshold: 0.1,
        asynch: true,
      );
      result = '';

      recognitions.forEach((response) {
        result += response['label'] + '/n';
      });

      setState(() {
        result;
      });
      isWorking = false;
    }
  }

  @override
  void initState() {
    super.initState();
    initCamera();
    loadModel();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Padding(
              padding: EdgeInsets.only(top: 40),
              child: Center(
                child: Text(
                  result,
                  style: TextStyle(
                    backgroundColor: Colors.black54,
                    fontSize: 30,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          body: Column(
            children: [
              Positioned(
                width: size.width,
                height: size.height - 100,
                child: (!cameraController.value.isInitialized)
                    ? Container()
                    : AspectRatio(
                        aspectRatio: cameraController.value.aspectRatio,
                        child: CameraPreview(cameraController),
                      ),
              ),
              Text(result,
                  style: TextStyle(
                      backgroundColor: Colors.black54,
                      fontSize: 30,
                      color: Colors.white),
                      textAlign: TextAlign.center,
                      )
            ],
          ),
        ),
      ),
    );
  }
}
