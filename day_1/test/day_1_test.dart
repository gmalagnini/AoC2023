import 'package:test/test.dart';
import '../day_1.dart';

void main() {
  test('get number should return correct number', () {
    int num = getNumber('sevenlvrc2fivefivesixqkzdkrfour', spelled: true);
    expect(num, equals(74));

    num = getNumber('1eighteight7fourone8', spelled: true);
    expect(num, equals(18));

    num = getNumber('8ninezhzrgg6crlpggmtfour41lhjcqtblh', spelled: true);
    expect(num, equals(81));

    num = getNumber('six1two', spelled: true);
    expect(num, equals(62));

    num = getNumber('six', spelled: true);
    expect(num, equals(66));

    num = getNumber('bcmqn9onecnrzhsrsgzggzhtskjeightbz6khfhccktwonenrj', spelled: true);
    expect(num, equals(91));
  });
}
