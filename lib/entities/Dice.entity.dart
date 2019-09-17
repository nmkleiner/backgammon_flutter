class DiceEntity {
  int index;
  int number = 6;
  bool isThrown = false;
  bool isUsed = false;

  DiceEntity(this.index);

  useDice() {
    isUsed = true;
  }
}
