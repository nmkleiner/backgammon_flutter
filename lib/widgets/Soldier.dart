import 'package:backgammon/entities/Soldier.entity.dart';
import 'package:backgammon/providers/BoardConstants.provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Soldier extends StatefulWidget {
  final SoldierEntity soldier;
  Soldier(this.soldier);

  @override
  _SoldierState createState() => _SoldierState();
}

class _SoldierState extends State<Soldier> with TickerProviderStateMixin {
  AnimationController _moveController;
  Animation<Offset> _moveAnimation;

  @override
  void initState() {
    super.initState();
    _moveController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
      reverseDuration: Duration(seconds: 300),
    );

    _moveAnimation = Tween<Offset>(begin: Offset(0, 0), end: Offset(0, 1))
        .animate(_moveController);
  }

  @override
  void dispose() {
    _moveController.dispose();
    super.dispose();
  }

  Color get _soldierBorderColor {
    if (widget.soldier.isSelected) {
      return widget.soldier.color == Colors.white
          ? Colors.blue
          : Colors.yellowAccent;
    } else {
      return widget.soldier.color == Colors.white ? Colors.black : Colors.white;
    }
  }

  bool get isInExitCell {
    return widget.soldier.cellId == 'whiteExitCell' ||
        widget.soldier.cellId == 'blackExitCell';
  }

  @override
  Widget build(BuildContext context) {
    if (widget.soldier.isMoving) {
      _moveController.forward();
    } 
    final boardConstants = Provider.of<BoardConstants>(context);
    if (isInExitCell)
      return Container(
          width: boardConstants.soldierRadius * 2,
          height: boardConstants.soldierRadius * 0.8,
          decoration: BoxDecoration(
            color: widget.soldier.color,
            border: Border.all(color: _soldierBorderColor, width: 1),
          ));
    else
      return Container(
        width: boardConstants.soldierRadius * 2,
        height: boardConstants.soldierRadius * 2,
        child: Stack(children: <Widget>[
          SlideTransition(
            position: _moveAnimation,
            child: Container(
              height: boardConstants.soldierRadius * 2,
              width: boardConstants.soldierRadius * 2,
              decoration: BoxDecoration(
                color: widget.soldier.color,
                borderRadius:
                    BorderRadius.circular(boardConstants.soldierRadius),
                border: Border.all(color: _soldierBorderColor, width: 2),
              ),
            ),
          ),
        ]),
      );
  }
}
