import 'package:flutter/material.dart';
import 'package:ios_news/themes/app_theme.dart';
import 'package:ios_news/widgets/news_tab_bar.dart';

class NewsAppbar extends StatefulWidget {
  final double offset;
  final TabController? tabController;

  const NewsAppbar({super.key, required this.offset, this.tabController});

  @override
  State<NewsAppbar> createState() => _NewsAppbarState();
}

class _NewsAppbarState extends State<NewsAppbar> {
  @override
  Widget build(BuildContext context) {
    final bool isScrolled = widget.offset > 0;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: isScrolled ? (106) : (106 + 40),
      decoration: BoxDecoration(
        color: context.bg3,
      ),
      padding: EdgeInsets.symmetric(horizontal: context.spacing20),
      alignment: Alignment.bottomLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            style: isScrolled ? context.koHeadline2 : context.koHeadline1.copyWith(fontWeight: FontWeight.w900),
            child: const Text('오늘의 발견'),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: isScrolled ? 2 : 10,
          ),
          NewsTabBar(tabController: widget.tabController),
        ],
      ),
    );
  }
}
