import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ios_news/config.dart';
import 'package:ios_news/models/article.dart';
import 'package:ios_news/themes/app_theme.dart';

import '../providers/app_nav_bar_animating.dart';

class ArticlePage extends ConsumerStatefulWidget {
  const ArticlePage({super.key});

  @override
  ConsumerState<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends ConsumerState<ArticlePage>
    with SingleTickerProviderStateMixin {
  final Article article = Article(
      imgPath: 'assets/imgs/latest_3.png',
      title: '경험을 사고파는 것이 4차 산업혁명의 가능자',
      description: '대통령은 취임에 즈음하여 다음의 선서를 한다. 대통령은 조국의 평화적 통일을 위한 성실... ');

  // 시트, 글자 애니메이션
  double _top = 370;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 페이지가 렌더링 된 후 애니메이션 시작
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _top = 220;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void _handleClose() async {
    // 앱바, 네비바 다시 원래 자리로 애니메이션
    ref.read(appNavBarAnimatingProvider.notifier).trigger();

    // 애니메이션 끝난 후 페이지 닫기
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            SizedBox(
                height: 240,
                child: Image.asset(article.imgPath ?? '',
                    width: double.infinity, fit: BoxFit.cover)),
            // AnimatedPositioned(
            //     duration: const Duration(milliseconds: 200),
            //     curve: Curves.easeInOut,
            //     left: 0,
            //     right: 0,
            //     top: _top,
            //     child: NewsArticleSheet(article: article)),
            NewsArticleSheet(article: article),
            CloseButton(onPressed: _handleClose),
          ],
        ),
      ),
    );
  }
}

class NewsArticleSheet extends StatefulWidget {
  final Article article;
  const NewsArticleSheet({super.key, required this.article});

  @override
  State<NewsArticleSheet> createState() => _NewsArticleSheetState();
}

class _NewsArticleSheetState extends State<NewsArticleSheet> with
 TickerProviderStateMixin {

  // 시트, 타이틀, 텍스트 순차 애니메이션
  late AnimationController _sheetController;
  late Animation<double> _sheetOffset;

  late AnimationController _titlesController;
  late Animation<double> _titlesOffset;
  late Animation<double> _titlesOpacity;

  late AnimationController _textController;
  late Animation<double> _textOffset;
  late Animation<double> _textOpacity;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 1️⃣ Sheet 애니메이션
    _sheetController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _sheetOffset = Tween<double>(begin: 370, end: 220).animate(
        CurvedAnimation(parent: _sheetController, curve: Curves.easeOut));

    // 2️⃣ Titles 애니메이션
    _titlesController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _titlesOffset = Tween<double>(begin: 50, end: 0).animate(
        CurvedAnimation(parent: _titlesController, curve: Curves.easeOut));
    _titlesOpacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _titlesController, curve: Curves.easeIn));

    // 3️⃣ Text 애니메이션
    _textController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _textOffset = Tween<double>(begin: 50, end: 0).animate(
        CurvedAnimation(parent: _textController, curve: Curves.easeOut));
    _textOpacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _textController, curve: Curves.easeIn));

    // 순차 실행
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _sheetController.forward();
      await _titlesController.forward();
      await _textController.forward();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _sheetController.dispose();
    _titlesController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _sheetController,
      builder: (context, child) {
        return Transform.translate(offset: Offset(0, _sheetOffset.value),
        child:  Container(
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
          // margin: EdgeInsets.only(top: 220),
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(border: Border.all()),
              child: Column(
                children: [
                  AnimatedBuilder(
                      animation: _titlesController,
                      builder: (context, child) {
                        return Opacity(opacity: _titlesOpacity.value,
                          child: Transform.translate(offset: Offset(0, _titlesOffset.value),
                          child: child,
                          )
                        );
                      },
                    child: ArticleSheetTitles(article: widget.article),
                  ),
                  AnimatedBuilder(
                    animation: _textController,
                    builder: (context, child) {
                      return Opacity(opacity: _textOpacity.value,
                        child: Transform.translate(offset: Offset(0, _textOffset.value),
                        child: child,
                        ),
                      );
                    },
                    child: Text(loremIpsumKo),
                  ),
                ],
              ),
            ),
          ),
        ),
        );
      },
    );
  }
}


class ArticleSheetTitles extends StatelessWidget {
  final Article article;
  const ArticleSheetTitles({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return             Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: context.spacing10,
      children: [
        Text(article.category ?? '오늘의 오피니언', style: context.koOverLine),
        Text(article.title ?? '', style: context.koHeadline2),
        Row(
          spacing: 8,
          children: [
            CircleAvatar(
              radius: 15,
              child: Image.asset('assets/imgs/profile.png'),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('기자명', style: context.koCaption1,),
                Text('2021. 05. 12', style: context.enCaption2,)
              ],)
          ],),
      ],
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
