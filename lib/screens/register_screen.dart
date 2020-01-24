import 'package:els2020/model/User.dart';
import 'package:els2020/model/database_helper.dart';
import 'package:els2020/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String strFullName,
      strEmail,
      strUserName,
      strPassword; //variables to store the value of the name and
  final _formKey =
      GlobalKey<FormState>(); //key to determine the state of the validation
  bool _validate = false; //initially does not require validation

  //create an instance of DatabaseHelper
  DatabaseHelper db = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return portrait();
    } else {
      return landscape();
    }
  } //buildContext

  Widget portrait() {
    return WillPopScope(
      onWillPop: () {
        backToTheBeginning();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.keyboard_backspace),
            onPressed: () {
              backToTheBeginning();
            },
          ),
          title: Text('Register Here'),
          actions: <Widget>[
            Icon(Icons.arrow_downward),
          ],
        ),
        body: Form(
          key: _formKey,
          autovalidate: _validate,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              logo(),
              userName(),
              fullName(),
              emailAddress(),
              password(),
              register(),
            ],
          ),
        ),
      ),
    );
  } //portrait

  Widget landscape() {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace),
          onPressed: () {
            backToTheBeginning();
          },
        ),
        title: Text('Register Here'),
        actions: <Widget>[
          Icon(Icons.arrow_downward),
        ],
      ),
      body: Form(
        key: _formKey,
        autovalidate: _validate,
        child: Column(
          children: <Widget>[
            userName(),
            fullName(),
            emailAddress(),
            password(),
            register(),
          ],
        ),
      ),
    );
  } //landscape

  ////////////////////////////////////////////////////
  ////////////////////////WIDGETS/////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////
  /////////Full Name Widget//////////////////////////////////////////////////////////
  TextFormField fullName() {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: 'Full Name',
        labelText: 'Full Name',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Colors.white, width: 24.0),
        ),
        prefixIcon: Icon(
          Icons.person,
          color: Colors.white,
        ),
      ),
      keyboardType: TextInputType.text,
      validator: validateFullName,
      onSaved: (val) {
        strFullName = val;
      },
    );
  }

  /////////////////Image /////////////////////////////
  Image logo() {
    return Image.asset(
      'images/els.png',
    );
  } //logo

/////////////USER NAME ///////////////////////////////////////////
  TextFormField userName() {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: 'User Name',
        labelText: 'User Name',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Colors.white, width: 24.0),
        ),
        prefixIcon: Icon(
          Icons.person_pin,
          color: Colors.white,
        ),
      ),
      keyboardType: TextInputType.text,
      validator: validateUserName,
      onSaved: (val) {
        strUserName = val;
      },
    );
  } //user name

  ////////////////Email Address//////////////////////////////////////////////////////////
  TextFormField emailAddress() {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: 'Email Address',
        labelText: 'Email Address',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Colors.white, width: 24.0),
        ),
        prefixIcon: Icon(
          Icons.email,
          color: Colors.white,
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: validateEmail,
      onSaved: (val) {
        strEmail = val;
      },
    );
  } //emailAddress

///////////
//////////////PASSWORD/////////////
  TextFormField password() {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: 'Password',
        labelText: 'Password',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Colors.white, width: 24.0),
        ),
        prefixIcon: Icon(
          Icons.https,
          color: Colors.white,
        ),
      ),
      keyboardType: TextInputType.text,
      obscureText: true,
      validator: validatePassword,
      onSaved: (val) {
        strPassword = val;
      },
    );
  } //password

////////////////////////RAISED BUTTON////////////////////////////////
  RaisedButton register() {
    return RaisedButton(
      child: const Text('REGISTER'),
      color: Colors.white.withOpacity(0.6),
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(8.0)),
      elevation: 4.0,
      splashColor: Theme.of(context).primaryColor,
      onPressed: () {
        // Perform some action
        validateAndRegisterAUser();
      },
    );
  } //register

  ////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////VALIDATION/////////////////////////////////////////////////////////////
/////////////////////////validators/////////////////////////////////////////////////////////////////
  String validateFullName(String value) {
    String pattern = '(^[a-zA-Z ])';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Name is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z";
    } else if (value.length < 6) {
      return "Your Full Name is too short, Please ensure you enter your First Name and Last Name and it must at least three characters";
    }
    return null;
  } //validateName

  String validateUserName(String value) {
    String pattern = '(^[a-zA-Z ])';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Name is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z";
    } else if (value.length < 3) {
      return "Your User Name is too short, it must at least three characters";
    }
    return null;
  } //validateUserName

  String validatePassword(String value) {
    if (value.length == 0) {
      return "A Password  is Required";
    } else if (value.length < 5) {
      return "Your Password is too short, it must at least five characters";
    }
    return null;
  } //validateName

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    } else {
      return null;
    }
  } //validateEmail

///////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////EXTRA FUNCTIONALITY////////////////////////
  ///REGISTER A NEW USER//////////////////////////////////////////////////////
  void validateAndRegisterAUser() async {
    if (_formKey.currentState.validate()) {
      // No any error in validation
      _formKey.currentState.save();
      print(
          'Full Name: $strFullName, Email Address: $strEmail, User Name: $strUserName, Password: $strPassword');

      //create a user with the form that has been filled by the user
      User user = new User(strFullName, strEmail, strUserName, strPassword);
      print('User: $user');
      int result = await db.insertUser(user);
      setState(() {
        if (result != 0) {
          backToTheBeginning();
          print('e work o');
          createAlertDialog('A New User has been Created', context);
        } else
          print('e no work');
      });
    } else {
      // validation error
      setState(() {
        _validate = true;
        createAlertDialog(
            'There is an error in creating your profile', context);
      });
    }
  }

  void backToTheBeginning() {
    Navigator.pop(context);
  } //backToTheBeginning

} //end class
