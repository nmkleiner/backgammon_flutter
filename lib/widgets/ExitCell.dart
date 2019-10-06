import 'package:backgammon/entities/Soldier.entity.dart';
import 'package:backgammon/providers/BoardConstants.provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'Soldier.dart';

class ExitCell extends StatelessWidget {
  final String id;
  final bool isRotated;
  final List<SoldierEntity> soldiers;
  final bool isPossibleMove;
  final Animation soldierAnimation;

  ExitCell({this.id, this.isRotated, this.soldiers, this.isPossibleMove, this.soldierAnimation});

  @override
  Widget build(BuildContext context) {
    final boardConstants = Provider.of<BoardConstants>(context);
    Color color = isPossibleMove ? Color.fromRGBO(50, 200, 50, 1) : Colors.transparent;

    return RotatedBox(
      quarterTurns: isRotated ? 2 : 0,
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
            ),
          ),
          Container(
            width: boardConstants.exitCellWidth,
            height: boardConstants.rowHeight + 10,
            color: color,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                if (soldiers.isNotEmpty)
                  ...soldiers.map((soldier) => Soldier(soldier, isRotated, soldierAnimation)).toList(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
