import 'package:flutter/material.dart';

class SpecieCard extends StatelessWidget {
  const SpecieCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: Theme.of(context).appBarTheme.backgroundColor, 
          borderRadius: BorderRadius.circular(24)
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            
            borderRadius: BorderRadius.circular(24),
            onTap: (){},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text("Banana", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                      Text("Musa spp", style: TextStyle(fontStyle: FontStyle.italic, color: Color.fromARGB(255, 192, 151, 3)),),
                      LimitedBox(
                        maxWidth: MediaQuery.of(context).size.width - 230,
                        child: const Text(
                          "Nome científico: Musa spp. A banana é a fruta fresca mais consumida no mundo. Além de maior consumidor mundial, o Brasil é o quarto maior produtor, com 6,6 milhões de toneladas produzidas em 455 mil hectares, metade originária da agricultura familiar.",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 14
                          ),
                          maxLines: 5,
                          softWrap: true,
                        ),
                      ),
                    ]),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}