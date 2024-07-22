import 'package:flutter/material.dart';

class WelcomeButton extends StatelessWidget {
  const WelcomeButton(
      {super.key, this.buttonText, this.onTap, this.color, this.textColor, this.borderColor});
  final String? buttonText;
  final Widget? onTap;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (e) => onTap!,
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: color!,
          border: Border.all(
            color: borderColor!,
          ),
          // borderRadius: const BorderRadius.only(
          //   topLeft: Radius.circular(30),
          //   topRight: Radius.circular(30),
          // ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          buttonText!,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: textColor!,
          ),
        ),
      ),
    );
  }
}