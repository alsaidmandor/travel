import 'package:flutter/material.dart';

class ScaleTransitionRoute extends PageRouteBuilder {
  final page;

  ScaleTransitionRoute({this.page})
      : super(
            transitionDuration: Duration(seconds: 2),
            pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) =>
                page,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var begin = 0.0;
              var end = 1.0;
              var tween = Tween(begin: begin, end: end);
              var curveAnimation =
                  CurvedAnimation(parent: animation, curve: Curves.easeIn);
              return ScaleTransition(
                scale: tween.animate(curveAnimation),
                child: child,
              );
            });
}

class SlideTransitionRoute extends PageRouteBuilder {
  final page;

  SlideTransitionRoute({this.page})
      : super(
          transitionDuration: Duration(seconds: 2),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = Offset(1.0, 0.0);
            var end = Offset(0, 0);
            var tween = Tween(begin: begin, end: end);
            //  var ofSetAnimation =animation.drive(tween);
            var curveAnimation = CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut); // the best from before line
            return SlideTransition(
              position: tween.animate(curveAnimation),
              child: child,
            );
          },
        );
}

class SlideTransitionBottomRoute extends PageRouteBuilder {
  final page;

  SlideTransitionBottomRoute({this.page})
      : super(
          transitionDuration: Duration(seconds: 2),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = Offset(0.0, 1.0);
            var end = Offset(0, 0);
            var tween = Tween(begin: begin, end: end);
            //  var ofSetAnimation =animation.drive(tween);
            var curveAnimation = CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOutBack); // the best from before line
            return SlideTransition(
              position: tween.animate(curveAnimation),
              child: child,
            );
          },
        );
}
