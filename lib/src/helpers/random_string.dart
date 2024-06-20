import 'dart:math';

var chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  var charsInt = '1234567890';
  Random rnd = Random();
  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  String getRandomInt(int length) => String.fromCharCodes(Iterable.generate(length, (_) => charsInt.codeUnitAt(rnd.nextInt(charsInt.length))));