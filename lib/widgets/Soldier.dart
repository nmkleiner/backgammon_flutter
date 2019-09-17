import 'package:backgammon/entities/Soldier.entity.dart';
import 'package:backgammon/providers/BoardConstants.provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Soldier extends StatelessWidget {
  final SoldierEntity soldier;

  Soldier(this.soldier);

  Color get _soldierColor {
    if (soldier.isSelected) {
      return Colors.yellowAccent;
    } else {
      return soldier.color == Colors.white ? Colors.black : Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    final boardConstants = Provider.of<BoardConstants>(context);
    return Container(
      height: boardConstants.soldierRadius * 2,
      width: boardConstants.soldierRadius * 2,
      decoration: BoxDecoration(
        color: soldier.color,
        borderRadius: BorderRadius.circular(boardConstants.soldierRadius),
        border: Border.all(color: _soldierColor, width: 2),
      ),
      child: Text(
        soldier.id.toString(),
        style: TextStyle(color: Colors.blueAccent, fontSize: 20),
      ),
    );
  }
}
