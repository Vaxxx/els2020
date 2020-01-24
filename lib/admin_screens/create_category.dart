import 'package:els2020/model/Category.dart';
import 'package:els2020/model/database_helper.dart';
import 'package:els2020/utilities/constants.dart';
import 'package:flutter/material.dart';

class CreateCategory extends StatefulWidget {
  @override
  _CreateCategoryState createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  String strTitle;
  TextEditingController titleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DatabaseHelper db = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace),
          onPressed: () {
            backToDashboard();
          },
        ),
        title: Text('ADD A CATEGORY'),
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
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter the Category Name',
                  labelText: 'Enter the Category Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Colors.white, width: 24.0),
                  ),
                  prefixIcon: Icon(
                    Icons.category,
                    color: Colors.white,
                  ),
                ),
                keyboardType: TextInputType.text,
                validator: validateTitle,
                controller: titleController,
              ),
              ////////////third element
              RaisedButtonWidget(
                label: 'Add a Category',
                color: Colors.green,
                onPressed: () {
                  addCategory();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  //////////////////////////////////////////////VALIDATIONS/////////////////
  /////////////////////////////////////////////////////////////////////////
  String validateTitle(String value) {
    String pattern = '(^[a-zA-Z ])';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "A Category Name is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z";
    } else if (value.length < 2) {
      return "Your Category Name is too short, it must at least two characters";
    }
    return null;
  } //validateName

  /////////////////////////////////////////////////FUNCTIONS////////////////////

  void backToTheBeginning() {
    Navigator.pop(context);
  } //backToTheBeginning

  void backToDashboard() {
    Navigator.pushNamed(context, '/admin_dashboard');
  } //backToDashboard

  //addCategory
  void addCategory() async {
    Category category = Category(titleController.text);
    if (_formKey.currentState.validate()) {
      int result = await db.insertCategory(category);
      if (result != 0) {
        backToDashboard();
        createAlertDialog('A new Category has been Added.', context);
      }
    }
  } //addCategory
}
