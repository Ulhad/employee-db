import 'package:firebase_database/firebase_database.dart';

class EmployeeService {
  final DatabaseReference _database = FirebaseDatabase.instance.reference();

  void addEmployee(String name, String position) {
    _database.child('employees').push().set({
      'name': name,
      'position': position,
    });
  }

  getEmployeesStream() {}
}
