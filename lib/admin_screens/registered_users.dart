import 'package:els2020/model/User.dart';
import 'package:els2020/model/database_helper.dart';
import 'package:els2020/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class RegisteredUsers extends StatefulWidget {
  @override
  _RegisteredUsersState createState() => _RegisteredUsersState();
}

class _RegisteredUsersState extends State<RegisteredUsers> {
  DatabaseHelper db = DatabaseHelper();
  List<User> user;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      user = List<User>();
      updateProfile();
    }
    return WillPopScope(
      onWillPop: () {
        backToTheBeginning();
      },
      child: Center(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                backToTheBeginning();
              },
              icon: Icon(Icons.keyboard_backspace),
            ),
            title: Text('REGISTERED USERS'),
            actions: <Widget>[
              Icon(Icons.person_outline),
            ],
          ),
          body: getUsersList(),
        ),
      ),
    );
  }

  ListView getUsersList() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          child: ListTile(
            title: Text(this.user[position].fullname),
            subtitle: Text(this.user[position].email),
            trailing: IconButton(
              onPressed: () {
                //delete user
                deleteUser(position);
              },
              icon: Icon(Icons.delete),
            ),
            onTap: () {
              print(user[position].id);
            },
          ),
        );
      },
    );
  } //get CategoryList()

  void updateProfile() {
    final Future<Database> dbFuture = db.initializeDatabase();
    dbFuture.then((database) {
      Future<List<User>> profileFuture = db.getAllUsers();
      profileFuture.then((user) {
        setState(() {
          this.user = user;
          this.count = user.length;
        });
      });
    });
  } //updateProfile

  void backToTheBeginning() {
    Navigator.pop(context);
  } //backToTheBeginning

  void deleteUser(int position) async {
    //delete a single user
    // print(user[position].id);
    int result = await db.deleteUser(user[position].id);

    if (result != 0) {
      backToTheBeginning();
      createAlertDialog('Profile has been successfully Deleted', context);
    } else
      createAlertDialog('ERROR!', context);
  } //deleteUser

}
