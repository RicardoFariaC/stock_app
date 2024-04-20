import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stock_app/pages/widgets/search_specie.dart';
import 'package:stock_app/pages/widgets/specie_card.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

int selectedIndex = 0;

class _HomeState extends State<Home> {
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
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/stock_logo.png",
          height: 48,
          width: 48,
        ),
        centerTitle: true,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide.none
        ),
        leading: IconButton(
          icon: const Icon(Icons.person_rounded, color: Colors.white,),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.settings_rounded, color: Colors.white),
          )
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child:
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 12, 0, 4),
                    child: Text("Bem-vindo, Ricardo! 🌿", style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                    ),),
                  ),
                  const SizedBox(height: 5,),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(8,0,8,0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SearchSpecie(),
                        Text(
                          "Últimas espécies identificadas",
                          style: TextStyle(
                            fontSize: 16
                          ),
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
                      )
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(5, (index) => 
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: currentIndex == index ? Colors.amber : Theme.of(context).appBarTheme.backgroundColor
                              ),
                            ),
                        ),
                        )
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8,0,8,0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Ajude a catalogar novas espécies!", style: TextStyle(
                              fontSize: 16
                            ),),
                            Divider(),
                        ],
                      ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).appBarTheme.backgroundColor,
                      borderRadius: BorderRadius.circular(24)
                    ),
                    height: 166,
                    width: double.infinity,
                    margin: EdgeInsets.all(8),
                    child:
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 150,
                                height: 150,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.network("https://www.infoescola.com/wp-content/uploads/2010/04/banana_600797891.jpg",
                                  fit: BoxFit.cover,),
                                ),
                              ),
                              SizedBox(width: 15,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("Essa espécie é: \"Musa spp\"?", style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),),
                              Row(
                                children: [
                                  TextButton(onPressed: (){}, child: Text("Sim"), style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.amber.shade300)),),
                                  SizedBox(width: 15,),
                                  TextButton(onPressed: (){}, child: Text("Não"), style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black.withAlpha(20))),)
                                ],
                              ),
                              Text("Agradecemos seu feedback! ❤️", style: TextStyle(
                                fontSize: 12
                              ),)

                                ],
                              ),
                            ],
                          ),
                        ),
                    ),
                ],
              )
          ),
          Align(
            alignment: Alignment.bottomCenter, 
            child: _navBar(<IconData> [ Icons.home_rounded, Icons.camera_alt_rounded, Icons.history_rounded ], <String> [ "Início", "Identificar", "Histórico" ]),
          ),
        ],
      ),
    );

  }
  Widget _navBar(List<IconData> navBarIcons, List<String> navBarLabels) {
    return Container(
      height: 65,
      margin: const EdgeInsets.only(
        right: 12, left: 12, bottom: 12
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 20,
            spreadRadius: 10
          )
        ]
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
              customBorder: CircleBorder(),
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 10, bottom: 5, left: 35, right: 35),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        AnimatedContainer(
                          curve: Curves.easeIn,
                          duration: Duration(milliseconds: 150),
                          width: 55,
                          height: 25,
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.black.withAlpha(20) : Colors.transparent,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(32)
                          ),
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