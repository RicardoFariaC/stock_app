import 'package:flutter/material.dart';

class CameraButton extends StatelessWidget {
  final void Function() onPressed;
  const CameraButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Material(
          shape: CircleBorder(),
          child: InkWell(
            customBorder: CircleBorder(),
            onTap: onPressed,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,

                  ),
                  height: MediaQuery.of(context).size.height * .1,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Theme.of(context).appBarTheme.backgroundColor!,
                          width: 2
                      )
                  ),
                  height: MediaQuery.of(context).size.height * .09,
                ),
              ],
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * .05,
        )
      ],
    );
  }
}
