import 'package:flutter/material.dart';
import 'package:stock_app/pages/widgets/search_specie.dart';
import 'package:stock_app/pages/widgets/specie_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 0;
  late PageController _specieController;

  @override
  void initState() {
    _specieController = PageController(initialPage: 0, viewportFraction: .95);
    super.initState();
  }

  @override
  void dispose() {
    _specieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double phoneScale = MediaQuery.of(context).textScaler.scale(1);
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * .6,
              child: PageView.builder(
                itemCount: 5,
                controller: _specieController,
                onPageChanged: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                },
                physics: const PageScrollPhysics(),
                itemBuilder: (context, index) => AnimatedBuilder(
                  animation: _specieController,
                  builder: (context, child) {
                    return child!;
                  },
                  child: const Column(
                    children: [
                      SpecieCard(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    5,
                    (index) => Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currentIndex == index
                              ? Colors.amber
                              : Theme.of(context).appBarTheme.backgroundColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
