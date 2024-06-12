import 'package:flutter/material.dart';
import 'package:stock_app/pages/home.dart';
import 'package:stock_app/pages/views/identify_view.dart';
import 'package:stock_app/pages/views/login_view.dart';
import 'package:stock_app/pages/views/register_view.dart';
import 'package:stock_app/pages/views/wrong_identify_view.dart';

Map<String, Widget Function(BuildContext)> routes = {
  "/login": (context) => LoginView(),
  "/register": (context) => const RegisterView(),
  "/home": (context) => Home(),
  "/camera": (context) => const IdentifyView(),
};