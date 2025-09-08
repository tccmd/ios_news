import 'package:flutter/material.dart';
import 'package:ios_news/themes/app_theme.dart';
import 'package:ios_news/widgets/news_appbar.dart';
import 'package:ios_news/widgets/news_latest_article.dart';
import 'package:ios_news/widgets/news_nav.dart';
import 'package:ios_news/widgets/news_topic.dart';
import 'package:ios_news/widgets/news_trending.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: context.accent,
        scaffoldBackgroundColor: context.gray0,
        appBarTheme: AppBarTheme(
          backgroundColor: context.gray2,
          surfaceTintColor: context.gray2,
        ),
        tabBarTheme: TabBarTheme(
          labelStyle: context.koTab,
          unselectedLabelStyle: context.koTab,
          indicatorColor: context.accent,
          labelColor: context.accent,
          // indicator: BoxDecoration(border: Border.all()),
          overlayColor: WidgetStatePropertyAll(Colors.transparent),
          // tabAlignment: TabAlignment.start,
        ),
      ),
      home: const NewsHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class NewsHomePage extends StatefulWidget {
  const NewsHomePage({super.key, required this.title});

  final String title;

  @override
  State<NewsHomePage> createState() => _NewsHomePageState();
}

class _NewsHomePageState extends State<NewsHomePage>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late TabController _tabController;
  double offset = 0;

  // 각 섹션을 식별한 Key
  final _sectionKeyLatest = GlobalKey();
  final _sectionKeyTrending = GlobalKey();
  final _sectionKeyTopic = GlobalKey();

  // 섹션 위치 저장
  final Map<int, double> _sectionOffsetMap = {};

  // 동작 꼬임 방지
  bool _isTabClickScroll = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        offset = _scrollController.offset; // 스크롤 위치 저장
      });
    });
    _tabController = TabController(length: 4, vsync: this);

    // 탭 클릭 시 스크롤 이동
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return; // 사용자가 드래그 중이면 무시
      _scrollToSection(_tabController.index);
    });

    // 스크롤 시 탭 인덱스 업데이트
    _scrollController.addListener(_onScroll);

    // 위젯이 렌더링 된 후 섹션 위치 계산
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateSectionOffsets();
    });
  }

  // 안전하게 스크롤 위치 계산
  void _calculateSectionOffsets() {
    final appBarHeight = _getAppBarHeight();

    _sectionOffsetMap[0] = _getOffset(_sectionKeyLatest) - 146;
    _sectionOffsetMap[1] = _getOffset(_sectionKeyTrending) + 106 - 20;
    _sectionOffsetMap[2] = _getOffset(_sectionKeyTopic) + 106 - 20;
    // setState(() {}); // 혹시 UI에서 필요할 때
  }

  double _getAppBarHeight() {
    // 현재 스크롤 상태에 따른 height 계산
    if (offset > 0) {
      return 106;
    } else {
      return 106 + 40;
    }
  }

  double _getOffset(GlobalKey sectionKey) {
    final context = sectionKey.currentContext;
    if (context != null) {
      final box = context.findRenderObject() as RenderBox;
      return box.localToGlobal(Offset.zero).dy + _scrollController.offset;
    }
    return 0.0;
  }

  void _scrollToSection(int index) {
    final scroll = _sectionOffsetMap[index];
    if (scroll != null) {
      _isTabClickScroll = true;
      _scrollController
          .animateTo(scroll,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut)
          .then((_) => _isTabClickScroll = false);
    }
  }

  void _onScroll() {
    // final offset = _scrollController.offset;
    if (_isTabClickScroll) return; // 탭 클릭 스크롤 중에는 무시
    int newIndex = 0;

    // if (offset >= (_sectionOffsetMap[3] ?? double.infinity)) {
    //   newIndex = 3;
    // } else
    if (offset >= (_sectionOffsetMap[2] ?? double.infinity)) {
      newIndex = 2;
    } else if (offset >= (_sectionOffsetMap[1] ?? double.infinity)) {
      newIndex = 1;
    } else {
      newIndex = 0;
    }

    // if (_tabController.index != newIndex) {
    //   _tabController.animateTo(newIndex);
    // }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              NewsAppbar(offset: offset, tabController: _tabController),
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      NewsLatestArticle(sectionKey: _sectionKeyLatest),
                      NewsTrending(sectionKey: _sectionKeyTrending),
                      NewsTopic(sectionKey: _sectionKeyTopic),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: NewsNav(),
      ),
    );
  }
}
