import 'package:flutter/material.dart';
import 'package:stock_app/pages/home.dart';

Map<String, Widget Function(BuildContext)> routes = {
  "/": (context) => Home(),
};