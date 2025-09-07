import 'package:flutter/material.dart';
import 'package:ios_news/themes/app_theme.dart';

class NewsWidgetTitle extends StatelessWidget {
  final String title;
  const NewsWidgetTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: context.spacing20),
      child: Text(title, style: context.koHeadline2),
    );
  }
}
