import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'main.dart';

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
      if(!mounted) {
        return;
      }
      setState(() {
              cameraController.startImageStream((imageFromStream) => 
            {
              if(!isWorking)
              {
                isWorking = true,
                cameraImg = imageFromStream,
              }
            
            });
      });  
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}