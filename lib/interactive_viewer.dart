import 'dart:math';

import 'package:flutter/material.dart';

class MyInteractiveViewerWidget extends StatefulWidget {
  @override
  _MyInteractiveViewerWidgetState createState() =>
      _MyInteractiveViewerWidgetState();
}

class _MyInteractiveViewerWidgetState extends State<MyInteractiveViewerWidget> {
  var transformationController = TransformationController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InteractiveViewer(
        boundaryMargin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width,
            vertical: MediaQuery.of(context).size.height),
        transformationController: transformationController,
        onInteractionStart: (details) {
          transformationController.value = Matrix4.rotationZ(-pi / 25.0);
        },
        onInteractionEnd: (details) {
          transformationController.value = Matrix4.identity();
        },
        child: Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.orange, Colors.red],
                  stops: [0.1, 1.0])),
        ),
      ),
    );
  }
}
