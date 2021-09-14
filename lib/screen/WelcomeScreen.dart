// @dart=2.9

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../themeColor.dart';
import 'QuizScreen.dart';
import 'package:localstorage/localstorage.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key key}) : super(key: key);
  static String id = 'WelcomeScreen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final LocalStorage storage = new LocalStorage('luna_storage');
  void initState() {
    super.initState();
    storage.setItem('name', 'Luna');
  }

  TextEditingController _textFieldController = TextEditingController();
  String codeDialog;
  String valueText;

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Enter New Name'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Text Field in Dialog"),
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text('OK'),
                onPressed: () {
                  setState(() {
                    codeDialog = valueText;
                    storage.setItem('name', codeDialog);
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: (Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Image.asset(
                'images/logo/logo.png',
                height: 120,
                width: 120,
              ),
              Text("Welcome back",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  )),
              InkWell(
                onTap: () {
                  _displayTextInputDialog(context);
                },
                child: Text(
                    storage.getItem('name') != null
                        ? storage.getItem('name')
                        : 'Luna',
                    style: TextStyle(
                        fontSize: 80,
                        color: Colors.black,
                        fontFamily: 'Winkle')),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                QuizScreen(category: 'vehicle')));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 20, top: 10, right: 10, bottom: 10),
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: ThemeColor.Skin,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Center(
                            child: Column(
                              children: [
                                Image.asset(
                                  'images/thumbnail/vehicle.png',
                                  height: 100,
                                  width: 100,
                                ),
                                Text("Vehicle",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontFamily: 'Winkle')),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                QuizScreen(category: 'fruit')));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 10, top: 10, right: 20, bottom: 10),
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: ThemeColor.Yellow,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Center(
                            child: Column(
                              children: [
                                Image.asset(
                                  'images/thumbnail/fruit.png',
                                  height: 100,
                                  width: 100,
                                ),
                                Text("Fruit",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontFamily: 'Winkle')),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 20, top: 10, right: 10, bottom: 10),
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: ThemeColor.Green,
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  QuizScreen(category: 'animal')));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Center(
                            child: Column(
                              children: [
                                Image.asset(
                                  'images/thumbnail/animal.png',
                                  height: 100,
                                  width: 100,
                                ),
                                Text("Animal",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontFamily: 'Winkle')),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 5,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  QuizScreen(category: 'color')));
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 10, top: 10, right: 20, bottom: 10),
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: ThemeColor.Purple,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Center(
                              child: Center(
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'images/thumbnail/color.png',
                                      height: 100,
                                      width: 100,
                                    ),
                                    Text("Color",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontFamily: 'Winkle')),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ))
                ],
              )
            ],
          ))),
    );
  }
}
