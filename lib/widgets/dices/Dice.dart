import 'package:flutter/material.dart';

import 'Dot.dart';

class Dice extends StatelessWidget {
  final Animation<double> angleAnimation;
  final int diceNumber;

  Dice(this.angleAnimation, this.diceNumber);
  List<bool> get _dotsVisibilityStatus {
    switch (diceNumber) {
      case 1:
        return [false, false, false, true, false, false, false];
        break;
      case 2:
        return [true, false, false, false, false, false, true];
        break;
      case 3:
        return [true, false, false, true, false, false, true];
        break;
      case 4:
        return [true, false, true, false, true, false, true];
        break;
      case 5:
        return [true, false, true, true, true, false, true];
        break;
      case 6:
        return [true, true, true, false, true, true, true];
        break;
      default:
        return [true, true, true, false, true, true, true];
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> firstColumnDots = <Widget>[
      ..._dotsVisibilityStatus
          .sublist(0, 3)
          .map((isVisible) => Dot(isVisible))
          .toList()
    ];

    List<Widget> middleColumnDot = <Widget>[
      Dot(_dotsVisibilityStatus[3]),
    ];

    List<Widget> lastColumnDots = <Widget>[
      ..._dotsVisibilityStatus
          .sublist(4, 7)
          .map((isVisible) => Dot(isVisible))
          .toList()
    ];

    return AnimatedBuilder(
      animation: angleAnimation,
      builder: (ctx, ch) => Transform.rotate(
        angle: angleAnimation.value,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: firstColumnDots,
              ),
              Spacer(),
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: middleColumnDot),
              Spacer(),
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: lastColumnDots),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
