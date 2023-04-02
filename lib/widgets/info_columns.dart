import 'package:flutter/material.dart';
import '../utilities/constants.dart';

class InfoColumn extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;

  InfoColumn(
      {required this.imagePath, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imagePath,
          width: 60,
        ),
        Text(
          title,
          style: kTitleTextStyle,
        ),
        Text(
          subtitle,
          style: kSubtitleTextStyle,
        ),
      ],
    );
  }
}