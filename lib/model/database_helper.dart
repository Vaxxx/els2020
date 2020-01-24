import 'dart:async';
import 'dart:io';
import 'package:els2020/model/Category.dart';
import 'package:els2020/model/Course.dart';
import 'package:els2020/model/CourseContent.dart';
import 'package:els2020/model/User.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static DatabaseHelper _dbHelper;
  static Database _database;

  //create table variables
  String tblUser = 'user';
  String tblCategory = 'category';
  String tblCourse = 'course';
  String tblCourseContent = 'coursecontent';

  //create column variables
  String colId = 'id';
  String colFullName = 'fullname';
  String colEmail = 'email';
  String colUsername = 'username';
  String colPassword = 'password';
  String colTitle = 'title';
  String colCid = 'cid';

  //create a singleton instance variable
  DatabaseHelper._createInstance();

  //create a singleton instance of the database
  factory DatabaseHelper() {
    if (_dbHelper == null) _dbHelper = DatabaseHelper._createInstance();
    return _dbHelper;
  } //DatabaseHelper

  //create tables
  void _onCreateTb(Database db, int newVersion) async {
    String sqlUser =
        'CREATE TABLE  $tblUser ($colId INTEGER PRIMARY KEY AUTOINCREMENT, '
        ' $colFullName Text, $colEmail Text, $colUsername Text, $colPassword Text)';
    String sqlCategory =
        'Create Table  $tblCategory ($colId Integer primary key autoincrement, '
        '  $colTitle text )';
    String sqlCourse =
        'Create Table $tblCourse ($colId INTEGER PRIMARY KEY AUTOINCREMENT, '
        '  $colCid INTEGER, $colTitle Text )';
    String sqlCourseContent =
        'Create Table $tblCourseContent ($colId INTEGER PRIMARY KEY AUTOINCREMENT, '
        '  $colCid INTEGER, $colTitle Text )';

    await db.execute(sqlUser);
    await db.execute(sqlCategory);
    await db.execute(sqlCourse);
    await db.execute(sqlCourseContent);
  } //createTb

  //initialize the database
  Future<Database> initializeDatabase() async {
    //get the db path
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'els.db';

    var userDb = openDatabase(path, version: 1, onCreate: _onCreateTb);
    return userDb;
  } //initializeDatabase

  ///Get the database
  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  } //get database
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////CRUD SECTION/////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

//read db in to map format
  Future<List<Map<String, dynamic>>> getUserList() async {
    Database db = await this.database;
    var result = await db.query(tblUser);
    return result;
  } //getUserList

  //get a readable version of  a user by username as a list of user
  Future<User> getUserListByUsernameAndPassword(String username) async {
    Database db = await this.database;
    List<Map> results = await db.query(tblUser,
        columns: [colUsername, colPassword],
        where: 'username = ?',
        whereArgs: [username]);
    if (results.length > 0) {
      return new User.fromMapObject(results.first);
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> getCourseContentListByCourseName(
      int cid) async {
    Database db = await this.database;
    var result = await db
        .query(tblCourseContent, where: '$colCid = ?', whereArgs: [cid]);
    return result;
  }

  Future<List<Map<String, dynamic>>> getCategoryList() async {
    Database db = await this.database;
    var result = await db.query(tblCategory, orderBy: '$colTitle ASC');
    return result;
  } //getCategoryList

  Future<List<Map<String, dynamic>>> getCourseList() async {
    Database db = await this.database;
    var result = await db.query(tblCourse);
    return result;
  } //getCourseList

  Future<List<Map<String, dynamic>>> getCoursesListBasedOnCategory(
      int cid) async {
    Database db = await this.database;
    var result =
        await db.query(tblCourse, where: '$colCid = ?', whereArgs: [cid]);
    return result;
  }

  ////insert values into tbl user
  Future<int> insertUser(User user) async {
    Database db = await this.database;
    var result = await db.insert(tblUser, user.toMap());
    return result;
  } //insertUser

  ////insert values into tbl category
  Future<int> insertCategory(Category category) async {
    Database db = await this.database;
    var result = await db.insert(tblCategory, category.toMap());
    return result;
  } //insertCategory

  ////insert values into tbl course
  Future<int> insertCourse(Course course) async {
    Database db = await this.database;
    var result = await db.insert(tblCourse, course.toMap());
    return result;
  } //insertCourse

  //insert values into table course content
  Future<int> insertCourseContent(CourseContent course) async {
    Database db = await this.database;
    var result = await db.insert(tblCourseContent, course.toMap());
    return result;
  }

  ///update values of tbl user
  Future<int> updateUser(User user) async {
    Database db = await this.database;
    var result = db.update(tblUser, user.toMap(),
        where: '$colId = ?', whereArgs: [user.id]);
    return result;
  } //updateUser

  ///update values of tbl category
  Future<int> updateCategory(Category category) async {
    Database db = await this.database;
    var result = db.update(tblCategory, category.toMap(),
        where: '$colId = ?', whereArgs: [category.id]);
    return result;
  } //updateCategory

  ///update values of tbl category
  Future<int> updateCourse(Course course) async {
    Database db = await this.database;
    var result = db.update(tblCourse, course.toMap(),
        where: '$colId = ?', whereArgs: [course.id]);
    return result;
  } //updateCategory

  ///delete value in tbl user
  Future<int> deleteUser(int id) async {
    Database db = await this.database;
    String sql = 'DELETE FROM $tblUser where $colId = $id';
    int result = await db.rawDelete(sql);
    return result;
  } //deleteUser

  ///delete value in tbl category
  Future<int> deleteCategory(int id) async {
    Database db = await this.database;
    String sql = 'DELETE FROM $tblCategory where $colId = $id';
    int result = await db.rawDelete(sql);
    return result;
  } //deleteCategory

  //delete course content
  Future<int> deleteCourseContent(int id) async {
    Database db = await this.database;
    String sql = 'DELETE FROM  $tblCourseContent where $colId = $id';
    int result = await db.rawDelete(sql);
    return result;
  } //deleteCourseContent

  ///delete value in tbl course
  Future<int> deleteCourse(int id) async {
    Database db = await this.database;
    String sql = 'DELETE FROM $tblCourse where $colId = $id';
    int result = await db.rawDelete(sql);
    return result;
  } //deleteCourse

  //get count of rows of users
  Future<int> getCountOfUsers() async {
    Database db = await this.database;
    List<Map<String, dynamic>> list =
        await db.rawQuery('SELECT COUNT (*) FROM $tblUser');
    int result = Sqflite.firstIntValue(list);
    return result;
  } //getCountOfUsers

//get count of rows of categories
  Future<int> getCountOfCategories() async {
    Database db = await this.database;
    List<Map<String, dynamic>> list =
        await db.rawQuery('SELECT COUNT (*) FROM $tblCategory');
    int result = Sqflite.firstIntValue(list);
    return result;
  } //getCountOfCategories

//get count of rows of courses
  Future<int> getCountOfCourses() async {
    Database db = await this.database;
    List<Map<String, dynamic>> list =
        await db.rawQuery('SELECT COUNT (*) FROM $tblCourse');
    int result = Sqflite.firstIntValue(list);
    return result;
  } //getCountOfCourses

  //get count of rows of courses content
  Future<int> getCountOfCoursesContent() async {
    Database db = await this.database;
    List<Map<String, dynamic>> list =
        await db.rawQuery('SELECT COUNT (*) FROM $tblCourseContent');
    int result = Sqflite.firstIntValue(list);
    return result;
  } //getCountOfCoursesContent

//read values in user format
  Future<List<User>> getAllUsers() async {
    var listMap = await getUserList();
    int count = listMap.length;
    List<User> user = List<User>();
    for (int i = 0; i < count; i++) user.add(User.fromMapObject(listMap[i]));

    return user;
  } //getAllUsers

//read values in category format
  Future<List<Category>> getAllCategories() async {
    var listMap = await getCategoryList();
    int count = listMap.length;
    List<Category> category = List<Category>();
    for (int i = 0; i < count; i++)
      category.add(Category.fromMapObject(listMap[i]));
    return category;
  } //getAllCategories

//read values in category format
  Future<List<Course>> getAllCourses() async {
    var listMap = await getCourseList();
    int count = listMap.length;
    List<Course> course = List<Course>();
    for (int i = 0; i < count; i++)
      course.add(Course.fromMapObject(listMap[i]));
    return course;
  } //getAllCourses

  Future<List<Course>> getAllCoursesBasedOnCategory(int cid) async {
    var listMap = await getCoursesListBasedOnCategory(cid);
    int count = listMap.length;
    List<Course> course = List<Course>();
    for (int i = 0; i < count; i++)
      course.add(Course.fromMapObject(listMap[i]));
    return course;
  } //getAllCoursesBasedOnCategory

//list all course content based on the course
  Future<List<CourseContent>> getAllCoursesContentBasedOnTheCourse(
      int cid) async {
    var listMap = await getCourseContentListByCourseName(cid);
    int count = listMap.length;
    List<CourseContent> courseContent = List<CourseContent>();
    for (int i = 0; i < count; i++) {
      courseContent.add(CourseContent.fromMapObject(listMap[i]));
    }
    return courseContent;
  }
}
