import 'package:flutter/material.dart';
import 'package:employee/services/employee_service.dart';

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
            Map<dynamic, dynamic> employees = snapshot.data!.value;
            List<Map<dynamic, dynamic>> employeesList = [];
            employees.forEach((key, value) {
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
