import 'package:flutter/material.dart';

void main() => runApp(FlutterCreate());

class FlutterCreate extends StatefulWidget {
  @override
  Legends createState() => Legends();
}

class Legends extends State<FlutterCreate> with TickerProviderStateMixin {
  double _rotationAngle = 0;
  AnimationController animationController;
  Animation animation;
  @override
  void initState() {
    animationController =
        new AnimationController(duration: Duration(seconds: 8), vsync: this);
    animation =
        IntTween(begin: 0, end: photos.length - 1).animate(animationController)
          ..addListener(() {
            setState(() {
              photoindex = animation.value;
            });
          });
    animationController.repeat();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  int photoindex = 0;
  List<String> photos = [
    "images/1.png",
    "images/2.png",
    "images/3.png",
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: NotificationListener(
          onNotification: (notification) {
            if (notification is ScrollUpdateNotification) {
              setState(() {
                double newSpeed = notification.scrollDelta * 0.03;
                double deltaSpeed =
                    (newSpeed.abs() - _rotationAngle.abs()).abs();
                if (newSpeed.abs() < 0.8) {
                  if (deltaSpeed <= 0.3) {
                    _rotationAngle = -1 * newSpeed;
                  }
                }
              });
            }
          },
          child: PageView.builder(
              itemCount: 10,
              itemBuilder: (_, index) {
                return Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(_rotationAngle),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 170.0,
                        bottom: 59,
                        child: Container(
                          height: 500,
                          width: 371,
                          margin: EdgeInsets.only(right: 30),
                          decoration: BoxDecoration(
                              color: Colors.yellow[700],
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(35),
                                  topRight: Radius.circular(35)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black87,
                                    blurRadius: 30,
                                    offset: Offset(20, 20)
                                    //     ,spreadRadius: 3
                                    )
                              ]),
                          child: Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    "FlutterCreate",
                                    style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.black12, width: 2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                height: 144,
                                width: 286,
                              )),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          height: 500,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(photos[photoindex]))),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
