import 'package:backgammon/entities/Soldier.entity.dart';
import 'package:backgammon/providers/BoardConstants.provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'Soldier.dart';

class ExitCell extends StatelessWidget {
  final String id;
  final bool isRotated;
  final List<SoldierEntity> soldiers;
  
  ExitCell({this.id, this.isRotated, this.soldiers});

  @override
  Widget build(BuildContext context) {
    final boardConstants = Provider.of<BoardConstants>(context);
    return RotatedBox(
      quarterTurns: isRotated ? 2 : 0,
      child: Stack(
        children: <Widget>[
          Container(
            width: boardConstants.exitCellWidth,
            height: boardConstants.rowHeight + 10,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
            ),
          ),
          Container(
            width: boardConstants.exitCellWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                if (soldiers.isNotEmpty) ...soldiers.map((soldier) => Soldier(soldier)).toList(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
