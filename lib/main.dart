import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_app/routes/routes.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:stock_app/store/login.store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<LoginStore>(
          create: (_) => LoginStore(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Stock App',
        theme: ThemeData(
          useMaterial3: true,
          textTheme: GoogleFonts.interTextTheme(),
          colorSchemeSeed: const Color.fromARGB(255, 0, 255, 34),
          appBarTheme: Theme.of(context).appBarTheme.copyWith(
            backgroundColor: Color.fromARGB(255, 160, 233, 173),
          ),
        ),
        initialRoute: "/",
        routes: routes,
      ),
    );
  }
}