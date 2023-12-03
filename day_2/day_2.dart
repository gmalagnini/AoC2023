import 'dart:io';

void main() {
  File('${Directory.current.path}/day_2/input.txt').readAsString().then((String contents) {
    List<String> gameStrings = contents.split('\n');

    List<Game> games = gameStrings.map((line) => Game(line)).toList();

    List<Game> possibleGames = games.where((game) => game.isPossible).toList();

    int result1 = possibleGames.fold(0, (value, element) => value + element.id);

    print(result1);

    int result2 = games.fold(0, (value, element) => value + element.power);

    print(result2);
  });
}

class Game {
  late int id;
  late List<Session> session;
  late int power;

  int blue = 0;
  int red = 0;
  int green = 0;

  bool isPossible = false;

  Game(String line) {
    this.id = this._getId(line);
    this.session = this._getSession(line);

    this.isPossible = this.session.every((element) => element.isPossible);

    this.power = this._getPower();
  }

  int _getId(String line) {
    RegExp exp = RegExp('\\d+');
    String input = line.split(':')[0];
    String first = exp.firstMatch(input)![0]!;

    return int.parse(first);
  }

  List<Session> _getSession(String line) {
    List<String> sessionStrings = line.split(':')[1].split(';');

    return sessionStrings.map((sessionString) => Session(sessionString)).toList();
  }

  int _getPower() {
    int maxRed = this.session.fold(0, (value, element) => value > element.red ? value : element.red);
    int maxBlue = this.session.fold(0, (value, element) => value > element.blue ? value : element.blue);
    int maxGreen = this.session.fold(0, (value, element) => value > element.green ? value : element.green);

    return maxRed * maxBlue * maxGreen;
  }
}

class Session {
  late int blue;
  late int red;
  late int green;
  bool isPossible = false;

  Session(String line) {
    this.blue = this._getColorNumber(line, 'blue');
    this.red = this._getColorNumber(line, 'red');
    this.green = this._getColorNumber(line, 'green');

    this.isPossible = this._isPossible();
  }

  int _getColorNumber(String line, String color) {
    RegExp exp = RegExp('\\d+ ${color}');

    RegExpMatch? first = exp.firstMatch(line);

    if (first == null) return 0;

    return int.parse(first[0]!.split(' ')[0]);
  }

  bool _isPossible() {
    return this.red <= 12 && this.blue <= 14 && this.green <= 13;
  }
}
