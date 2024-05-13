import 'package:flutter/material.dart';
import 'package:stock_app/pages/views/home_view.dart';
import 'package:stock_app/pages/views/redirect_view.dart';

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
    Container(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        leading: IconButton(
          icon: const Icon(
            Icons.person_rounded,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings_rounded, color: Colors.white),
          )
        ],
      ),
      body: Column(
        children: [
          viewsList[selectedIndex],
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: _navBar(<IconData>[
                Icons.home_rounded,
                Icons.camera_alt_rounded,
                Icons.history_rounded
              ], <String>[
                "Início",
                "Identificar",
                "Histórico"
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navBar(List<IconData> navBarIcons, List<String> navBarLabels) {
    return Container(
      height: 65,
      margin: const EdgeInsets.only(right: 12, left: 12, bottom: 12),
      decoration: BoxDecoration(
          color: Theme.of(context).appBarTheme.backgroundColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withAlpha(20),
                blurRadius: 20,
                spreadRadius: 10)
          ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: navBarIcons.map((icon) {
          int index = navBarIcons.indexOf(icon);
          bool isSelected = selectedIndex == index;
          return Material(
            color: Colors.transparent,
            child: InkWell(
              customBorder: CircleBorder(),
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
                    margin: EdgeInsets.only(
                        top: 10, bottom: 5, left: 20, right: 20),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        AnimatedContainer(
                          curve: Curves.easeIn,
                          duration: Duration(milliseconds: 150),
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
                  Text(navBarLabels[index])
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
