import 'package:flutter/material.dart';
import 'package:ios_news/themes/app_theme.dart';

class NewsTabBar extends StatelessWidget {
  final TabController? tabController;
  const NewsTabBar({super.key, this.tabController});

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(border: Border.all()),
      // width: 173,
      height: 16 + 4 + 10,
      child: TabBar(
          controller: tabController,
          indicatorSize: TabBarIndicatorSize.label,
          indicator: BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: context.accent, width: 2))),
          padding: EdgeInsets.zero,
          indicatorPadding: EdgeInsets.zero,
          labelPadding: EdgeInsets.only(right: 16),
          // labelPadding: EdgeInsets.zero,
          dividerHeight: 0,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          // indicatorAnimation: TabIndicatorAnimation.linear,
          tabs: const <Widget>[
            Tab(text: '최신'),
            Tab(text: '트렌딩'),
            Tab(text: '토픽'),
            Tab(text: '팟캐스트'),
          ]),
    );
  }
}
