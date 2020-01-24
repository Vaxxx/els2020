import 'package:els2020/model/Course.dart';
import 'package:els2020/model/database_helper.dart';
import 'package:els2020/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class DeleteCourse extends StatefulWidget {
  @override
  _DeleteCourseState createState() => _DeleteCourseState();
}

class _DeleteCourseState extends State<DeleteCourse> {
  DatabaseHelper db = DatabaseHelper();
  int count = 0;
  List<Course> course;
  @override
  Widget build(BuildContext context) {
    if (course == null) {
      course = List<Course>();
      updateCourse();
    }
    return Center(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.keyboard_backspace),
            onPressed: () {
              backToDashboard();
            },
          ),
          title: Text('COURSES'),
          actions: <Widget>[
            Text('Admin'),
          ],
        ),
        body: getCourseList(),
      ),
    );
  }

  ListView getCourseList() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          child: ListTile(
              title: Text(this.course[position].title),
              subtitle: Text(this.course[position].cid.toString()),
              trailing: IconButton(
                icon: Icon(Icons.delete_forever),
                onPressed: () {
                  //delete the course
                  deleteCourse(position);
                },
              )),
        );
      },
    );
  } //get CourseList()

////
  void updateCourse() {
    final Future<Database> dbFuture = db.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Course>> profileFuture = db.getAllCourses();
      profileFuture.then((course) {
        setState(() {
          this.course = course;
          this.count = course.length;
        });
      });
    });
  }

  void backToDashboard() {
    Navigator.pushNamed(context, '/admin_dashboard');
  } //backToDashboard

  void deleteCourse(int position) async {
    //delete a single course
    // print(course[position].id);
    int result = await db.deleteCourse(course[position].id);

    if (result != 0) {
      backToDashboard();
      createAlertDialog('A Course has been successfully Deleted', context);
    } else
      createAlertDialog('ERROR!', context);
  } //deleteUser
}
