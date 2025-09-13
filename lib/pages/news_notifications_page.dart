import 'package:flutter/material.dart';

class NewsNotificationsPage extends StatefulWidget {
  const NewsNotificationsPage({super.key});

  @override
  State<NewsNotificationsPage> createState() => _NewsNotificationsPageState();
}

class _NewsNotificationsPageState extends State<NewsNotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Notification Page'));
  }
}
