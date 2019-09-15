import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../entities/Dice.entity.dart';
import '../../providers/BoardConstants.provider.dart';
import '../../providers/Dices.provider.dart';
import './Dice.dart';

class Dices extends StatefulWidget {
  @override
  _DicesState createState() => _DicesState();
}

class _DicesState extends State<Dices> with TickerProviderStateMixin {
  AnimationController _angleController;
  Animation<double> _angleAnimation;

  void _rollDice(DiceEntity dice) {
    _angleController.forward();
    Future.delayed(const Duration(milliseconds: 500), () {
      _angleController.reverse();
    });
  }

  @override
  void initState() {
    super.initState();
    _angleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 900),
      reverseDuration: Duration(milliseconds: 0),
    );
    _angleAnimation = Tween<double>(begin: 0.0, end: math.pi * 6).animate(
        CurvedAnimation(parent: _angleController, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    final boardConstants = Provider.of<BoardConstants>(context, listen: false);
    final dicesProvider = Provider.of<DicesProvider>(context);
    if (dicesProvider.dicesRolling) {
      _rollDice(dicesProvider.dices[0]);
      _rollDice(dicesProvider.dices[1]);
    }

    return Container(
      height: double.infinity,
      width: boardConstants.rowWidth,
      margin: EdgeInsets.only(left: boardConstants.cellWidth * 0.1),
      padding: EdgeInsets.symmetric(horizontal: boardConstants.cellWidth * 1.6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Dice(_angleAnimation, dicesProvider.dices[0].number),
          Dice(_angleAnimation, dicesProvider.dices[1].number),
        ],
      ),
    );
  }
}
