import 'package:backgammon/providers/BoardConstants.provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ExitCell extends StatelessWidget {
  final int id;
  ExitCell({this.id});

  @override
  Widget build(BuildContext context) {
    final cells = Provider.of<BoardConstants>(context, listen: false);
    return Container(
      width: cells.exitCellWidth,
      height: cells.rowHeight,
      decoration: BoxDecoration(
          border: Border.all(
        color: Colors.black,
        width: 1,
      )),
    );
  }
}
