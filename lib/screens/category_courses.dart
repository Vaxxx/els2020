import 'package:els2020/model/Category.dart';
import 'package:els2020/model/Course.dart';
import 'package:els2020/model/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class CategoryCourses extends StatefulWidget {
  final int id;
  CategoryCourses(this.id);
  @override
  _CategoryCoursesState createState() => _CategoryCoursesState(this.id);
}

class _CategoryCoursesState extends State<CategoryCourses> {
  final int id;
  _CategoryCoursesState(this.id);

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
            color: Colors.black,
            iconSize: 30.0,
            onPressed: () {
              backToTheBeginning();
            },
          ),
          title: Text('ALL COURSES'),
          actions: <Widget>[
            Icon(Icons.book),
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
            trailing: Icon(Icons.more_vert),
          ),
        );
      },
    );
  } //get CategoryList()

  //////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////FUNCTIONS/////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////
  void updateCourse() {
    final Future<Database> dbFuture = db.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Course>> profileFuture =
          db.getAllCoursesBasedOnCategory(this.id);
      profileFuture.then((course) {
        setState(() {
          this.course = course;
          this.count = course.length;
        });
      });
    });
  } //updateCourse

  void backToTheBeginning() {
    Navigator.pop(context);
  } //backToTheBeginning

}
