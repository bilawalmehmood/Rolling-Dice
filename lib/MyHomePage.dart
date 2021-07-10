//import 'dart:js';
import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int leftD = 1;
  int rightD = 1;
  AnimationController _controller;
  CurvedAnimation _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animated();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  animated() {
    // _Controlor veriabls stores animated walue from 0 to 1 with i 5 second which defines blow
    _controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
// _animation veriables apply curved types animation on _controler Objected
    _animation=CurvedAnimation(parent: _controller,curve: Curves.elasticInOut);

    // addListner function is also run again and again when _controllor value is changed which defines blow
    _animation.addListener(() {
      setState(() {});
      print(_animation
          .value); // _controller.value is return animeted value which store
    });
    // its also call when animted value is complete mean uper Bound equal to 1 and give status=UperBound
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          leftD = Random().nextInt(6) + 1;
          rightD = Random().nextInt(6) + 1;
        });
        print("Completed");
        _controller
            .reverse(); // its change the value from uperBound to lowerBound (o to 1)
      }
    });
  }

  void _roll() {
    _controller
        .forward(); // its change the value from  lowerBound to UpperBound (1 to 0)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dices"),
      ),
      body: Container(
        //padding: EdgeInsets.symmetric(vertical: 200.0),
        color: Color(0xff2C6488),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(30.0),
                child: GestureDetector(
                  onDoubleTap: _roll,
                  child: Row(
                    children: [
                      Expanded(
                          child: Image(
                        height: 200 - (_animation.value) * 200,
                        image: AssetImage("assets/images/dice-${leftD}.png"),
                      )),
                      SizedBox(
                        width: 30.0,
                      ),
                      Expanded(
                          child: Image(
                        height: 200 - (_animation.value) * 200,
                        image: AssetImage("assets/images/dice-${rightD}.png"),
                      )),
                    ],
                  ),
                )),
            RaisedButton(child: Text("Click Me"), onPressed: _roll)
          ],
        ),
      ),
    );
  }
}
