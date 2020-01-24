import 'package:els2020/admin_screens/admin_dashboard.dart';
import 'package:els2020/admin_screens/create_category.dart';
import 'package:els2020/admin_screens/create_course.dart';
import 'package:els2020/admin_screens/delete_category.dart';
import 'package:els2020/admin_screens/delete_course.dart';
import 'package:els2020/admin_screens/registered_users.dart';
import 'package:els2020/screens/category_courses.dart';
import 'package:els2020/screens/category_screen.dart';
import 'package:els2020/screens/course_screen.dart';
import 'package:els2020/screens/courses_screen.dart';
import 'package:els2020/screens/login_screen.dart';
import 'package:els2020/screens/register_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
      case '/register':
        return MaterialPageRoute(
          builder: (_) => RegisterScreen(),
        );
      case '/registered_users':
        return MaterialPageRoute(
          builder: (_) => RegisteredUsers(),
        );
      case '/admin_dashboard':
        return MaterialPageRoute(
          builder: (_) => AdminDashboard(),
        );
      case '/category':
        return MaterialPageRoute(
          builder: (_) => CategoryScreen(),
        );
      case '/course':
        return MaterialPageRoute(
          builder: (_) => CourseScreen(),
        );
      case '/courses':
        return MaterialPageRoute(
          builder: (_) => CoursesScreen(),
        );
      case '/create_category':
        return MaterialPageRoute(
          builder: (_) => CreateCategory(),
        );
      case '/delete_category':
        return MaterialPageRoute(
          builder: (_) => DeleteCategory(),
        );
      case '/create_course':
        return MaterialPageRoute(
          builder: (_) => CreateCourse(),
        );
      case '/delete_course':
        return MaterialPageRoute(
          builder: (_) => DeleteCourse(),
        );
      case '/category_courses':
        return MaterialPageRoute(
          builder: (_) => CategoryCourses(args),
        );
      default:
        return _errorRoute();
    } //switch
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error Page'),
        ),
        body: Center(
          child: Text('AN ERROR HAS OCCURED!'),
        ),
      );
    });
  } //error ROUTE

}
