import 'package:backgammon/entities/Cell.entity.dart';
import 'package:backgammon/providers/Game.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ExitCell.dart';
import 'MiddleCell.dart';
import 'TriangleCell.dart';

class Cell extends StatefulWidget {
  final CellEntity cell;

  Cell(this.cell);

  @override
  _CellState createState() => _CellState();
}

class _CellState extends State<Cell> with TickerProviderStateMixin {
  // List<AnimationController> _soldierControllers;
  // List<Animation<Offset>> _soldierAnimation;
  AnimationController _soldierController;
  Animation<Offset> _soldierAnimation;

  @override
  void initState() {
    super.initState();
    // _soldierControllers = widget.cell.soldiers.map((_) =>
    //     AnimationController(vsync: this, duration: Duration(seconds: 1)));


    // _soldierAnimations = _soldierControllers.map((_soldierController) => Tween<Offset>(begin: Offset(0, 0), end: Offset(0, 10))
    //     .animate(_soldierController));
    _soldierController = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _soldierAnimation = Tween<Offset>(begin: Offset(0, 0), end: Offset(0, 0.5))
        .animate(_soldierController);
  }

  @override
  void dispose() {
    super.dispose();
    _soldierController.dispose();
    // _soldierControllers
    //     .forEach((_soldierController) => _soldierController.dispose());
  }

  Widget get cellType {
    if (widget.cell.isMiddleCell) {
      return MiddleCell(
        id: widget.cell.id,
        isRotated: widget.cell.id == 'whiteMiddleCell',
        soldiers: widget.cell.soldiers,
        soldierAnimation: _soldierAnimation,
      );
    } else if (widget.cell.isExitCell) {
      return ExitCell(
        id: widget.cell.id,
        isPossibleMove: widget.cell.isPossibleMove,
        isRotated: widget.cell.id == 'whiteExitCell',
        soldiers: widget.cell.soldiers,
        soldierAnimation: _soldierAnimation,
      );
    } else {
      return TriangleCell(
        id: widget.cell.id,
        isRotated: int.parse(widget.cell.id) > 12,
        soldiers: widget.cell.soldiers,
        isPossibleMove: widget.cell.isPossibleMove,
        soldierAnimation: _soldierAnimation,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);
    return GestureDetector(
      child: cellType,
      onTap: () {
        gameProvider.onCellClick(widget.cell, _soldierController);
      },
    );
  }
}
