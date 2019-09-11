import 'package:backgammon/providers/cells.provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class MiddleCell extends StatelessWidget {
  final int id;

  MiddleCell({this.id});

  @override
  Widget build(BuildContext context) {
    final cells = Provider.of<Cells>(context);
    return Container(
      height: cells.rowHeight,
      width: cells.middleCellWidth,
      color: Colors.deepOrange,
      child: Text(
        id.toString(),
        style: TextStyle(color: Colors.yellowAccent),
      ),
    );
  }
}
