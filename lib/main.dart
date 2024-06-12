import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_app/routes/routes.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:stock_app/store/login.store.dart';

String? username;
String? token;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  username = prefs.getString("username");
  token = prefs.getString("token");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<LoginStore>(
          create: (_) {
            final store = LoginStore();
            store.setUsername(username ?? "");
            store.setBearerToken("Bearer $token" ?? "");
            return store;
          },
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
            backgroundColor: const Color.fromARGB(255, 160, 233, 173),
          ),
        ),
        initialRoute: token == null || username == null ? "/login" : "/home",
        routes: routes,
      ),
    );
  }
}