import 'package:backgammon/providers/BoardConstants.provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class TriangleCell extends StatelessWidget {
  final int id;
  final isRotated;

  TriangleCell({this.id, this.isRotated});

  Color get color {
    return id % 2 == 0 ? Colors.black : Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final cells = Provider.of<BoardConstants>(context, listen: false);
    return RotatedBox(
      quarterTurns: isRotated ? 2 : 0,
      child: ClipPath(
        clipper: TriangleClipper(),
        child: Container(
          width: cells.cellWidth,
          height: cells.cellHeight,
          color: color,
          child: Text(
            id.toString(),
            style: TextStyle(fontSize: 26, color: Colors.yellow),
          ),
        ),
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

