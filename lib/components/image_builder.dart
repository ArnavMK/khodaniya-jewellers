import 'package:flutter/material.dart';

class MyImageBuilder extends StatelessWidget {
  final String imageURL;
  const  MyImageBuilder({
    required this.imageURL,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    if (imageURL.contains("http")) {
      return Image.network(
        imageURL,
        fit: BoxFit.cover,
        width: double.infinity,
      );
    }
    return Image.asset(
      imageURL,
      fit: BoxFit.cover,
      width: double.infinity
    );
  }
}
