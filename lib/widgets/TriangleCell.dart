import 'package:backgammon/entities/Soldier.entity.dart';
import 'package:backgammon/providers/BoardConstants.provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'Soldier.dart';

class TriangleCell extends StatelessWidget {
  final String id;
  final isRotated;
  final List<SoldierEntity> soldiers;
  final bool isPossibleMove;

  TriangleCell({this.id, this.isRotated, this.soldiers, this.isPossibleMove});

  Color get color {
    if (isPossibleMove) {
      return Color.fromRGBO(50, 200, 50, 1);
    } else {
      return int.parse(id) % 2 == 0 ? Colors.black : Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    final boardConstants = Provider.of<BoardConstants>(context);
    return RotatedBox(
      quarterTurns: isRotated ? 2 : 0,
      child: Stack(
        children: <Widget>[
          Container(
            height: boardConstants.rowHeight,
            child: Column(
              children: <Widget>[
                ClipPath(
                  clipper: TriangleClipper(),
                  child: Container(
                    width: boardConstants.cellWidth,
                    height: boardConstants.cellHeight,
                    color: color,
                    child: Text(
                      id,
                      style: TextStyle(fontSize: 26, color: Colors.yellow),
                    ),
                  ),
                ),
                SizedBox(
                    height:
                        boardConstants.rowHeight - boardConstants.cellHeight)
              ],
            ),
          ),
          Container(
            height: boardConstants.cellHeight,
            width: boardConstants.cellWidth,
            child: Wrap(
              direction: Axis.vertical,
              verticalDirection: VerticalDirection.down,
              alignment: WrapAlignment.start,
              runAlignment: WrapAlignment.center,
              textDirection: TextDirection.rtl,
              children: <Widget>[
                if (soldiers.isNotEmpty)
                  ...soldiers.map((soldier) => Soldier(soldier)).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width / 2, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipper oldClipper) => false;
}
