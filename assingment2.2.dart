// User Defined Function
int add(int a, int b) {
  return a + b;
}

// Class
class Student {
  String name;
  int age;

  Student(this.name, this.age);

  void display() {
    print("Name: $name");
    print("Age: $age");
  }
}

void main() {

  int result = add(10, 20);
  print("Sum = $result");

  // List
  List<int> numbers = [10, 20, 30];
  numbers.add(40);

  print("\nList Elements:");
  for (int num in numbers) {
    print(num);
  }

  // Map
  Map<String, String> student = {
    "Name": "Zero",
    "Branch": "CSE"
  };

  student["Semester"] = "6";

  print("\nMap Elements:");
  student.forEach((key, value) {
    print("$key : $value");
  });

  print("\nStudent Details:");
  Student s1 = Student("Zero", 21);
  s1.display();
}