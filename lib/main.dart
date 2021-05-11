import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animations/screens/AnimatedScreen1.dart';
import 'package:flutter_animations/screens/AnimatedScreen2.dart';

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  Animation _arrowAnimation, _heartAnimation;
  AnimationController _arrowAnimationController, _heartAnimationController;

  @override
  void initState() {
    super.initState();
    _arrowAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _arrowAnimation =
        Tween(begin: 0.0, end: pi).animate(_arrowAnimationController);

    _heartAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1200));
    _heartAnimation = Tween(begin: 150.0, end: 170.0).animate(CurvedAnimation(
        curve: Curves.bounceOut, parent: _heartAnimationController));

    _heartAnimationController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _heartAnimationController.repeat();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _arrowAnimationController?.dispose();
    _heartAnimationController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animations'),
        backgroundColor: Colors.pink,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          expandIconAnimation(),
          SizedBox(height: 50.0),
          heartAnimation(),
          SizedBox(height: 50.0),
          OutlineButton(
            color: Colors.white,
            textColor: Colors.black,
            padding: const EdgeInsets.all(12.0),
            child: Text('Show Animation page 1'),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AnimatedScreen1()));
            },
            splashColor: Colors.red,
          ),
          SizedBox(height: 50.0),
          OutlineButton(
            color: Colors.white,
            textColor: Colors.black,
            padding: const EdgeInsets.all(12.0),
            child: Text('Show Animation page 2'),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AnimatedScreen2()));
            },
            splashColor: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget expandIconAnimation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        AnimatedBuilder(
          animation: _arrowAnimationController,
          builder: (context, child) => Transform.rotate(
            angle: _arrowAnimation.value,
            child: Icon(
              Icons.expand_more,
              size: 50.0,
              color: Colors.black,
            ),
          ),
        ),
        OutlineButton(
          color: Colors.white,
          textColor: Colors.black,
          padding: const EdgeInsets.all(12.0),
          child: Text('Rotate'),
          onPressed: () {
            _arrowAnimationController.isCompleted
                ? _arrowAnimationController.reverse()
                : _arrowAnimationController.forward();
          },
          splashColor: Colors.red,
        )
      ],
    );
  }

  Widget heartAnimation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            _heartAnimationController.isAnimating
                ? _heartAnimationController.stop()
                : _heartAnimationController.forward();
          },
          child: Expanded(
            child: AnimatedBuilder(
              animation: _heartAnimationController,
              builder: (context, child) {
                return Center(
                  child: Container(
                    child: Center(
                      child: Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: _heartAnimation.value,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        // Expanded(
        //   child: Padding(
        //     padding: const EdgeInsets.only(right: 12.0),
        //     child: OutlineButton(
        //       padding: const EdgeInsets.all(12.0),
        //       color: Colors.white,
        //       textColor: Colors.black,
        //       child: Text('Beating Heart Animation (start/stop)'),
        //       onPressed: () {
        //         _heartAnimationController.isAnimating
        //             ? _heartAnimationController.stop()
        //             : _heartAnimationController.forward();
        //       },
        //       splashColor: Colors.red,
        //     ),
        //   ),
        // )
      ],
    );
  }
}
