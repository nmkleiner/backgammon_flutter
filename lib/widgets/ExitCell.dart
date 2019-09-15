import 'package:backgammon/providers/BoardConstants.provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ExitCell extends StatelessWidget {
  final int id;
  ExitCell({this.id});

  @override
  Widget build(BuildContext context) {
    final boardConstants = Provider.of<BoardConstants>(context);
    return Container(
      width: boardConstants.exitCellWidth,
      height: boardConstants.rowHeight + 10,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: Text(
        id.toString(),
        style: TextStyle(color: Colors.blue),
      ),
    );
  }
}
