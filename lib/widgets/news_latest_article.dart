import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ios_news/models/article.dart';
import 'package:ios_news/themes/app_theme.dart';
import 'package:ios_news/widgets/news_widget_title.dart';

class NewsLatestArticle extends StatelessWidget {
  const NewsLatestArticle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
      child: Column(
          spacing: context.spacing20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NewsWidgetTitle(title: '최신 아티클'),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                spacing: 13,
                children: [
                  for (final article in latestData)
                    CardVertical(article: article),
                ],
              ),
            ),
            ViewMore(),
          ]),
    );
  }
}

class CardVertical extends StatelessWidget {
  final Article article;

  const CardVertical({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

      },
      child: SizedBox(
        width: 150,
        child: Column(
          children: [
            Image.asset(article.imgPath ?? ''),
            SizedBox(height: 8),
            Text(article.title ?? '', style: context.koHeadline4),
            SizedBox(height: 4),
            Text(article.description ?? '', style: context.koCaption2),
          ],
        ),
      ),
    );
  }
}

const List<Article> latestData = [
  Article(
      imgPath: 'assets/imgs/latest_1.png',
      title: '경험을 사고파는 것이 4차 산업혁명의 가능자',
      description: '대통령은 취임에 즈음하여 다음의 선서를 한다. 대통령은 조국의 평화적 통일을 위한 성실... '),
  Article(
      imgPath: 'assets/imgs/latest_2.png',
      title: '마크 트웨인의 풍자 "어떤 정치인은 개 아니다"',
      description: '대통령은 취임에 즈음하여 다음의 선서를 한다. 대통령은 조국의 평화적 통일을 위한 성실... '),
  Article(
      imgPath: 'assets/imgs/latest_1.png',
      title: '경험을 사고파는 것이 4차 산업혁명의 가능자',
      description: '대통령은 취임에 즈음하여 다음의 선서를 한다. 대통령은 조국의 평화적 통일을 위한 성실... '),
  Article(
      imgPath: 'assets/imgs/latest_1.png',
      title: '경험을 사고파는 것이 4차 산업혁명의 가능자',
      description: '대통령은 취임에 즈음하여 다음의 선서를 한다. 대통령은 조국의 평화적 통일을 위한 성실... '),
  Article(
      imgPath: 'assets/imgs/latest_2.png',
      title: '마크 트웨인의 풍자 "어떤 정치인은 개 아니다"',
      description: '대통령은 취임에 즈음하여 다음의 선서를 한다. 대통령은 조국의 평화적 통일을 위한 성실... '),
  Article(
      imgPath: 'assets/imgs/latest_1.png',
      title: '경험을 사고파는 것이 4차 산업혁명의 가능자',
      description: '대통령은 취임에 즈음하여 다음의 선서를 한다. 대통령은 조국의 평화적 통일을 위한 성실... '),
  Article(
      imgPath: 'assets/imgs/latest_1.png',
      title: '경험을 사고파는 것이 4차 산업혁명의 가능자',
      description: '대통령은 취임에 즈음하여 다음의 선서를 한다. 대통령은 조국의 평화적 통일을 위한 성실... '),
  Article(
      imgPath: 'assets/imgs/latest_2.png',
      title: '마크 트웨인의 풍자 "어떤 정치인은 개 아니다"',
      description: '대통령은 취임에 즈음하여 다음의 선서를 한다. 대통령은 조국의 평화적 통일을 위한 성실... '),
  Article(
      imgPath: 'assets/imgs/latest_1.png',
      title: '경험을 사고파는 것이 4차 산업혁명의 가능자',
      description: '대통령은 취임에 즈음하여 다음의 선서를 한다. 대통령은 조국의 평화적 통일을 위한 성실... '),
];

class ViewMore extends StatelessWidget {
  const ViewMore({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(height: 0.5, color: context.line2, indent: context.spacing20, endIndent: context.spacing20),
        Padding(
          padding: EdgeInsets.all(context.spacing20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('더 많은 아티클', style: context.koButton),
              SvgPicture.asset('assets/icons/arrow_right.svg'),
            ],
          ),
        ),
      ],
    );
  }
}


