import 'package:backgammon/entities/Soldier.entity.dart';
import 'package:backgammon/providers/BoardConstants.provider.dart';
import 'package:backgammon/widgets/Soldier.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class MiddleCell extends StatelessWidget {
  final String id;
  final bool isRotated;
  final List<SoldierEntity> soldiers;
  final Animation soldierAnimation;

  MiddleCell({this.id, this.isRotated, this.soldiers, this.soldierAnimation});

  @override
  Widget build(BuildContext context) {
    final boardConstants = Provider.of<BoardConstants>(context);
    return RotatedBox(
      quarterTurns: isRotated ? 2 : 0,
      child: Stack(
        children: <Widget>[
          Container(
            height: boardConstants.rowHeight,
            width: boardConstants.middleCellWidth,
            color: Color.fromRGBO(100, 46, 5, 1),
          ),
          Container(
            width: boardConstants.middleCellWidth,
            height: boardConstants.rowHeight,
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
