import 'package:flutter/material.dart';

class SearchSpecie extends StatelessWidget {
  const SearchSpecie({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 0, bottom: 8),
      child: TextFormField(
        decoration: InputDecoration(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * .065,
            maxWidth: MediaQuery.of(context).size.width
          ),
          prefixIcon: Icon(Icons.spa_rounded, size: 18, color: Colors.green.withAlpha(120)),
          suffixIcon: IconButton(
            icon: Icon(Icons.search_outlined, size: 18,),
            onPressed: () {},
          ),
          contentPadding: EdgeInsets.only(top: 12),
          filled: true,
          fillColor: Theme.of(context).appBarTheme.backgroundColor!.withAlpha(80),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Theme.of(context).appBarTheme.backgroundColor!.withAlpha(10),
              width: 1,
            )
          ),
        ),
      ),
    );
  }
}