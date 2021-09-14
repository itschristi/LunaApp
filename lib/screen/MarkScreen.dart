// @dart=2.9

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../themeColor.dart';
import 'NavigationScreen.dart';

class MarkScreen extends StatefulWidget {

  final List score ;

  MarkScreen({
    this.score
  });


  @override
  _MarkScreenState createState() => _MarkScreenState();
}

class _MarkScreenState extends State<MarkScreen> {
  int count = 0;
  String comment = '';
  int imgStatus = 0;

  void initState() {
    for (int i = 0; i < widget.score.length; i++) {
      if (widget.score[i] == 1) {
        count++;
      }
    }

    print("Count" + count.toString());
    if(count ==7){
      comment = 'Congratulations!';
      imgStatus = 1;
    }else if(count >= 4){
      comment = 'Good Job!';
      imgStatus = 2;
    }else{
      comment = 'Good Try!';
      imgStatus = 3;
    }

  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
              height : MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: ThemeColor.Light,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('images/mark/'+ imgStatus.toString() +'.png',
                  height: 300,
                  width: 300,
                ),
                Text(
                  comment,
                  style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Winkle',
                      color: ThemeColor.PrimaryColor),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'SCORE :',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Ubuntu',
                      color: ThemeColor.PrimaryColor),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  count.toString() + ' out of 7',
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Ubuntu',
                      color: ThemeColor.PrimaryColor),
                ),
                SizedBox(
                  height: 60,
                ),
                ElevatedButton(
                  onPressed: () {

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => NavigationScreen()),
                          (Route<dynamic> route) => false,
                    );
                  },
                  child: Text('BACK TO HOME',
                  style:TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Winkle',
                  )),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.deepOrange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}
