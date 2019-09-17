import 'dart:async';
import 'dart:math' as math;

import 'package:backgammon/entities/Cell.entity.dart';
import 'package:backgammon/entities/Dice.entity.dart';
import 'package:backgammon/entities/Soldier.entity.dart';
import 'package:flutter/material.dart';

class GameProvider with ChangeNotifier {
  SoldierEntity selectedSoldier;
  CellEntity selectedSoldierCell;
  bool thereIsSelectedSoldier = false;
  Color currentTurn = Colors.white;
  // possibleMoves
  bool duringTurn = false;
  Map loggedInUser = {
    'name': 'noam',
    'id': '123',
    'pic': '.jpg',
    'color': Colors.white
  };
  bool winner = false;
  bool isMars = false;
  bool isTurkishMars = false;
  // score
  // bool noPossibleMoves
  bool dicesRolling = false;
  int doubleCount = 0;
  List<DiceEntity> dices = [
    DiceEntity(0),
    DiceEntity(1),
  ];

  List<CellEntity> cells = [
    CellEntity(id: 'blackExitCell', isExitCell: true),
    CellEntity(id: '1'),
    CellEntity(id: '2'),
    CellEntity(id: '3'),
    CellEntity(id: '4'),
    CellEntity(id: '5'),
    CellEntity(id: '6'),
    CellEntity(id: 'blackMiddleCell', isMiddleCell: true),
    CellEntity(id: '7'),
    CellEntity(id: '8'),
    CellEntity(id: '9'),
    CellEntity(id: '10'),
    CellEntity(id: '11'),
    CellEntity(id: '12'),
    CellEntity(id: '13'),
    CellEntity(id: '14'),
    CellEntity(id: '15'),
    CellEntity(id: '16'),
    CellEntity(id: '17'),
    CellEntity(id: '18'),
    CellEntity(id: 'whiteMiddleCell', isMiddleCell: true),
    CellEntity(id: '19'),
    CellEntity(id: '20'),
    CellEntity(id: '21'),
    CellEntity(id: '22'),
    CellEntity(id: '23'),
    CellEntity(id: '24'),
    CellEntity(id: 'whiteExitCell', isExitCell: true)
  ];

  Map<String, Map<String, dynamic>> boardMap = {
    '1': {'amount': 2, 'color': Colors.white},
    '6': {'amount': 5, 'color': Colors.black},
    '9': {'amount': 3, 'color': Colors.black},
    '13': {'amount': 5, 'color': Colors.white},
    '14': {'amount': 5, 'color': Colors.black},
    '18': {'amount': 3, 'color': Colors.white},
    '21': {'amount': 5, 'color': Colors.white},
    '26': {'amount': 2, 'color': Colors.black},
  };

  GameProvider() {
    _setBoard();
  }

  void onCellClick(String cellId) {
    var clickedCell = _getCellById(cellId);
    // three options:
    // -  select soldier.
    // -  move soldier.
    // -  unSelect soldier

    if (clickedCell.soldiers.isNotEmpty &&
            currentTurn == clickedCell.soldiers.last.color
        // && currentTurn == loggedInUser['color']
        ) {
      _selectLastSoldierInCell(clickedCell);
      return;
    }
    if (thereIsSelectedSoldier
        // && _cellIsPossibleMove
        ) {
      if (clickedCell.isMiddleCell) {
        return;
      }
      _moveSelectedSoldier(clickedCell);
      _unselectSelectedSoldier();
    }
  }

  void _moveSelectedSoldier(CellEntity destination) {
    CellEntity source = selectedSoldierCell;
    source.soldiers.removeLast();
    destination.soldiers.add(selectedSoldier);
  }

  CellEntity _getCellById(String id) {
    return cells.firstWhere((cell) => cell.id == id);
  }

  void _selectLastSoldierInCell(CellEntity cell) {
    selectedSoldierCell = cell;
    selectedSoldier = cell.soldiers.last;
    selectedSoldier.isSelected = true;
    thereIsSelectedSoldier = true;
    notifyListeners();
  }

  void _unselectSelectedSoldier() {
    selectedSoldierCell = null;
    selectedSoldier.isSelected = false;
    selectedSoldier = null;
    thereIsSelectedSoldier = false;
    notifyListeners();
  }

  void _setBoard() {
    boardMap.forEach((String cellId, Map value) {
      List<SoldierEntity> soldiers =
          _createSoldiers(boardMap[cellId]['amount'], boardMap[cellId]['color'])
              .toList();
      soldiers.forEach((soldier) {
        cells[int.parse(cellId)].soldiers.add(soldier);
      });
    });
  }

  int soldierId = 0;
  List<SoldierEntity> _createSoldiers(int amount, Color color) {
    List<SoldierEntity> soldiers = [];
    for (var i = 0; i < amount; i++) {
      soldiers.add(SoldierEntity(color: color, id: soldierId++));
    }
    return soldiers;
  }

  void _calculatePossibleMoves() {
    List<SoldierEntity> soldiers = _possibleSoldiers;
    print(soldiers.map((soldier) => soldier.id));
    int direction = currentTurn == Colors.white ? 1 : -1;
  }

  List<SoldierEntity> get _possibleSoldiers {
    List<SoldierEntity> soldiers = _lastInCellSoldiers;
    CellEntity middleCell = currentTurn == Colors.white
        ? _getCellById('whiteMiddleCell')
        : _getCellById('blackMiddleCell');
    String exitCellId =
        currentTurn == Colors.white ? 'whiteExitCell' : 'blackExitCell';
    if (!_hasEatenSoldiers) {
      //  get soldiers that it's their turn and are not outside board
      return soldiers.where((soldier) {
        return (soldier.color == currentTurn) && (soldier.cellId != exitCellId);
      }).toList();
    } else {
      // get soldiers from middleCell
      return [middleCell.soldiers.last];
    }
  }

  bool get _hasEatenSoldiers {
    CellEntity middleCell = currentTurn == Colors.white
        ? _getCellById('whiteMiddleCell')
        : _getCellById('blackMiddleCell');
    return middleCell.soldiers.isNotEmpty;
  }

  List<SoldierEntity> get _allSoldiers {
    List<SoldierEntity> res = [];
    cells.map((CellEntity cell) => cell.soldiers).forEach((soldiers) => {
          soldiers.forEach((soldier) => {res.add(soldier)})
        });
    return res;
  }

  List<SoldierEntity> get _lastInCellSoldiers {
    List<SoldierEntity> res = [];
    cells.map((CellEntity cell) => cell.soldiers).forEach((soldiers) => {
          if (soldiers.isNotEmpty) {res.add(soldiers.last)}
        });
    return res;
  }

  void rotateDices() {
    _rollDice(dices[0]);
    _rollDice(dices[1]);
    duringTurn = true;
    _calculatePossibleMoves();
  }

  void _rollDice(DiceEntity dice) {
    int _counter = 0;
    dicesRolling = true;
    Timer.periodic(
        Duration(milliseconds: 60),
        (timer) => {
              _counter++,
              if (_counter > 5) {timer.cancel()},
              dice.number = math.Random().nextInt(7),
              notifyListeners()
            });
    Future.delayed(const Duration(milliseconds: 700), () {
      dicesRolling = false;
      notifyListeners();
    });
    notifyListeners();
  }

  bool get showDicesButton {
    return (!this.duringTurn && this.currentTurn == this.loggedInUser['color']);
    // this.isGameOn &&
    // !this.rolling &&
  }

  bool get showDiceButton {
    return false;
  }

  bool get showWaitButton {
    return false;
  }

  bool get showRestartButton {
    return false;
  }
}
