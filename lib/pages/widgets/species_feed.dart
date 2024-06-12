import 'package:flutter/material.dart';
import 'package:stock_app/models/specie.dart';
import 'package:stock_app/pages/widgets/specie_card.dart';
import 'package:stock_app/pages/widgets/specie_note.dart';

class SpeciesFeed extends StatelessWidget {
  final List<Specie> species;
  final ScrollController? controller;
  const SpeciesFeed({
    super.key,
    this.species = const [],
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: species.length,
          controller: controller,
          itemBuilder: (context, index) => Column(
            children: [
              SpecieNote(
                specie: species[index],
              )
            ],
          ),
        ),
      ],
    );
  }
}
