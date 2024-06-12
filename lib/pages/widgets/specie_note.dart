import 'package:flutter/material.dart';
import 'package:stock_app/models/specie.dart';

class SpecieNote extends StatelessWidget {
  final Specie specie;

  const SpecieNote({super.key, required this.specie});

  @override
  Widget build(BuildContext context) {
    var PhoneSize = MediaQuery.of(context).size;
    var textScale = MediaQuery.of(context).textScaler.scale(1);
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: PhoneSize.width,
          height: textScale < 1.0
              ? PhoneSize.height * .2
              : textScale < 1.5
                  ? PhoneSize.height * .2 * textScale
                  : PhoneSize.height * .2 * 1.5,
          child: Material(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                width: .5,
              ),
            ),
            child: InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onTap: () {},
              child: Row(
                children: [
                  SizedBox(width: 12,),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image(
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return SizedBox(
                          width: 120,
                          height: constraints.maxHeight,
                          child: const Center(
                            child: SizedBox(
                              width: 40,
                              height: 40,
                              child: CircleAvatar(
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      width: 200,
                      image: NetworkImage(specie.image),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(specie.name),
                          Text("Registrado por: ${specie.registeredBy.username}")
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
