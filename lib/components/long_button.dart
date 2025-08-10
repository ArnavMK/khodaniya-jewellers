import 'package:flutter/material.dart';

class LongButton extends StatelessWidget {

  final String text;
  final GestureTapCallback? onTap;
  final Color? backgroundColor;
  final Color? borderColor;

  const LongButton ({
    required this.text,
    required this.onTap,
    this.backgroundColor,
    this.borderColor,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25.0),
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.black,
          borderRadius: BorderRadius.circular(10),
          border: borderColor != null ? Border.all(color: borderColor!, width: 1.5) : null,
        ),
        child: Center(
          child: Text(
            text, 
            style: TextStyle(color: backgroundColor == Colors.transparent ? borderColor : Colors.white),
          )
        ) 
      ),
    );
  }
}
