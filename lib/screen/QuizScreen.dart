// @dart=2.9
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../themeColor.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:just_audio/just_audio.dart';

import 'MarkScreen.dart';

class QuizScreen extends StatefulWidget {
  final String category ;

  QuizScreen({
    this.category
  });

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class Question {
  Question(this.imgLink, this.answers);

  final String imgLink;

  final String answers;

  String toString() => 'Question { text: $imgLink, answers: $answers }';
}

class _QuizScreenState extends State<QuizScreen> {
   AudioPlayer player;
  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    super.initState();
    _speech = stt.SpeechToText();
    if (widget.category.toString() == 'vehicle'){
      currentList = vehicle;
    }else if(widget.category.toString() == 'color'){
      currentList = color;
    }else if(widget.category.toString() == 'animal'){
      currentList = animal;
    }else if(widget.category.toString() == 'fruit'){
      currentList = fruit;
    }
    score = [0,0,0,0,0,0,0];
  }
  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  stt.SpeechToText _speech;
  bool _isListening = false;
  bool visible = false;
  double _confidence = 1.0;

  int i = 0;
  int max = 6;
  List score = [0,0,0,0,0,0,0];

  String imageLink = '';
  String _text = '';
  FlutterTts flutterTts = FlutterTts();
  List currentList;
  bool mark = false;


  final vehicle = [
    Question('coupe.png', 'coupe'),
    Question('campervan.png', 'campervan'),
    Question('pickup.png', 'pickup'),
    Question('sedan.png', 'sedan'),
    Question('supercar.png', 'supercar'),
    Question('van.png', 'van'),
    Question('limo.png', 'limo'),
  ];

  final color = [
    Question('black.png', 'black'),
    Question('blue.png', 'blue'),
    Question('brown.png', 'brown'),
    Question('green.png', 'green'),
    Question('pink.png', 'pink'),
    Question('purple.png', 'purple'),
    Question('orange.png', 'orange'),
  ];

  final animal = [
    Question('cow.png', 'cow'),
    Question('frog.png', 'frog'),
    Question('monkey.png', 'monkey'),
    Question('octopus.png', 'octopus'),
    Question('panda.png', 'panda'),
    Question('zebra.png', 'zebra'),
    Question('snake.png', 'snake'),
  ];

  final fruit = [
    Question('apple.png', 'apple'),
    Question('avocado.png', 'avocado'),
    Question('kiwi.png', 'kiwi'),
    Question('mangosteen.png', 'mangosteen'),
    Question('lemon.png', 'lemon'),
    Question('strawberry.png', 'strawberry'),
    Question('watermelon.png', 'watermelon'),
  ];

  onButtonPressed(String value) {
    setState(() {
      i++;
       });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,

          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(

                  height : MediaQuery.of(context).size.height / 6 * 5,
                  decoration: BoxDecoration(
                    borderRadius: new BorderRadius.only(
                      bottomLeft: const Radius.circular(40.0),
                      bottomRight: const Radius.circular(40.0),
                    ),
                    color: ThemeColor.Light,
                  ),
                  child: (
                  Column(
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
                                    // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                                      icon: FaIcon(
                                        FontAwesomeIcons.arrowLeft,
                                        size: 18.0,
                                      ),
                                      color: ThemeColor.PrimaryColor,
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      }),
                                  Text(
                                        widget.category.toString().toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Winkle',
                                        color: ThemeColor.PrimaryColor),
                                  ),


                                ],
                              ),
                              SizedBox(
                                height: 80,
                              ),
                              mark ?
                              Text(
                                'Correct!' ,
                                style: TextStyle(
                                    fontSize: 60.0,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Winkle',
                                    color: Colors.green),
                              ):
                              Text(
                                  visible? 'Try Again!' : ' ',
                                style: TextStyle(
                                    fontSize: 60.0,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Winkle',
                                    color: Colors.red),
                              )
                              ,
                              Image.asset('images/'+ widget.category.toString() + '/' + currentList[i].imgLink,
                                height: 300,
                                width: 300,
                              ),
                              Text(
                                 _text.toUpperCase(),
                                style : TextStyle(
                                  fontSize: 40.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                    letterSpacing: 3.0,
                                    fontFamily: 'Ubuntu'
                                ),
                              ),
                          ]),
                        ),
                      ),
                    ],
                  )
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          i--;
                          _text = '';
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(
                          Icons.arrow_back_sharp,
                          color: Colors.white,
                          size: 35.0,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: CircleBorder(), primary: Colors.redAccent),
                    ),
                    visible: i > 0 ? true : false,
                  ),


                  ElevatedButton(
                    onPressed: _listen,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(_isListening ? Icons.mic : Icons.mic_none,
                        color: Colors.white,
                        size: 35.0,
                      )
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: CircleBorder(), primary: _isListening ? Colors.deepPurple : Colors.blueAccent),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _text = currentList[i].answers;
                        flutterTts.setSpeechRate(0.3);
                        flutterTts.speak(_text);
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.volume_up_rounded,
                        color: Colors.white,
                        size: 35.0,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: CircleBorder(), primary: Colors.lightGreen),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                       if(mark == true){
                         score[i] = 1;
                       }else{
                         score[i] = 0;
                       }
                        if(i == 6){
                              Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => MarkScreen(score : score)));
                              }else{
                          i++;
                          _text = '';
                          mark = false;
                          visible = false;
                        }
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                        size: 35.0,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: CircleBorder(), primary: Colors.redAccent),
                  ),

                ],
              )
            ],
          ),
        ),
      )
    );
  }

  void _listen() async {
    print("here here");
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        print("here here");
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;

            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
              setState(() => _isListening = false);
              _speech.stop();
              visible = true;
              if (_text.toLowerCase() == currentList[i].answers.toLowerCase()){
                mark = true;
                 player.setAsset('assets/audio/correct.mp3');
                player.play();
              }else{
                mark = false;
                player.setAsset('assets/audio/wrong.mp3');
                player.play();
              }
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }
}
