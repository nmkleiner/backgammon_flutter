import 'package:backgammon/entities/Soldier.entity.dart';
import 'package:backgammon/providers/BoardConstants.provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Soldier extends StatelessWidget {
  final SoldierEntity soldier;
  final bool isRotated;

  Soldier(this.soldier, this.isRotated);

  Color get _soldierBorderColor {
    if (soldier.isSelected) {
      return soldier.color == Colors.white ? Colors.blue : Colors.yellowAccent;
    } else {
      return soldier.color == Colors.white ? Colors.black : Colors.white;
    }
  }

  bool get isInExitCell {
    return soldier.cellId == 'whiteExitCell' ||
        soldier.cellId == 'blackExitCell';
  }

  @override
  Widget build(BuildContext context) {
    final boardConstants = Provider.of<BoardConstants>(context);
    if (isInExitCell)
      return Container(
          width: boardConstants.soldierRadius * 2,
          height: boardConstants.soldierRadius * 0.8,
          decoration: BoxDecoration(
            color: soldier.color,
            border: Border.all(color: _soldierBorderColor, width: 1),
          ));
    else
      return Container(
        height: boardConstants.soldierRadius * 2,
        width: boardConstants.soldierRadius * 2,
        decoration: BoxDecoration(
          color: soldier.color,
          borderRadius: BorderRadius.circular(boardConstants.soldierRadius),
          border: Border.all(color: _soldierBorderColor, width: 2),
        ),
      );
  }
}
