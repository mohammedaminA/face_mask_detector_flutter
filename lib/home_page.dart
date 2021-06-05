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
      if (!mounted) {
        return;
      }
      setState(() {
        cameraController.startImageStream((imageFromStream) => {
              if (!isWorking)
                {
                  isWorking = true,
                  cameraImg = imageFromStream,
                }
            });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    initCamera();
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
                child: Text(''),
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
                        child: CameraPreview(cameraController.),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
