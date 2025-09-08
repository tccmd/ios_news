import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ios_news/config.dart';
import 'package:ios_news/models/article.dart';
import 'package:ios_news/themes/app_theme.dart';
import 'package:ios_news/widgets/news_appbar.dart';
import 'package:ios_news/widgets/news_nav.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage>
    with SingleTickerProviderStateMixin {
  final Article article = Article(
      imgPath: 'assets/imgs/latest_3.png',
      title: '경험을 사고파는 것이 4차 산업혁명의 가능자',
      description: '대통령은 취임에 즈음하여 다음의 선서를 한다. 대통령은 조국의 평화적 통일을 위한 성실... ');

  late AnimationController _controller;
  late Animation<Offset> _appBarOffset;
  late Animation<Offset> _navBarOffset;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _appBarOffset = Tween<Offset>(begin: Offset.zero, end: Offset(0, -1))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _navBarOffset = Tween<Offset>(begin: Offset.zero, end: Offset(0, 1))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // 페이지 시작할 때 자동 실행
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  void _handleClose() async {
    // 다시 원래 자리로 애니메이션
    await _controller.reverse();

    // 애니메이션 끝난 후 페이지 닫기
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
                height: 240,
                child: Image.asset(article.imgPath ?? '',
                    width: double.infinity, fit: BoxFit.cover)),
            NewsArticleSheet(article: article),
            CloseButton(onPressed: _handleClose),
            SlideTransition(
                position: _appBarOffset, child: NewsAppbar(offset: 1)),
            Align(
                alignment: Alignment.bottomCenter,
                child: SlideTransition(position: _navBarOffset, child: NewsNav())),
          ],
        ),
      ),
    );
  }
}

class NewsArticleSheet extends StatelessWidget {
  final Article article;

  const NewsArticleSheet({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // border: Border.all(),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: context.bg1,
        boxShadow: [
          BoxShadow(
            color: context.black10,
            offset: const Offset(0, 0),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      height: 592,
      padding: EdgeInsets.fromLTRB(
          context.spacing20, context.spacing30, context.spacing20, 0),
      margin: EdgeInsets.only(top: 220),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: context.spacing10,
          children: [
            Text(article.category ?? '오늘의 오피니언', style: context.koOverLine),
            Text(article.title ?? '', style: context.koHeadline2),
            const Text(loremIpsumKo)
          ],
        ),
      ),
    );
  }
}

class CloseButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const CloseButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 48,
      right: 14,
      child: Material(
        color: Colors.transparent, // InkWell을 위해 필요
        child: InkWell(
          borderRadius: BorderRadius.circular(34 / 2),
          onTap: onPressed ?? () {
            Navigator.pop(context);
          },
          child: Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.black10,
            ),
            child: Center(child: SvgPicture.asset('assets/icons/close.svg')),
          ),
        ),
      ),
    );
  }
}
