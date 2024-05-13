import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_app/pages/widgets/search_specie.dart';
import 'package:stock_app/pages/widgets/specie_card.dart';
import 'package:stock_app/store/login.store.dart';

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
    final store = Provider.of<LoginStore>(context);

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 12, 0, 4),
            child: Text(
              "Bem-vindo, ${store.username}! 🌿",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchSpecie(),
                Text(
                  "Últimas espécies identificadas",
                  style: TextStyle(fontSize: 16),
                ),
                Divider(),
              ],
            ),
          ),
          SizedBox(
            height: 175,
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
                )),
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
                                : Theme.of(context)
                                .appBarTheme
                                .backgroundColor),
                      ),
                    ),
                  )),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ajude a catalogar novas espécies!",
                  style: TextStyle(fontSize: 16),
                ),
                Divider(),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).appBarTheme.backgroundColor,
                borderRadius: BorderRadius.circular(24)),
            height: 166,
            width: double.infinity,
            margin: EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        "https://www.infoescola.com/wp-content/uploads/2010/04/banana_600797891.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Essa espécie é: \"Musa spp\"?",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Text("Sim"),
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStatePropertyAll(
                                      Colors.amber.shade300)),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text("Não"),
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStatePropertyAll(
                                      Colors.black.withAlpha(20))),
                            )
                          ],
                        ),
                        Text(
                          "Agradecemos seu feedback! ❤️",
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
