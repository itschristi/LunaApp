// @dart=2.9

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../themeColor.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File _image;
  List _recognitions;
  bool _busy;
  double _imageWidth, _imageHeight;
  List<String> objectList = [];
  String objectStr = '';
  String path = '';
  FlutterTts flutterTts = FlutterTts();
  final picker = ImagePicker();

  loadTfModel() async {
    await Tflite.loadModel(
      model: "assets/models/ssd_mobilenet.tflite",
      labels: "assets/models/labels.txt",
    );
  }

  // this function detects the objects on the image
  detectObject(File image) async {
    var recognitions = await Tflite.detectObjectOnImage(
        path: image.path,       // required
        model: "SSDMobileNet",
        imageMean: 127.5,
        imageStd: 127.5,
        threshold: 0.4,       // defaults to 0.1
        numResultsPerClass: 10,// defaults to 5
        asynch: true          // defaults to true
    );
    FileImage(image)
        .resolve(ImageConfiguration())
        .addListener((ImageStreamListener((ImageInfo info, bool _) {
      setState(() {
        _imageWidth = info.image.width.toDouble();
        _imageHeight = info.image.height.toDouble();
      });
    })));

    setState(() {
      objectList = [];
      _recognitions = recognitions;
      print(_recognitions.toString());
      var num = _recognitions.length;
      for (int i = 0; i <_recognitions.length; i++){
        if(!objectList.contains(_recognitions[i]["detectedClass"].toString()) &&
            _recognitions[i]["confidenceInClass"] > 0.5){
          objectList.add(_recognitions[i]["detectedClass"].toString());
        }
      }
       objectStr = objectList.join(', ');
      print(objectStr);

      flutterTts.setSpeechRate(0.5);
      flutterTts.speak(objectStr);
    });
  }

  @override
  void initState() {
    super.initState();
    _busy = true;
    loadTfModel().then((val) {{
      setState(() {
        _busy = false;
      });
    }});
  }

  List<Widget> renderBoxes(Size screen) {
    if (_recognitions == null) return [];
    if (_imageWidth == null || _imageHeight == null) return [];

    double factorX = 550.0;
    double factorY = _imageHeight / _imageHeight * 550.0;


    return _recognitions.map((re) {
      return Container(
        child: Positioned(
            left: re["rect"]["x"] * factorX,
            top: re["rect"]["y"] * factorY,
            width: re["rect"]["w"] * factorX,
            height: re["rect"]["h"] * factorY,
            child: ((re["confidenceInClass"] > 0.50))? Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: ThemeColor.Red,
                    width: 3,
                  )
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${re["detectedClass"]}".toUpperCase(),

                  style: TextStyle(
                    background: Paint()..color = ThemeColor.Red
                      ..strokeWidth = 17
                      ..style = PaintingStyle.stroke,
                    color: Colors.white,
                    fontSize: 15,

                  ),
                ),
              ),
            ) :
            Container()
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    List<Widget> stackChildren = [];

    stackChildren.add(
        Positioned(
          // using ternary operator
          child: _image == null ?
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: ThemeColor.Yellow
              ),
              height: 550,
              width: 800,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 250),
                  Text(
                    "Please capture an image"
                  ),
                ],
              ),


            ),
          )
              : // if
        // not null then
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  fit:BoxFit.fill,
                  image: FileImage(_image),
                ),
              ),

              height: 550,
            ),
          ),
        )
    );

    stackChildren.addAll(renderBoxes(size));

    if (_busy) {
      stackChildren.add(
          Center(
            child: CircularProgressIndicator(),
          )
      );
    }


    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                              icon: FaIcon(
                                FontAwesomeIcons.arrowLeft,
                                size: 18.0,
                              ),
                              color: ThemeColor.PrimaryColor,
                              onPressed: () {
                                Navigator.of(context).pop();
                              }),
                          Text(
                            'Camera',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500,
                                color: ThemeColor.PrimaryColor),
                          ),


                        ],
                      ),
                      Container(
                        alignment: Alignment.center,
                        child:Stack(
                          children: stackChildren,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical:0,horizontal: 80),
                        child: Row(
                          children: [
                            MaterialButton(
                              onPressed: () {
                                getImageFromCamera();
                              },
                             color: ThemeColor.DarkGreen,
                              textColor: Colors.white,
                              child: Icon(
                                Icons.camera_alt,
                                size: 24,
                              ),
                              padding: EdgeInsets.all(16),
                              shape: CircleBorder(),
                            ),
                            MaterialButton(
                              onPressed: () {
                                flutterTts.setSpeechRate(0.5);
                                flutterTts.speak(objectStr);
                              },
                              color:  ThemeColor.Red,
                              textColor: Colors.white,
                              child: Icon(
                                Icons.speaker_phone,
                                size: 24,
                              ),
                              padding: EdgeInsets.all(16),
                              shape: CircleBorder(),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if(pickedFile != null) {
        _image = File(pickedFile.path);
        path = pickedFile.path;
        print(_image);
        print(path);
      } else {
        print("No image Selected");
      }
    });
    detectObject(_image);
  }

}
