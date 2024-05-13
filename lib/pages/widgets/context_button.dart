import 'package:flutter/material.dart';

class ContextButton extends StatelessWidget {
  final Icon icon;
  final void Function() onPressed;
  final Text text;

  const ContextButton(
      {super.key,
      required this.icon,
      required this.onPressed,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 0),
      child: FilledButton(
        style: ButtonStyle(
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              icon,
              SizedBox(
                width: 32,
              ),
              Expanded(child: text)
            ],
          ),
        ),
      ),
    );
  }
}
