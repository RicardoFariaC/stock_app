import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_app/models/repository/specie_repository.dart';
import 'package:stock_app/models/specie.dart';
import 'package:stock_app/pages/widgets/search_specie.dart';
import 'package:stock_app/pages/widgets/species_feed.dart';
import 'package:stock_app/store/login.store.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final SpecieRepository _specieRepo = SpecieRepository();

  Future<List<Specie>> _searchSpecies(String bearerToken) async {
    await _specieRepo.getActiveSpecies(bearerToken);
    return _specieRepo.species;
  }

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<LoginStore>(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<List<Specie>>(
              future: _searchSpecies(store.bearerToken),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  List<Specie> specieList = snapshot.requireData;
                  return SpeciesFeed(
                    species: specieList,
                  );
                } else {
                 return Center(
                   child: CircularProgressIndicator(),
                 );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
