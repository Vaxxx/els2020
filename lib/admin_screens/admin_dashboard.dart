import 'package:els2020/utilities/constants.dart';
import 'package:flutter/material.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace),
          onPressed: () {
            backToTheBeginning();
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
          )
        ],
        title: Text('ADMIN'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //////////////////////////////////first item=> View registered users//////////////////////
            RaisedButtonWidget(
              label: 'View and Delete Registered Users',
              color: Colors.teal,
              onPressed: () {
                Navigator.pushNamed(context, '/registered_users');
              },
            ),
            ///////////////////////////////////////////Second item => Create A Category
            RaisedButtonWidget(
              label: 'Add a Category',
              color: Colors.black87,
              onPressed: () {
                Navigator.pushNamed(context, '/create_category');
              },
            ),
            RaisedButtonWidget(
              label: 'View and Delete a Category',
              color: Colors.red,
              onPressed: () {
                Navigator.pushNamed(context, '/delete_category');
              },
            ),

            RaisedButtonWidget(
              label: 'Add a Course',
              color: Colors.green,
              onPressed: () {
                Navigator.pushNamed(context, '/create_course');
              },
            ),
            RaisedButtonWidget(
              label: 'View and Delete a Course',
              color: Colors.redAccent,
              onPressed: () {
                Navigator.pushNamed(context, '/delete_course');
              },
            ),
          ],
        ),
      ),
    );
  }

  void backToTheBeginning() {
    Navigator.pop(context);
  } //backToTheBeginning
}
