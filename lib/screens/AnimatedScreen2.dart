import 'package:flutter/material.dart';

class AnimatedScreen2 extends StatefulWidget {
  @override
  _AnimatedScreenState createState() => _AnimatedScreenState();
}

class _AnimatedScreenState extends State<AnimatedScreen2>
    with TickerProviderStateMixin {
  Animation _containerRadiusAnimation,
      _containerSizeAnimation,
      _containerColorAnimation;
  AnimationController _containerAnimationController;

  @override
  void initState() {
    super.initState();
    _containerAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 7000));

    _containerRadiusAnimation = BorderRadiusTween(
            begin: BorderRadius.circular(100.0),
            end: BorderRadius.circular(0.0))
        .animate(CurvedAnimation(
            curve: Curves.ease, parent: _containerAnimationController));

    _containerSizeAnimation = Tween(begin: 0.0, end: 2.0).animate(
        CurvedAnimation(
            curve: Curves.ease, parent: _containerAnimationController));

    _containerColorAnimation =
        ColorTween(begin: Colors.black, end: Colors.white).animate(
            CurvedAnimation(
                curve: Curves.ease, parent: _containerAnimationController));

    _containerAnimationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _containerAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated Screen 2'),
        backgroundColor: Colors.pink,
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _containerAnimationController,
          builder: (context, index) {
            return Container(
              transform: Matrix4.translationValues(
                  _containerSizeAnimation.value * width - 250.0, 0.0, 0.0),
              width: _containerSizeAnimation.value * height,
              height: _containerSizeAnimation.value * height,
              decoration: BoxDecoration(
                  borderRadius: _containerRadiusAnimation.value,
                  color: _containerColorAnimation.value),
              child: Center(
                child: Image.network(
                    'https://umbrella.green/wp-content/uploads/2019/02/1_1_1550684361878.jpg'),
              ),
            );
          },
        ),
      ),
    );
  }
}
