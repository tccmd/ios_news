import 'package:flutter/material.dart';
import 'package:ios_news/models/article.dart';
import 'package:ios_news/themes/app_theme.dart';
import 'package:ios_news/widgets/go_article_widget.dart';
import 'package:ios_news/widgets/news_widget_title.dart';

class NewsTrending extends StatelessWidget {
  final GlobalKey sectionKey;
  const NewsTrending({super.key, required this.sectionKey});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: sectionKey,
      padding: EdgeInsets.only(top: context.spacing40),
      decoration: BoxDecoration(color: context.bg2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NewsWidgetTitle(title: '트렌딩'),
          SizedBox(height: 18),
          for (final article in trendingData.sublist(0, 3))
            CardHorizon(article: article),
          ViewMore(),
        ],
      ),
    );
  }
}

class CardHorizon extends StatelessWidget {
  final Article article;

  const CardHorizon({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return GoArticleWidget(
      article: article,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: context.spacing10, horizontal: context.spacing20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: 235,
                    child: Text(article.title ?? '', style: context.koHeadline4)),
                SizedBox(height: 4),
                Text(article.metaText ?? '', style: context.koCaption2),
              ],
            ),
            Image.asset(article.imgPath ?? '', width: 70),
          ],
        ),
      ),
    );
  }
}

List<Article> trendingData = [
  Article(
      imgPath: 'assets/imgs/trending_1.png',
      title: 'BoA "내년 완만한 인플레이션"…애플·인텔·퀄컴 등 수혜주',
      publishedAt: DateTime.now().subtract(Duration(minutes: 9)),
      // ✅ 9분 전
      source: '파이낸셜 타임스'),
  Article(
      imgPath: 'assets/imgs/trending_2.png',
      title: 'S&P500 입성 D-3… 800억 달러ㆍ170%, 숫자로 보는 테슬라',
      publishedAt: DateTime.now().subtract(Duration(hours: 2)),
      // ✅ 2시간 전
      source: '파이낸셜 타임스'),
  Article(
      imgPath: 'assets/imgs/trending_3.png',
      title: '왜 유신론자들이 더 폭력적인가?',
      publishedAt: DateTime.now().subtract(Duration(days: 1)),
      // ✅ 1일 전
      source: '파이낸셜 타임스'),
  Article(
    imgPath: 'assets/imgs/trending_2.png',
    title: '테슬라, 전기차 시장 점유율 확대',
    description: '전기차 산업이 빠르게 성장하면서 글로벌 시장 판도가 바뀌고 있다...',
    publishedAt: DateTime.now().subtract(Duration(hours: 2)),
    // ✅ 2시간 전
    source: '블룸버그',
  ),
  Article(
    imgPath: 'assets/imgs/trending_3.png',
    title: '국내 반도체 업계, 생산량 조절 나서',
    description: '글로벌 경기 둔화로 반도체 수요가 줄어들면서...',
    publishedAt: DateTime.now().subtract(Duration(days: 1)),
    // ✅ 1일 전
    source: '연합뉴스',
  ),
];

class ViewMore extends StatelessWidget {
  const ViewMore({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(height: 0.5, color: context.line2, indent: context.spacing20, endIndent: context.spacing20),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Text('더보기', style: context.koButton),
        ),
      ],
    );
  }
}