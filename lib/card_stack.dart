import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class CardStack extends StatefulWidget {
  @override
  _CardStackState createState() => _CardStackState();
}

class _CardStackState extends State<CardStack> with TickerProviderStateMixin {
  var _alignment = Alignment(0.0, 0.0);
  var _rotateAngle = 0.0;
  final double limit = 0.5;

  AnimationController controller;
  AnimationController resetController;
  Animation<Alignment> animation;
  Animation<Alignment> resetAnimation;
  CurvedAnimation curvedAnimation;
  CurvedAnimation resetCurvedAnimation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    curvedAnimation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    resetController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    resetCurvedAnimation =
        CurvedAnimation(parent: resetController, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    controller.dispose();
    resetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          child: SizedBox(
            child: Transform.rotate(
                angle: _rotateAngle, child: Image.asset("assets/images/1.jpg")),
            width: 200,
            height: 350,
          ),
          alignment: _alignment,
        ),
        SizedBox.expand(
          child: GestureDetector(
            onPanUpdate: (details) {
              _alignment = Alignment.lerp(_alignment,
                  Alignment(details.delta.dx, details.delta.dy), pi / 150);
              _rotateAngle = (-pi / 180) * details.delta.dx;
              setState(() {});
            },
            onPanEnd: (details) {
              if (_alignment.x.abs() > limit) {
                resetAnimation =
                    AlignmentTween(begin: _alignment, end: Alignment(0.0, 0.0))
                        .animate(resetCurvedAnimation)
                          ..addListener(() {
                            setState(() {
                              _alignment = resetAnimation.value;
                            });
                          })
                          ..addStatusListener((status) {
                            if (status == AnimationStatus.completed) {
                              controller.reset();
                              resetController.reset();
                            }
                          });
                animation =
                    AlignmentTween(begin: _alignment, end: Alignment(3.5, 0.0))
                        .animate(curvedAnimation)
                          ..addListener(() {
                            setState(() {
                              _alignment = animation.value;
                            });
                          })
                          ..addStatusListener((status) {
                            if (status == AnimationStatus.completed) {
                              resetController.forward();
                            }
                          });
                controller.forward();
              } else if (_alignment.y.abs() > limit) {
              } else {
                _alignment = Alignment.center;
                _rotateAngle = 0.0;
              }
              setState(() {});
            },
          ),
        )
      ],
    );
  }
}
