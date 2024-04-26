import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:employee/services/employee_service.dart';
import 'package:employee/screen/add_employee_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee List'),
      ),
      body: StreamBuilder(
        stream: EmployeeService().getEmployeesStream(),
        builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
          if (snapshot.hasData && snapshot.data!.value != null) {
            // Retrieve employee data from the snapshot
            Object? employees = snapshot.data!.value;

            // Convert the map to a list for easier manipulation
            List<Map<dynamic, dynamic>> employeesList = [];
            var forEach = employees?.forEach((key, value) {
              employeesList.add({
                'key': key,
                'name': value['name'],
                'position': value['position'],
              });
            });

            return ListView.builder(
              itemCount: employeesList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(employeesList[index]['name']),
                  subtitle: Text(employeesList[index]['position']),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addEmployee');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
