import 'dart:async';
import 'dart:math' as math;
import 'package:backgammon/entities/Cell.entity.dart';
import 'package:backgammon/entities/Dice.entity.dart';
import 'package:backgammon/entities/Soldier.entity.dart';
import 'package:backgammon/services/game.service.dart';
import 'package:flutter/material.dart';
//import '../services/AudioPlayer.dart'

class GameProvider with ChangeNotifier {
  SoldierEntity selectedSoldier;
  CellEntity selectedSoldierCell;
  bool thereIsSelectedSoldier = false;
  Color currentTurn = Colors.black;
  bool duringTurn = false;
//  AudioPlayer player = AudioPlayer();

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
    CellEntity(id: 'whiteMiddleCell', isMiddleCell: true),
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
    CellEntity(id: 'blackMiddleCell', isMiddleCell: true),
    CellEntity(id: '19'),
    CellEntity(id: '20'),
    CellEntity(id: '21'),
    CellEntity(id: '22'),
    CellEntity(id: '23'),
    CellEntity(id: '24'),
    CellEntity(id: 'whiteExitCell', isExitCell: true)
  ];

  GameService gameService = GameService();

  GameProvider() {
    _setBoard();
    // rollDices();
  }

  void rollDices() {
    duringTurn = true;
//    player.play('dice.mp3');
    dices[0].isUsed = false;
    dices[1].isUsed = false;
    dicesRolling = true;
    notifyListeners();
    _switchDicesNumbers();
  }

  _switchDicesNumbers() {
    int _counter = 0;
    Timer.periodic(
      Duration(milliseconds: 70),
      (timer) => {
        _counter++,
        if (_counter >= 9)
          {
            timer.cancel(),
            Timer(Duration(milliseconds: 100), () {
              _handleDicesResult();
            }),
          },
        dices[0].number = math.Random().nextInt(6) + 1,
        dices[1].number = math.Random().nextInt(6) + 1,
        notifyListeners()
      },
    );
  }

  _handleDicesResult() {
    dicesRolling = false;
    // force doubles
    // dices[0].number = dices[1].number;
    // dices[0].number = 1;
    // dices[1].number = 1;
    _swapDices();
    _setDoubleCount();
    _calculatePossibleMoves();
    notifyListeners();
  }

  void onCellClick(CellEntity clickedCell) {
    if (!thereIsSelectedSoldier &&
            clickedCell.soldiers.isNotEmpty &&
            currentTurn == clickedCell.soldiers.last.color &&
            clickedCell.soldiers.last.possibleMoves.isNotEmpty
        // && currentTurn == loggedInUser['color']
        ) {
      // -  select soldier.
      _selectLastSoldierInCell(clickedCell);
      return;
    } else if (thereIsSelectedSoldier && !clickedCell.isPossibleMove) {
      // -  unSelect soldier
      _unselectSelectedSoldier();
    } else if (thereIsSelectedSoldier && clickedCell.isPossibleMove) {
      // -  move soldier.
      selectedSoldier.isMoving = true;
      notifyListeners();
      Future.delayed(
        Duration(milliseconds: 400),
        () => {
          selectedSoldier.isMoving = false,
          _moveSelectedSoldier(clickedCell),
          _useDices(clickedCell),
          _unselectSelectedSoldier(),
          _resetPossibleMoveCells(),
          notifyListeners(),
          _checkIfEndGame(),
          _checkIfEndTurnByDices(),
        },
      );
    }
    notifyListeners();
  }

  void restartGame() {
    duringTurn = false;
    winner = false;
    isMars = false;
    isTurkishMars = false;
    _restartDices();
    _resetBoard();
    _setBoard();
    notifyListeners();
  }

  void _moveSelectedSoldier(CellEntity destination) {
    CellEntity source = selectedSoldierCell;
    source.soldiers.removeLast();
    _checkHandleEatenSoldier(destination);
    destination.soldiers.add(selectedSoldier);
    selectedSoldier.cellId = destination.id;
  }

  void _checkHandleEatenSoldier(CellEntity destination) {
    if (destination.soldiers.isNotEmpty &&
        destination.soldiers[0].color ==
            gameService.opponentColor(currentTurn)) {
      SoldierEntity eatenSoldier = destination.soldiers.removeAt(0);
      _handleEatenSoldier(eatenSoldier);
    }
  }

  void _handleEatenSoldier(SoldierEntity eatenSoldier) {
    String middleCellId = eatenSoldier.color == Colors.white
        ? 'whiteMiddleCell'
        : 'blackMiddleCell';

    eatenSoldier.cellId = middleCellId;
    CellEntity middleCell = gameService.getCellById(middleCellId, cells);
    middleCell.soldiers.add(eatenSoldier);
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
//     var _boardMap = gameService.boardMapForGameEndTesting;
    // var _boardMap = gameService.boardMapForMarsTesting;
    // var _boardMap = gameService.boardMapForTurkishMarsTesting;
    var _boardMap = gameService.boardMap;
    _boardMap.forEach((String cellIndex, Map value) {
      List<SoldierEntity> soldiers = _createSoldiers(
              _boardMap[cellIndex]['amount'], _boardMap[cellIndex]['color'])
          .toList();
      soldiers.forEach((soldier) {
        gameService.getCellById(cellIndex, cells).soldiers.add(soldier);
        soldier.cellId = cellIndex;
      });
    });
  }

  void _resetBoard() {
    cells.forEach((cell) => cell.soldiers.clear());
  }

  void _checkIfEndTurnByPossibleMoves(List<int> possibleMoves) {
    if (!gameService.hasPossibleMoves(possibleMoves)) {
      _endTurn();
    }
  }

  void _checkIfEndTurnByDices() {
    bool isEndTurn;
    if (dices[0].isUsed && dices[1].isUsed) {
      _endTurn();
      isEndTurn = true;
    } else {
      isEndTurn = false;
    }

    if (!isEndTurn) {
      List<int> possibleMoves = _calculatePossibleMoves();
      _checkIfEndTurnByPossibleMoves(possibleMoves);
    }
    notifyListeners();
  }

  void _endTurn() {
    currentTurn = currentTurn == Colors.white ? Colors.black : Colors.white;
    duringTurn = false;
  }

  int soldierId = 0;

  List<SoldierEntity> _createSoldiers(int amount, Color color) {
    List<SoldierEntity> soldiers = [];
    for (var i = 0; i < amount; i++) {
      soldiers.add(SoldierEntity(color: color, id: soldierId++));
    }
    return soldiers;
  }

  void _checkIfEndGame() {
    CellEntity exitCell = currentTurn == Colors.white
        ? gameService.getCellById('whiteExitCell', cells)
        : gameService.getCellById('blackExitCell', cells);
    bool isEndGame = exitCell.soldiers.length == 15;
    if (isEndGame) {
      _endGame();
      isMars = _checkIfMars();
      if (isMars) {
        isTurkishMars = _checkIfTurkishMars();
      }
      return;
    }
    notifyListeners();
  }

  bool _checkIfMars() {
    return (currentTurn == Colors.white)
        ? (gameService.getCellById('blackExitCell', cells).soldiers.length == 0)
        : (gameService.getCellById('whiteExitCell', cells).soldiers.length ==
            0);
  }

  bool _checkIfTurkishMars() {
    var _cells = (currentTurn == Colors.white)
        ? cells.sublist(21, 28)
        : cells.sublist(0, 7);
    return _cells.any((cell) {
      return cell.soldiers.isNotEmpty &&
          cell.soldiers[0].color == gameService.opponentColor(currentTurn);
    });
  }

  void _endGame() {
    winner = true;
  }

  void _restartDices() {
    dices[0].number = 6;
    dices[0].isUsed = false;
    dices[1].number = 6;
    dices[1].isUsed = false;
  }

  void _setPossibleMoveCells() {
    selectedSoldier.possibleMoves.forEach((cellIndex) {
      String cellId = gameService.getCellIdFromIndex(cellIndex);
      CellEntity cell = gameService.getCellById(cellId, cells);
      cell.isPossibleMove = true;
    });
  }

  void _resetPossibleMoveCells() {
    cells.forEach((cell) => cell.isPossibleMove = false);
  }

  List<int> _calculatePossibleMoves() {
    List<SoldierEntity> soldiers = _possibleSoldiers;
    _resetPossibleMoves();
    int direction = currentTurn == Colors.white ? 1 : -1;
    List<int> possibleMoves = [];
    soldiers.forEach((soldier) {
      CellEntity source = gameService.getCellById(soldier.cellId, cells);
      List<int> soldierMoves = [];
      soldierMoves = _calculateNaiveSoldierMoves(source, direction);
      soldierMoves = _removeSrcCellMoves(soldierMoves, source);
      soldierMoves = _removeOpponentHousesMoves(soldierMoves);
      soldierMoves = _removeBasedOnHousesMoves(soldierMoves);
      soldierMoves = _removeBasedOnOutsideMoves(soldierMoves);
      soldierMoves = _removeExitMoves(soldierMoves);
      soldierMoves = _removeNulls(soldierMoves);
      soldier.possibleMoves = soldierMoves;
      soldierMoves.forEach((soldierMove) => possibleMoves.add(soldierMove));
    });
    return possibleMoves;
  }

  void _resetPossibleMoves() {
    List<SoldierEntity> soldiers = _allSoldiers;
    soldiers.forEach((soldier) => soldier.possibleMoves = []);
  }

  List<int> _calculateNaiveSoldierMoves(CellEntity source, int direction) {
    List<int> moves = [];
    bool isGettingOut = true;
    int srcCellIndex = gameService.getCellIndexFromId(source.id);

    if (srcCellIndex != 0 && srcCellIndex != 25) {
      isGettingOut = false;
    }
    if (doubleCount == 0) {
      int num1 = dices[0].isUsed ? 0 : dices[0].number;
      int num2 = dices[1].isUsed ? 0 : dices[1].number;
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
    int srcCellIndex = gameService.getCellIndexFromId(source.id);
    return moves.map((move) => (move == srcCellIndex) ? null : move).toList();
  }

  List<int> _removeOpponentHousesMoves(List<int> moves) {
    return moves
        .map((cellIndex) =>
            gameService.isOpponentHouse(cellIndex, cells, currentTurn)
                ? null
                : cellIndex)
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
    if (gameService.canExit(currentTurn, cells)) {
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

  List<SoldierEntity> get _possibleSoldiers {
    List<SoldierEntity> soldiers = _lastInCellSoldiers;
    CellEntity middleCell = currentTurn == Colors.white
        ? gameService.getCellById('whiteMiddleCell', cells)
        : gameService.getCellById('blackMiddleCell', cells);
    String exitCellId =
        currentTurn == Colors.white ? 'whiteExitCell' : 'blackExitCell';
    if (!gameService.hasEatenSoldiers(currentTurn, cells)) {
      //  get soldiers that it's their turn and are not outside board
      return soldiers.where((soldier) {
        return (soldier.color == currentTurn) && (soldier.cellId != exitCellId);
      }).toList();
    } else {
      // get soldiers from middleCell
      return [middleCell.soldiers.last];
    }
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

  bool get showDicesButton {
    return (!this.duringTurn);
    // when game has two players
    // && this.currentTurn == this.loggedInUser['color']);
    // when game has two players and they throw a single dice to check who starts
    // this.isGameOn &&
    // !this.rolling &&
  }

  void _useDices(CellEntity destination) {
    CellEntity source = selectedSoldierCell;
    int sourceIndex = gameService.getCellIndexFromId(source.id);
    int destinationIndex = gameService.getCellIndexFromId(destination.id);
    int distance = gameService.abs(sourceIndex - destinationIndex);
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
      if (distance % dices[0].number != 0) {
        stepCount++;
      }
      doubleCount = doubleCount - stepCount;
      notifyListeners();
      if (doubleCount == 0) {
        dices[0].useDice();
        dices[1].useDice();
      }
    }
  }

  void _setDoubleCount() {
    doubleCount = dices[0].number == dices[1].number ? 4 : 0;
  }

  void _swapDices() {
    if (dices[0].number > dices[1].number) {
      int swapper = dices[0].number;
      dices[0].number = dices[1].number;
      dices[1].number = swapper;
    }
  }
}
