import 'package:backgammon/entities/Dice.entity.dart';
import '../entities/Cell.entity.dart';
import 'package:flutter/material.dart';

class GameService {
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

  // Map<String, Map<String, dynamic>> boardMapForGameEndTesting = {
  //   '1': {'amount': 2, 'color': Colors.black},
  //   'blackExitCell': {'amount': 13, 'color': Colors.black},
  //   'whiteExitCell': {'amount': 13, 'color': Colors.white},
  //   '24': {'amount': 2, 'color': Colors.white},
  // };
  // Map<String, Map<String, dynamic>> boardMapForMarsTesting = {
  //   '1': {'amount': 2, 'color': Colors.black},
  //   'blackExitCell': {'amount': 13, 'color': Colors.black},
  //   '13': {'amount': 13, 'color': Colors.white},
  //   '24': {'amount': 2, 'color': Colors.white},
  // };

  // Map<String, Map<String, dynamic>> boardMapForTurkishMarsTesting = {
  //   '1': {'amount': 2, 'color': Colors.black},
  //   'blackExitCell': {'amount': 13, 'color': Colors.black},
  //   '3': {'amount': 13, 'color': Colors.white},
  //   '8': {'amount': 2, 'color': Colors.white},
  // };

  bool hasEatenSoldiers(Color currentTurn, List<CellEntity> cells) {
    CellEntity middleCell = currentTurn == Colors.white
        ? getCellById('whiteMiddleCell', cells)
        : getCellById('blackMiddleCell', cells);
    return middleCell.soldiers.isNotEmpty;
  }

  bool hasPossibleMoves(List<int> possibleMoves) {
    return possibleMoves.any((possibleMove) => possibleMove != null);
  }

  bool isOpponentHouse(
      int cellIndex, List<CellEntity> cells, Color currentTurn) {
    if (cellIndex == null) {
      return false;
    }
    if (cellIndex > 24 || cellIndex < 1) {
      return false;
    }
    String cellId = getCellIdFromIndex(cellIndex);
    CellEntity cell = getCellById(cellId, cells);
    return currentTurn == Colors.white && cell.isHouseOf(Colors.black) ||
        currentTurn == Colors.black && cell.isHouseOf(Colors.white);
  }

  Color opponentColor(Color currentTurn) {
    return currentTurn == Colors.white ? Colors.black : Colors.white;
  }

  bool canExit(Color currentTurn, List<CellEntity> cells) {
    List _cells = currentTurn == Colors.white
        ? cells.sublist(21, 28)
        : cells.sublist(0, 7);
    int count = 0;
    _cells.forEach((cell) {
      cell.soldiers.forEach((soldier) {
        if (soldier.color == currentTurn) count++;
      });
    });
    return count == 15;
  }

  bool get showDiceButton {
    return false;
  }

  bool get showWaitButton {
    return false;
  }

  CellEntity getCellById(String id, List<CellEntity> cells) {
    return cells.firstWhere((cell) => cell.id == id);
  }

  int getCellIndexFromId(String cellId) {
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

  String getCellIdFromIndex(int cellIndex) {
    if (cellIndex == 0) {
      return 'blackExitCell';
    } else if (cellIndex == 25) {
      return 'whiteExitCell';
    } else {
      return cellIndex.toString();
    }
  }

  int abs(int x) {
    return x < 0 ? -x : x;
  }

  void setDoubleCount(int doubleCount, List<DiceEntity> dices) {
    doubleCount = dices[0].number == dices[1].number ? 4 : 0;
  }

  void useDices(CellEntity destination, CellEntity selectedSoldierCell,
      int doubleCount, List<DiceEntity> dices) {
    CellEntity source = selectedSoldierCell;
    int sourceIndex = getCellIndexFromId(source.id);
    int destinationIndex = getCellIndexFromId(destination.id);
    int distance = abs(sourceIndex - destinationIndex);
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

  void swapDices(List<DiceEntity> dices) {
    if (dices[0].number > dices[1].number) {
      int swapper = dices[0].number;
      dices[0].number = dices[1].number;
      dices[1].number = swapper;
    }
  }

  
}
