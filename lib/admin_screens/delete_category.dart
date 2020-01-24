import 'package:els2020/model/Category.dart';
import 'package:els2020/model/database_helper.dart';
import 'package:els2020/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class DeleteCategory extends StatefulWidget {
  @override
  _DeleteCategoryState createState() => _DeleteCategoryState();
}

class _DeleteCategoryState extends State<DeleteCategory> {
  DatabaseHelper db = DatabaseHelper();
  int count = 0;
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
          leading: IconButton(
            icon: Icon(Icons.keyboard_backspace),
            onPressed: () {
              backToDashboard();
            },
          ),
          title: Text('CATEGORIES'),
          actions: <Widget>[
            Text('Admin'),
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
                icon: Icon(Icons.delete_forever),
                onPressed: () {
                  //delete the category
                  deleteCategory(position);
                },
              )),
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

  void backToDashboard() {
    Navigator.pushNamed(context, '/admin_dashboard');
  } //backToDashboard

  void deleteCategory(int position) async {
    //delete a single user
    // print(user[position].id);
    int result = await db.deleteCategory(category[position].id);

    if (result != 0) {
      backToDashboard();
      createAlertDialog('A Category has been successfully Deleted', context);
    } else
      createAlertDialog('ERROR!', context);
  } //deleteUser
}
