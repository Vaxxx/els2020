import 'package:els2020/model/Category.dart';
import 'package:els2020/model/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  DatabaseHelper db = DatabaseHelper();
  int count = 0;
  int pos;
  List<Category> category;
  @override
  Widget build(BuildContext context) {
    if (category == null) {
      category = List<Category>();
      updateCategory();
    }
    return Center(
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.category),
          title: Text('CATEGORIES'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.border_color,
              ),
              iconSize: 45.0,
              color: Colors.black,
              tooltip: 'View All Courses',
              hoverColor: Colors.black,
              onPressed: () {
                //go to all courses page
                Navigator.pushNamed(context, '/courses');
              },
            )
          ],
        ),
        body: getCategoryList(),
      ),
    );
  }

  ListView getCategoryList() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          child: ListTile(
            title: Text(this.category[position].title),
            trailing: IconButton(
              icon: Icon(Icons.more_vert),
              color: Colors.blueAccent,
              onPressed: () {
                navigateToCoursesUnderCategory(position);
              },
            ),
            onTap: () {
              //navigate to courses under the category
              navigateToCoursesUnderCategory(position);
            },
          ),
        );
      },
    );
  } //get CategoryList()

////
  void updateCategory() {
    final Future<Database> dbFuture = db.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Category>> profileFuture = db.getAllCategories();
      profileFuture.then((category) {
        setState(() {
          this.category = category;
          this.count = category.length;
        });
      });
    });
  }

  void navigateToCoursesUnderCategory(int position) {
    // print(this.category[position].id);
    pos = this.category[position].id;
    Navigator.pushNamed(context, '/category_courses', arguments: pos);
  } //updateProfile
}
