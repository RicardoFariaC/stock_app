import 'package:flutter/material.dart';
import 'package:stock_app/models/repository/specie_repository.dart';
import 'package:stock_app/models/specie.dart';

class ListItems extends StatefulWidget {
  const ListItems({super.key});

  @override
  State<ListItems> createState() => _ListItemsState();
}

class _ListItemsState extends State<ListItems> {
  SpecieRepository species = SpecieRepository();
  List<Specie> specieList = [];
  late final Future dataFetch;

  @override
  void initState() {
    super.initState();
    dataFetch = getSpecies();
  }

  getSpecies() async {
    // await species.getActiveSpecies();
    setState(() {
      specieList = species.species;
    });
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: dataFetch,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (specieList.isEmpty) {
            return const Center(
              child: Text(
                "Não foi encontrado nada",
                style: TextStyle(fontSize: 16),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: specieList.length,
              itemBuilder: (context, index) => Column(
                children: [
                  Text(specieList[index].name)
                ],
              ),
            );
          }
        } else {
          return const Stack(
            children: [
              CircularProgressIndicator()
            ],
          );
        }
      },
    );
  }
}
