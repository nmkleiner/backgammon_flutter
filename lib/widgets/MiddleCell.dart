import 'package:backgammon/providers/BoardConstants.provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class MiddleCell extends StatelessWidget {
  final int id;

  MiddleCell({this.id});

  @override
  Widget build(BuildContext context) {
    final cells = Provider.of<BoardConstants>(context, listen: false);
    return Container(
      height: cells.rowHeight,
      width: cells.middleCellWidth,
      color: Color.fromRGBO(160, 110, 44, 1),
      child: Text(
        id.toString(),
        style: TextStyle(color: Colors.yellowAccent),
      ),
    );
  }
}
