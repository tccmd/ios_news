import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ios_news/models/article.dart';
import 'package:ios_news/themes/app_theme.dart';
import 'package:ios_news/widgets/go_article_widget.dart';
import 'package:ios_news/widgets/news_widget_title.dart';

class NewsTopic extends StatelessWidget {
  final GlobalKey sectionKey;
  const NewsTopic({super.key, required this.sectionKey});

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: sectionKey,
      padding: EdgeInsets.fromLTRB(0, 50, 0, 20 + 84 + 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NewsWidgetTitle(title: '토픽'),
          ViewMore(),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              spacing: context.spacing20,
              children: [
                for (final article in topicData)
                  CardVertical(article: article),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CardVertical extends StatelessWidget {
  final Article article;

  const CardVertical({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return GoArticleWidget(
      article: article,
      child: SizedBox(
        width: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(article.imgPath ?? ''),
            SizedBox(height: 12),
            Text(article.category ?? '', style: context.koOverLine),
            SizedBox(height: 6),
            Text(article.title ?? '', style: context.koHeadline5),
          ],
        ),
      ),
    );
  }
}

const List<Article> topicData = [
  Article(
      imgPath: 'assets/imgs/topic_2.png',
      title: 'MS, 서버용 프로세서 자체 개발 착수"…악재에 인텔 주가 급락',
      category: '반도체 슈퍼사이클'),
  Article(
      imgPath: 'assets/imgs/topic_1.png',
      title: '갑자기 0%로 뚝 떨어지는 스마트폰, 추위 타는 배터리?',
      category: '생활속 과학'),
];

class ViewMore extends StatelessWidget {
  const ViewMore({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(context.spacing20, context.spacing20, context.spacing20, 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 74 - 44 - 20,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 22,
                    child: Image.asset('assets/imgs/topic_avatar.png'),
                  ),
                  Text('테크', style: context.koHeadline3),
                ],
              ),
              SvgPicture.asset('assets/icons/arrow_right.svg'),
            ],
          ),
        ),
      ],
    );
  }
}