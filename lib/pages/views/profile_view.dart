import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_app/pages/widgets/context_button.dart';
import 'package:stock_app/store/login.store.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<LoginStore>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 32,
                child: Icon(
                  Icons.person,
                  size: 32,
                ),
              ),
              Text(store.username),
              Divider(),
              ContextButton(
                icon: Icon(
                  Icons.abc_rounded,
                  size: 32,
                ),
                onPressed: () {},
                text: Text("Trocar nome de usuário"),
              ),
              SizedBox(
                height: 5,
              ),
              ContextButton(
                icon: Icon(
                  Icons.email_rounded,
                  size: 32,
                ),
                onPressed: () {},
                text: Text("Trocar email"),
              ),
              SizedBox(
                height: 5,
              ),
              ContextButton(
                icon: Icon(
                  Icons.password,
                  size: 32,
                ),
                onPressed: () {},
                text: Text("Trocar senha"),
              ),
              SizedBox(
                height: 5,
              ),
              ContextButton(
                icon: Icon(
                  Icons.exit_to_app_rounded,
                  size: 32,
                ),
                onPressed: () {
                  final prefs = SharedPreferences.getInstance().then((value) {
                    value.clear();
                    Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false,);
                  },);
                },
                text: Text("Sair"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
