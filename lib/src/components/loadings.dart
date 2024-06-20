import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Widget floatingLoading() {
  return Container(
    color: Colors.black.withOpacity(0.3),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoadingAnimationWidget.fourRotatingDots(
              color: Colors.white, size: 30),
          const SizedBox(height: 5),
          const DefaultTextStyle(
              style: TextStyle(
                color: Colors.white
              ), child: Text("Loading..."))
        ],
      ),
    ),
  );
}