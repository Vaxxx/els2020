import 'package:els2020/model/User.dart';
import 'package:els2020/model/database_helper.dart';
import 'package:els2020/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  DatabaseHelper db = DatabaseHelper();
  // List<User> user;

  ////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////WIDGETS////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////
  Image logo() {
    return Image.asset('images/logo.png', height: 60);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  TextFormField username() {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: 'Username',
        labelText: 'Username',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Colors.white, width: 24.0),
        ),
        prefixIcon: Icon(
          Icons.person,
          color: Colors.white,
        ),
      ),
      validator: validateUserName,
      controller: userNameController,
    );
  }

  TextFormField password() {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: 'Password',
        labelText: 'Password',
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        prefixIcon: Icon(
          Icons.https,
          color: Colors.white,
        ),
      ),
      obscureText: true,
      validator: validatePassword,
      controller: passwordController,
    );
  }

  RaisedButton loginButton() {
    return RaisedButton(
      child: const Text('LOGIN'),
      color: Colors.white.withOpacity(0.6),
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(8.0)),
      elevation: 4.0,
      splashColor: Theme.of(context).primaryColor,
      onPressed: () {
        // Perform some action
        loginDetails();
      },
    );
  }

  FlatButton signUpButton() {
    return FlatButton(
      onPressed: () {
        Navigator.pushNamed(context, '/register');
      },
      child: Text(
        "DON'T HAVE AN ACCOUNT? SIGN UP",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
  ////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////BUILD CONTEXT////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////

  Widget body(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return portrait();
    } else {
      return landscape();
    }
  }

  ////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////PORTRAIT////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////

  Widget portrait() {
    return new Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new ExactAssetImage('images/background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          //make labels and border white when not focused
          hintColor: Colors.white,
          textTheme: TextTheme(
              //make text value white
              body1: TextStyle(color: Colors.white)),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: logo(),
                  margin: EdgeInsets.symmetric(vertical: 30),
                  alignment: Alignment.bottomCenter,
                ),
              ),
              Expanded(
                child: Container(
                  child: username(),
                  alignment: Alignment.bottomCenter,
                ),
                flex: 1,
              ),
              Expanded(
                child: Container(
                  child: password(),
                  margin: EdgeInsets.only(top: 12),
                  alignment: Alignment.topCenter,
                ),
                flex: 1,
              ),
              Expanded(
                child: Container(
                  child: loginButton(),
                  alignment: Alignment.topCenter,
                ),
                flex: 1,
              ),
              Expanded(
                child: Container(
                  child: signUpButton(),
                  alignment: Alignment.bottomCenter,
                ),
                flex: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  ////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////LANDSCAPE///////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////
  Widget landscape() {
    return new Stack(
      children: <Widget>[
        Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new ExactAssetImage('images/background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.only(top: 80),
          child: logo(),
        ),
        Theme(
          data: Theme.of(context).copyWith(
            //make labels and border white when not focused
            hintColor: Colors.white,
            textTheme: TextTheme(
                //make text value white
                body1: TextStyle(color: Colors.white)),
          ),
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: username(),
                        margin: EdgeInsets.symmetric(horizontal: 5),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: password(),
                        margin: EdgeInsets.symmetric(horizontal: 5),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: loginButton(),
                        margin: EdgeInsets.symmetric(horizontal: 5),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: signUpButton(),
                        margin: EdgeInsets.symmetric(horizontal: 5),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: body(context));
  }

////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////VALIDATION////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////
  ///////VALIDATE USER
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
  } //validateName

  String validatePassword(String value) {
    if (value.length == 0) {
      return "A Password  is Required";
    } else if (value.length < 5) {
      return "Your Password is too short, it must at least five characters";
    }
    return null;
  } //validateName

////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////EXTRA FUNCTIONALITY/////////
  ///////////////////////////////////////////////
  ///LOGIN USER
  void loginDetails() async {
    String username = userNameController.text;
    String pass = passwordController.text;
    User user = await db.getUserListByUsernameAndPassword(username);
    //check first to see if the user is an Admin
    if (username.trim().toLowerCase() == 'admin' &&
        pass.trim().toLowerCase() == 'admin') {
      ///user is an admin
      //navigate to the admin dashboard
      Navigator.pushNamed(context, '/admin_dashboard');
      createAlertDialog('Welcome Admin', context);
    } else if (user != null) {
      //meaning a record with the details exists
      Navigator.pushNamed(context, '/category');
      createAlertDialog('Welcome!', context);
    } else {
      ///check if a user exist in the database
      ///username: john
      ///password:129111
      //meaning there is no record of such
      createAlertDialog(
          'No User with such credentials exist in our records', context);
    }
  } //loginDetails

}
