import 'dart:async';
import 'dart:math' as math;
import 'package:backgammon/entities/Dice.entity.dart';
import 'package:flutter/widgets.dart';

class DicesProvider with ChangeNotifier {
  bool dicesRolling = false;
  int doubleCount = 0;
  List<DiceEntity> dices = [
    DiceEntity(0),
    DiceEntity(1),
  ];

  DicesProvider();

  void rotateDices() {
    _rollDice(dices[0]);
    _rollDice(dices[1]);
  }

  void _rollDice(DiceEntity dice) {
    int _counter = 0;
    dicesRolling = true;
    Timer.periodic(
        Duration(milliseconds: 60),
        (timer) => {
              _counter++,
              if (_counter > 5) {timer.cancel()},
              dice.number = math.Random().nextInt(7),
              notifyListeners()
            });
    Future.delayed(const Duration(milliseconds: 700), () {
      dicesRolling = false;
      notifyListeners();
    });
    notifyListeners();
  }
}
