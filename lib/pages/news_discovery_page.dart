import 'package:flutter/material.dart';
import 'package:ios_news/widgets/news_latest_article.dart';
import 'package:ios_news/widgets/news_topic.dart';
import 'package:ios_news/widgets/news_trending.dart';

class NewsDiscoveryPage extends StatefulWidget {
  final GlobalKey sectionKeyLatest;
  final GlobalKey sectionKeyTrending;
  final GlobalKey sectionKeyTopic;
  const NewsDiscoveryPage({super.key, required this.sectionKeyLatest, required this.sectionKeyTrending, required this.sectionKeyTopic});

  @override
  State<NewsDiscoveryPage> createState() => _NewsDiscoveryPageState();
}

class _NewsDiscoveryPageState extends State<NewsDiscoveryPage> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewsLatestArticle(sectionKey: widget.sectionKeyLatest),
        NewsTrending(sectionKey: widget.sectionKeyTrending),
        NewsTopic(sectionKey: widget.sectionKeyTopic),
      ],
    );
  }
}
