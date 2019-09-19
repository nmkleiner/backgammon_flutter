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
  Color currentTurn = Colors.black;
  // possibleMoves
  bool duringTurn = false;
  // Map loggedInUser = {
  //   'name': 'noam',
  //   'id': '123',
  //   'pic': '.jpg',
  //   'color': Colors.black
  // };
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
    '8': {'amount': 3, 'color': Colors.black},
    '12': {'amount': 5, 'color': Colors.white},
    '13': {'amount': 5, 'color': Colors.black},
    '17': {'amount': 3, 'color': Colors.white},
    '19': {'amount': 5, 'color': Colors.white},
    '24': {'amount': 2, 'color': Colors.black},
  };

  GameProvider() {
    _setBoard();
    rollDices();
  }

  void rollDices() {
    _rollDice(dices[0]);
    _rollDice(dices[1]);
    duringTurn = true;
    dicesRolling = true;

    Future.delayed(const Duration(milliseconds: 700), () {
      dicesRolling = false;
      // force doubles
      dices[0].number = dices[1].number;
      // dices[0].number = 1;
      // dices[1].number = 1;
      notifyListeners();
      _swapDices();
      _setDoubleCount();
      _calculatePossibleMoves();
      notifyListeners();
    });
  }

  void onCellClick(CellEntity clickedCell) {
    // three options:

    if (!thereIsSelectedSoldier &&
            clickedCell.soldiers.isNotEmpty &&
            currentTurn == clickedCell.soldiers.last.color
        // && currentTurn == loggedInUser['color']
        ) {
      // -  select soldier.
      _selectLastSoldierInCell(clickedCell);

      return;
    } else if (thereIsSelectedSoldier && !clickedCell.isPossibleMove) {
      // -  unSelect soldier
      print('unselect soldier: ');
      _unselectSelectedSoldier();
    } else if (thereIsSelectedSoldier && clickedCell.isPossibleMove) {
      // -  move soldier.
      _moveSelectedSoldier(clickedCell);
      _useDices(clickedCell);
      _unselectSelectedSoldier();
      _resetPossibleMoveCells();

      bool endTurn = _checkIfEndTurnByDices();
      if (!endTurn) {
        List<int> possibleMoves = _calculatePossibleMoves();
        _checkIfEndTurnByPossibleMoves(possibleMoves);
      }
    }
    notifyListeners();
  }

  void _moveSelectedSoldier(CellEntity destination) {
    CellEntity source = selectedSoldierCell;
    source.soldiers.removeLast();
    destination.soldiers.add(selectedSoldier);
    selectedSoldier.cellId = destination.id;
  }

  void _selectLastSoldierInCell(CellEntity cell) {
    selectedSoldierCell = cell;
    selectedSoldier = cell.soldiers.last;
    selectedSoldier.isSelected = true;
    thereIsSelectedSoldier = true;
    _setPossibleMoveCells();
    notifyListeners();
  }

  void _unselectSelectedSoldier() {
    selectedSoldierCell = null;
    selectedSoldier.isSelected = false;
    selectedSoldier = null;
    thereIsSelectedSoldier = false;
    _resetPossibleMoveCells();
  }

  void _setBoard() {
    boardMap.forEach((String cellIndex, Map value) {
      List<SoldierEntity> soldiers = _createSoldiers(
              boardMap[cellIndex]['amount'], boardMap[cellIndex]['color'])
          .toList();
      soldiers.forEach((soldier) {
        _getCellById(cellIndex).soldiers.add(soldier);
        soldier.cellId = cellIndex;
      });
    });
  }

  void _checkIfEndTurnByPossibleMoves(List<int> possibleMoves) {
    print('checkIfEndTurn :  ${!_hasPossibleMoves(possibleMoves)}');
    if (!_hasPossibleMoves(possibleMoves)) {
      _endTurn();
    }
  }

  bool _checkIfEndTurnByDices() {
    print('_checkIfEndTurnByDices : ${dices[0].isUsed} ${dices[1].isUsed}');
    if (dices[0].isUsed && dices[1].isUsed) {
      _endTurn();
      return true;
    }
    return false;
  }

  void _endTurn() {
    currentTurn = currentTurn == Colors.white ? Colors.black : Colors.white;
    duringTurn = false;

    // TODO: check if end game, mars, turkish mars etc.
  }

  int soldierId = 0;
  List<SoldierEntity> _createSoldiers(int amount, Color color) {
    List<SoldierEntity> soldiers = [];
    for (var i = 0; i < amount; i++) {
      soldiers.add(SoldierEntity(color: color, id: soldierId++));
    }
    return soldiers;
  }

  void _setPossibleMoveCells() {
    selectedSoldier.possibleMoves.forEach((cellId) {
      CellEntity cell = _getCellById(cellId.toString());
      cell.isPossibleMove = true;
    });
  }

  void _resetPossibleMoveCells() {
    cells.forEach((cell) => cell.isPossibleMove = false);
  }

  List<int> _calculatePossibleMoves() {
    List<SoldierEntity> soldiers = _possibleSoldiers;
    print('dices: ${dices[0].number} ${dices[1].number}');
    int direction = currentTurn == Colors.white ? 1 : -1;
    List<int> possibleMoves = [];
    soldiers.forEach((soldier) {
      CellEntity source = _getCellById(soldier.cellId);
      List<int> soldierMoves = [];
      soldierMoves = _calculateNaiveSoldierMoves(source, direction);
      print('----calculated naive soldier moves: $soldierMoves');
      soldierMoves = _removeSrcCellMoves(soldierMoves, source);
      print('----removed source cell moves: $soldierMoves');
      soldierMoves = _removeOpponentHousesMoves(soldierMoves);
      print('----removed opponent house moves: $soldierMoves');
      soldierMoves = _removeBasedOnHousesMoves(soldierMoves);
      print('----removed based on opponent house moves: $soldierMoves');
      soldierMoves = _removeBasedOnOutsideMoves(soldierMoves);
      print('----removed based on outside moves: $soldierMoves');
      soldierMoves = _removeExitMoves(soldierMoves);
      print('----removed exit moves: $soldierMoves');
      soldierMoves = _removeNulls(soldierMoves);
      print('----removed null moves: $soldierMoves');
      soldier.possibleMoves = soldierMoves;
      print('             ');
      soldierMoves.forEach((soldierMove) => possibleMoves.add(soldierMove));
    });
    print('possibleMoves : $possibleMoves');
    return possibleMoves;
  }

  _calculateNaiveSoldierMoves(CellEntity source, int direction) {
    List<int> moves = [];
    bool isGettingOut = true;
    int srcCellIndex = _getCellIndexFromId(source.id);

    if (srcCellIndex != 0 && srcCellIndex != 25) {
      isGettingOut = false;
    }
    if (doubleCount == 0) {
      int num1 = dices[0].isUsed ? 0 : dices[0].number;
      int num2 = dices[1].isUsed ? 0 : dices[1].number;
      print('----_calculateNaiveSoldierMoves num1: $num1 num2: $num2');
      if (dices[0].isUsed && dices[1].isUsed) {
        moves = [];
      } else if (!isGettingOut) {
        moves = [
          srcCellIndex + direction * num1,
          srcCellIndex + direction * num2,
          srcCellIndex + direction * (num1 + num2)
        ];
      } else {
        moves = [
          srcCellIndex + direction * num1,
          srcCellIndex + direction * num2,
          null
        ];
      }
    } else {
      int doubleNum = dices[0].number;
      for (int i = 1; i <= doubleCount; i++) {
        moves.add(srcCellIndex + direction * doubleNum * i);
      }
    }
    return moves.toList();
  }

  List<int> _removeSrcCellMoves(List<int> moves, CellEntity source) {
    int srcCellIndex = _getCellIndexFromId(source.id);
    return moves.map((move) => (move == srcCellIndex) ? null : move).toList();
  }

  List<int> _removeOpponentHousesMoves(List<int> moves) {
    return moves
        .map((cellIndex) => _isOpponentHouse(cellIndex) ? null : cellIndex)
        .toList();
  }

  List<int> _removeBasedOnHousesMoves(List<int> moves) {
    if (doubleCount == 0) {
      if (moves[0] == null && moves[1] == null) {
        moves[2] = null;
      }
    } else {
      int index = moves.indexWhere((move) => move == null);
      if (index != -1) {
        for (var i = 0; i < moves.length; i++) {
          if (i > index) {
            moves[i] = null;
          }
        }
      }
    }
    return moves;
  }

  List<int> _removeBasedOnOutsideMoves(List<int> moves) {
    moves = moves.map((move) {
      if (move == null) {
        return null;
      } else if (move > 25) {
        return 25;
      } else if (move < 0) {
        return 0;
      } else {
        return move;
      }
    }).toList();
    int index = moves.indexWhere((move) => move == 25 || move == 0);
    if (index != -1) {
      for (var i = 0; i < moves.length; i++) {
        if (i > index) {
          moves[i] = null;
        }
      }
    }
    return moves;
  }

  List<int> _removeExitMoves(List<int> moves) {
    if (_canExit) {
      return moves;
    } else {
      return moves
          .map(
              (move) => (move == null || move >= 25 || move <= 0) ? null : move)
          .toList();
    }
  }

  List<int> _removeNulls(List<int> moves) {
    return moves.where((move) => move != null).toList();
  }

  bool _isOpponentHouse(int cellIndex) {
    if (cellIndex == null) {
      return false;
    }
    if (cellIndex > 24 || cellIndex < 1) {
      return false;
    }
    String cellId = _getCellIdFromIndex(cellIndex);
    CellEntity cell = _getCellById(cellId);
    return currentTurn == Colors.white && cell.isHouseOf(Colors.black) ||
        currentTurn == Colors.black && cell.isHouseOf(Colors.white);
  }

  bool get _canExit {
    List _cells = currentTurn == Colors.white
        ? cells.sublist(21, 27)
        : cells.sublist(1, 7);
    int count = 0;
    _cells.forEach((cell) {
      cell.soldiers.forEach((soldier) {
        if (soldier.color == currentTurn) count++;
      });
    });
    return count == 15;
  }

  CellEntity _getCellById(String id) {
    return cells.firstWhere((cell) => cell.id == id);
  }

  int _getCellIndexFromId(String cellId) {
    switch (cellId) {
      case 'whiteExitCell':
        return 25;
      case 'blackExitCell':
        return 0;
      case 'whiteMiddleCell':
        return 0;
      case 'blackMiddleCell':
        return 25;
      default:
        return int.parse(cellId);
    }
  }

  String _getCellIdFromIndex(int cellIndex) {
    if (cellIndex == 0) {
      return 'whiteMiddleCell';
    } else if (cellIndex == 25) {
      return 'blackMiddleCell';
    } else {
      return cellIndex.toString();
    }
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

  bool _hasPossibleMoves(List<int> possibleMoves) {
    return possibleMoves.any((possibleMove) => possibleMove != null);
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

  void _setDoubleCount() {
    doubleCount = dices[0].number == dices[1].number ? 4 : 0;
  }

  void _useDices(CellEntity destination) {
    CellEntity source = selectedSoldierCell;
    int sourceIndex = _getCellIndexFromId(source.id);
    int destinationIndex = _getCellIndexFromId(destination.id);
    int distance = _abs(sourceIndex - destinationIndex);
    if (doubleCount == 0) {
      if (distance <= dices[0].number) {
        dices[0].useDice();
      } else if (distance <= dices[1].number) {
        dices[1].useDice();
      } else {
        dices[0].useDice();
        dices[1].useDice();
      }
    } else {
      int stepCount = (distance / dices[0].number).floor();
      if (distance % dices[0].number != 0) stepCount++;
      doubleCount -= stepCount;
      if (doubleCount == 0) {
        dices[0].useDice();
        dices[1].useDice();
      }
    }
  }

  void _swapDices() {
    if (dices[0].number > dices[1].number) {
      int swapper = dices[0].number;
      dices[0].number = dices[1].number;
      dices[1].number = swapper;
    }
  }

  void _rollDice(DiceEntity dice) {
    dice.number = math.Random().nextInt(6) + 1;
    dice.isUsed = false;
  }

  bool get showDicesButton {
    return (!this.duringTurn);
    // when game has two players
    // && this.currentTurn == this.loggedInUser['color']);
    // when game has two players and they throw a single dice to check who starts
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

  int _abs(int x) {
    return x < 0 ? -x : x;
  }
}
