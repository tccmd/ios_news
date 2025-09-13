import 'package:flutter/material.dart';

class NewsSearchPage extends StatefulWidget {
  const NewsSearchPage({super.key});

  @override
  State<NewsSearchPage> createState() => _NewsSearchPageState();
}

class _NewsSearchPageState extends State<NewsSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Search Page'));
  }
}
