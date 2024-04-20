import 'package:flutter/material.dart';
import 'package:stock_app/routes/routes.dart';
import "package:google_fonts/google_fonts.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stock App',
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.notoSansTextTheme().copyWith(
          bodyMedium: TextStyle(
            letterSpacing: 1,
            height: 1.2
          )
        ),
        colorSchemeSeed: const Color.fromARGB(255, 0, 255, 34),
        appBarTheme: Theme.of(context).appBarTheme.copyWith(
          backgroundColor: Color.fromARGB(255, 160, 233, 173),
        ),
      ),
      initialRoute: "/",
      routes: routes,
    );
  }
}