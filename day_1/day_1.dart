import 'dart:io';

const ONLY_DIGITS_REGEX = '[0-9]';
const SPELLED_REGEX = '([0-9]|one|two|three|four|five|six|seven|eight|nine)';
const Map<String, String> SPELLED_NUMBERS = {'one': '1', 'two': '2', 'three': '3', 'four': '4', 'five': '5', 'six': '6', 'seven': '7', 'eight': '8', 'nine': '9'};

void main() {
  File('${Directory.current.path}/day_1/input_1.txt').readAsString().then((String contents) {
    List<String> lines = contents.split('\n');

    List<int> numbers = lines.map((line) => getNumber(line, spelled: true)).toList();

    int result = numbers.reduce((value, element) => value + element);
    print(result);
  });
}

int getNumber(String line, {bool spelled = false}) {
  RegExp exp = RegExp(spelled ? SPELLED_REGEX : ONLY_DIGITS_REGEX);

  String first = exp.firstMatch(line)![0]!;
  String last = getLastMatch(line, exp);

  return int.parse(parseSpelled(first) + parseSpelled(last));
}

String parseSpelled(String x) {
  return SPELLED_NUMBERS[x] ?? x;
}

String getLastMatch(String line, RegExp exp) {
  for (var i = 1; i <= line.length; i++) {
    String sub = line.substring(line.length - i, line.length);
    if (exp.hasMatch(sub)) {
      return exp.firstMatch(sub)![0]!;
    }
  }
  return '0';
}
