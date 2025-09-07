import 'package:flutter/material.dart';
import 'package:ios_news/themes/app_theme.dart';

class StyleGuide extends StatelessWidget {
  const StyleGuide({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.spacing20),
      child: Column(
        spacing: context.spacing10,
        children: [
          Text('Style Guide', style: context.enHeadline1),
          SizedBox(height: context.spacing10),
          Row(
            spacing: 100,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Headline1', style: context.enHeadline1),
                  Text('Headline2', style: context.enHeadline2),
                  Text('Headline3', style: context.enHeadline3),
                  Text('Headline4', style: context.enHeadline4),
                  Text('Headline5', style: context.enHeadline5),
                  Text('Body1', style: context.enBody1),
                  Text('Body2', style: context.enBody2),
                  Text('Tab', style: context.enTab),
                  Text('Caption1', style: context.enCaption1),
                  Text('OverLine', style: context.enOverLine),
                  Text('Button', style: context.enButton),
                  Text('Caption2', style: context.enCaption2),
                  Text('Nav', style: context.enNav),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('헤드라인1', style: context.koHeadline1),
                  Text('헤드라인2', style: context.koHeadline2),
                  Text('헤드라인3', style: context.koHeadline3),
                  Text('헤드라인4', style: context.koHeadline4),
                  Text('헤드라인5', style: context.koHeadline5),
                  Text('바디1', style: context.koBody1),
                  Text('바디2', style: context.koBody2),
                  Text('탭', style: context.koTab),
                  Text('캡션1', style: context.koCaption1),
                  Text('오버라인', style: context.koOverLine),
                  Text('버튼', style: context.koButton),
                  Text('캡션2', style: context.koCaption2),
                  Text('네비게이션', style: context.koNav),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}