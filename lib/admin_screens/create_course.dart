import 'package:els2020/model/Category.dart';
import 'package:els2020/model/Course.dart';
import 'package:els2020/model/database_helper.dart';
import 'package:els2020/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class CreateCourse extends StatefulWidget {
  @override
  _CreateCourseState createState() => _CreateCourseState();
}

class _CreateCourseState extends State<CreateCourse> {
  String strTitle, strCid;
  TextEditingController titleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String cid = '1';
  DatabaseHelper db = DatabaseHelper();
  List<Category> categoryList;

  @override
  Widget build(BuildContext context) {
    if (categoryList == null) {
      categoryList = List<Category>();
      updateCategoryView();
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace),
          onPressed: () {
            backToDashboard();
          },
        ),
        title: Text('ADD A COURSE'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ///////////////////////////first element////////////////
              Image.asset('images/logo.png', height: 60),
              ///////////////////////////second element///////////////
              getDropDownButton(),
              //////////////////////third element///////////////////
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter the Course Name',
                  labelText: 'Enter the Course Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Colors.white, width: 24.0),
                  ),
                  prefixIcon: Icon(
                    Icons.golf_course,
                    color: Colors.white,
                  ),
                ),
                keyboardType: TextInputType.text,
                validator: validateTitle,
                controller: titleController,
              ),
              ////////////fourth element////////////////////////////////////////
              RaisedButtonWidget(
                label: 'Add a Course',
                color: Colors.green,
                onPressed: () {
                  addCourse();
                },
              ),
            ],
          ),
        ),
      ),
    );
  } //buildContext

  //////////////////////////////////////////////VALIDATIONS/////////////////
  /////////////////////////////////////////////////////////////////////////
  String validateTitle(String value) {
    String pattern = '(^[a-zA-Z ])';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "A Course Name is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z";
    } else if (value.length < 2) {
      return "Your Course Name is too short, it must at least two characters";
    }
    return null;
  } //validateName

  /////////////////////////////////////////////////FUNCTIONS////////////////////

  //dropdown button for android devices
  DropdownButton<String> getDropDownButton() {
    //populate the currencyList
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (Category category in categoryList) {
      var newItem = DropdownMenuItem(
        child: Text(category.title),
        value: category.id.toString(),
      );
      dropDownItems.add(newItem);
    }
    //*********************************************//
    //Add the items to the drop down
    return DropdownButton<String>(
      value: cid,
      items: dropDownItems,
      onChanged: (value) {
        setState(() {
          cid = value;
          print(cid);
        });
      },
    );
  } //getDropDownButton()

  void backToTheBeginning() {
    Navigator.pop(context);
  } //backToTheBeginning

  void backToDashboard() {
    Navigator.pushNamed(context, '/admin_dashboard');
  } //backToDashboard

//addCategory
  void addCourse() async {
    int cidToInt = int.parse(cid);
    Course course = Course(cidToInt, titleController.text);
    if (_formKey.currentState.validate()) {
      int result = await db.insertCourse(course);
      if (result != 0) {
        backToDashboard();
        createAlertDialog('A new Course has been Added.', context);
      }
    }
  } //addCourse

  //populate the whole category into categoryList to be used in the drop down button
  void updateCategoryView() {
    final Future<Database> dbFuture = db.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Category>> noteListFuture = db.getAllCategories();
      noteListFuture.then((categoryList) {
        setState(() {
          this.categoryList = categoryList;
          // this.count = categoryList.length;
        });
      });
    });
  }
}
