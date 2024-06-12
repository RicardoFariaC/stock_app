import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_app/pages/views/home_view.dart';
import 'package:stock_app/pages/views/profile_view.dart';
import 'package:stock_app/pages/views/redirect_view.dart';
import 'package:stock_app/pages/views/search_view.dart';
import 'package:stock_app/store/login.store.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

int selectedIndex = 0;

class _HomeState extends State<Home> {
  bool isActive = true;
  final List<Widget> viewsList = [
    const HomeView(),
    const RedirectView(),
    const ProfileView(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<LoginStore>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return SearchView();
                  },
                ),
              );
            },
            icon: Icon(
              Icons.search_rounded,
              color: Colors.white,
            ),
          ),
        ],
        title: Image.asset(
          "assets/stock_logo.png",
          height: 48,
          width: 48,
        ),
        centerTitle: true,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide.none,
        ),
      ),
      body: Stack(
        children: [
          viewsList[selectedIndex],
          Align(
            alignment: Alignment.bottomCenter,
            child: _navBar(<IconData>[
              Icons.home_rounded,
              Icons.camera_alt_rounded,
              Icons.account_circle_rounded
            ], <String>[
              "Início",
              "Identificar",
              (store.username)
            ]),
          ),
        ],
      ),
    );
  }

  Widget _navBar(List<IconData> navBarIcons, List<String> navBarLabels) {
    double phoneScale = MediaQuery.of(context).textScaler.scale(1);
    return Container(
      height: phoneScale < 1.0
          ? MediaQuery.of(context).size.height * .07
          : phoneScale < 1.5
              ? MediaQuery.of(context).size.height * .075 * phoneScale
              : MediaQuery.of(context).size.height * .066 * 1.5,
      margin: const EdgeInsets.only(right: 12, left: 12, bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withAlpha(20),
              blurRadius: 20,
              spreadRadius: 10)
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: navBarIcons.map((icon) {
          int index = navBarIcons.indexOf(icon);
          bool isSelected = selectedIndex == index;
          return Material(
            color: Colors.transparent,
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: () {
                setState(() {
                  selectedIndex = index;
                  isActive = selectedIndex != 1;
                });
              },
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(
                        top: 10, bottom: 5, left: 20, right: 20),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        AnimatedContainer(
                          curve: Curves.easeIn,
                          duration: const Duration(milliseconds: 150),
                          width: 55,
                          height: 25,
                          decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.black.withAlpha(20)
                                  : Colors.transparent,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(32)),
                        ),
                        Icon(icon),
                      ],
                    ),
                  ),
                  Text(
                    navBarLabels[index],
                    style: TextStyle(
                      fontSize: phoneScale < 1.0
                          ? 16
                          : phoneScale < 1.5
                              ? 16
                              : 8,
                    ),
                  )
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
