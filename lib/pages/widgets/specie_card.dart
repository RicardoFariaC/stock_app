import 'package:flutter/material.dart';

class SpecieCard extends StatelessWidget {
  const SpecieCard({super.key});

  @override
  Widget build(BuildContext context) {
    double phoneScale = MediaQuery.of(context).textScaler.scale(1);

    return Expanded(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * .9,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
              color: Theme.of(context).appBarTheme.backgroundColor,
              borderRadius: BorderRadius.circular(24)),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: phoneScale < 1.0
                          ? MediaQuery.of(context).size.height * .2
                          : phoneScale < 1.5
                              ? MediaQuery.of(context).size.height *
                                  .25 *
                                  phoneScale
                              : MediaQuery.of(context).size.height * .15 * 1.5,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          "https://www.infoescola.com/wp-content/uploads/2010/04/banana_600797891.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, top: 16, right: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Banana",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: phoneScale < 1.0
                                      ? 30
                                      : phoneScale < 1.5
                                          ? 16
                                          : 12,
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Musa spp",
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  decoration: TextDecoration.underline,
                                  fontSize: phoneScale < 1.0
                                      ? 30
                                      : phoneScale < 1.5
                                          ? 16
                                          : 12,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          LimitedBox(
                            maxWidth: MediaQuery.of(context).size.width - 230,
                            child: Text(
                              "A banana é a fruta fresca mais consumida no mundo. Além de maior consumidor mundial, o Brasil é o quarto maior produtor, com 6,6 milhões de toneladas produzidas em 455 mil hectares, metade originária da agricultura familiar.",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: phoneScale < 1.0
                                    ? 20
                                    : phoneScale < 1.5
                                        ? 12
                                        : 10,
                              ),
                              maxLines: 7,
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
