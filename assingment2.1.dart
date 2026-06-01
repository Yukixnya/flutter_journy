/*
write dart program demonstrating: 
- input and output 
- simple logic using conditions 
- Looped based problems (e.g number series , sums)
*/

import 'dart:io';

void main() {
  // Input and Output
  print("Enter your name:");
  String? name = stdin.readLineSync();
  print("Hello, $name");
  print("");

  // Conditions
  print("Enter a number:");
  int num = int.parse(stdin.readLineSync()!);
  if (num % 2 == 0) {
    print("$num is Even");
  } else {
    print("$num is Odd");
  }
  print("");

  // Loops and Sum
  print("Enter N:");
  int n = int.parse(stdin.readLineSync()!);
  int sum = 0;
  for (int i = 1; i <= n; i++) {
    sum += i;
  }
  print("Sum of first $n numbers = $sum");
  print("");

  // Number Series
  print("Number Series:");
  for (int i = 1; i <= n; i++) {
    print(i);
  }

  // Fibonacci Series
  print("Fibonacci Series:");
  int a = 0, b = 1;
  for (int i = 1; i <= n; i++) {
    print(a);
    int c = a + b;
    a = b;
    b = c;
  }
  
}