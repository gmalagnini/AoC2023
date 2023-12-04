import 'dart:io';
import 'dart:math';

void main() {
  File('${Directory.current.path}/day_4/input.txt').readAsString().then((String contents) {
    List<String> lines = contents.split('\n');
    List<Card> cards = lines.map((line) => Card(line)).toList();

    print(partOne(cards));
    print(partTwo(cards));
  });
}

int partOne(Iterable<Card> cards) {
  return cards.fold(0, (value, element) => value + element.score);
}

int partTwo(List<Card> cards) {
  cards.forEach((card) {
    final cardsToUpdate = cards.where((c) => c.id > card.id && c.id <= card.id + card.matches);

    cardsToUpdate.forEach((cardToUpdate) => cardToUpdate.instances += card.instances);
  });

  return cards.fold(0, (value, element) => value + element.instances);
}

class Card {
  int instances = 1;
  late int id;
  late int matches;
  late int score;

  late Iterable<int> _numbers;
  late Iterable<int> _winning;

  RegExp _exp = RegExp('\\d+');

  Card(String line) {
    final [stringId, stringCardNumbers] = line.split(':');

    this.id = _getId(stringId);
    final [stringWinning, stringNumbers] = stringCardNumbers.split('|');
    this._winning = _parseNumbers(stringWinning);
    this._numbers = _parseNumbers(stringNumbers);
    this.matches = _getMatches(_winning, _numbers);
    this.score = _getScore(this.matches);
  }

  int _getId(String stringId) => int.parse(this._exp.firstMatch(stringId)![0]!);

  Iterable<int> _parseNumbers(String stringNumbers) => this._exp.allMatches(stringNumbers).map((match) => int.parse(match[0]!));

  int _getMatches(Iterable<int> winning, Iterable<int> numbers) => winning.where((winningNumber) => numbers.contains(winningNumber)).length;

  int _getScore(int matches) => pow(2, matches - 1).toInt();
}
