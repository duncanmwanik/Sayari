// String capitalFirst(){

// }

Future delay(int seconds) async => await Future.delayed(Duration(seconds: seconds));
String capitalFirst(String word) => word.length > 2 ? '${word[0].toUpperCase()}${word.substring(1)}' : word;
