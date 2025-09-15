import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ios_news/config.dart';
import 'package:ios_news/models/article.dart';
import 'package:ios_news/themes/app_theme.dart';

import '../providers/app_nav_bar_animating.dart';

class ArticlePage extends ConsumerStatefulWidget {
  final Article article;
  const ArticlePage({super.key, required this.article});

  @override
  ConsumerState<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends ConsumerState<ArticlePage>
    with SingleTickerProviderStateMixin {

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
                child: Image.asset(widget.article.imgPath ?? '',
                    width: double.infinity, fit: BoxFit.cover)),
            NewsArticleSheet(article: widget.article),
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

  double _sheetHeight = 592;

  // 시트, 타이틀, 텍스트 순차 애니메이션
  late AnimationController _sheetController;
  late Animation<double> _sheetOffset;
  late Animation<double> _sheetOpacity;

  late AnimationController _titlesController;
  late Animation<double> _titlesOffset;
  late Animation<double> _titlesOpacity;

  late AnimationController _textController;
  late Animation<double> _textOffset;
  late Animation<double> _textOpacity;

  double _dragOffset = 0; // 드래그 상태를저장

  bool _isFullScreen = false; // 풀스크린 상태 저장

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 1️⃣ Sheet 애니메이션
    _sheetController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _sheetOffset = Tween<double>(begin: 250, end: 220).animate(
        CurvedAnimation(parent: _sheetController, curve: Curves.easeInOut));
    _sheetOpacity = Tween<double>(begin: 1, end: 1).animate(
        CurvedAnimation(parent: _sheetController, curve: Curves.easeInOut));

    // 2️⃣ Titles 애니메이션
    _titlesController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _titlesOffset = Tween<double>(begin: 50, end: 0).animate(
        CurvedAnimation(parent: _titlesController, curve: Curves.easeInOut));
    _titlesOpacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _titlesController, curve: Curves.easeInOut));

    // 3️⃣ Text 애니메이션
    _textController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _textOffset = Tween<double>(begin: 50, end: 0).animate(
        CurvedAnimation(parent: _textController, curve: Curves.easeInOut));
    _textOpacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _textController, curve: Curves.easeInOut));

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
        // double totalOffset = _sheetOffset.value + _dragOffset; // 애니메이션 + 드래그 합산

        return Opacity(
          opacity: _sheetOpacity.value,
          child: Transform.translate(offset: Offset(0, _sheetOffset.value),
          child:  GestureDetector(
            onVerticalDragUpdate: (details) {
              setState(() {
                // _dragOffset += details.delta.dy;
                // 아래로는 못 내리게 제한
                if (_dragOffset > 0) _dragOffset = 0;
              });
            },
            onVerticalDragEnd: (details) {
              // if (_dragOffset < 0) _animateToFullScreen();
              _animateToFullScreen();
            },
            onTap: _animateToFullScreen,
            child: Container(
              decoration: BoxDecoration(
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
              height: _sheetHeight,
              padding: EdgeInsets.fromLTRB(
                  context.spacing20, context.spacing30, context.spacing20, 0),
              // margin: EdgeInsets.only(top: 220),
              child: SingleChildScrollView(
                child: Column(
                  spacing: context.spacing20,
                  children: [
                    // ...List.generate(40, (index) => Text('text$index'),),
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
          ),
        );
      },
    );
  }

  void _animateToFullScreen() {
    final screenHeight = MediaQuery.of(context).size.height;

    // 현재 상태에 따라 목표 offset과 height 결정
    final double targetOffset = _isFullScreen ? 220.0 : 0.0;   // 원래 위치 220, 풀스크린 0
    final double targetHeight = _isFullScreen ? 592.0 : screenHeight; // 원래 높이 592, 풀스크린 화면 높이

    final startOffset = _sheetOffset.value;
    final startHeight = _sheetHeight;

    final controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    final offsetAnim = Tween<double>(begin: startOffset, end: targetOffset)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
    final heightAnim = Tween<double>(begin: startHeight, end: targetHeight)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));

    controller.addListener(() {
      setState(() {
        _sheetOffset = AlwaysStoppedAnimation(offsetAnim.value);
        _sheetHeight = heightAnim.value;
      });
    });

    controller.forward().whenComplete(() {
      controller.dispose();
      _isFullScreen = !_isFullScreen; // 상태 토글
    });
  }

}


class ArticleSheetTitles extends StatelessWidget {
  final Article article;
  const ArticleSheetTitles({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Column(
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
