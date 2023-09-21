import 'dart:io';

void printPattern(int num) {
  for (int i = 1; i <= num; i++) {
    for (int j = 1; j <= i; j++) {
      print("*");
    }
    print("\n");
  }
}

void main(List<String> args) {
  print("Enter any number:");
  int? num = int.parse(stdin.readLineSync()!);
  printPattern(num);
  // print(num);
}
