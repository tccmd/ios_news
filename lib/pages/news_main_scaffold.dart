import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ios_news/pages/news_discovery_page.dart';
import 'package:ios_news/pages/news_home_page.dart';
import 'package:ios_news/pages/news_notifications_page.dart';
import 'package:ios_news/pages/news_search_page.dart';
import 'package:ios_news/providers/app_nav_bar_animating.dart';
import 'package:ios_news/widgets/news_appbar.dart';
import 'package:ios_news/widgets/news_nav.dart';
import 'package:ios_news/widgets/news_tab_bar.dart';

class NewsMainScaffold extends ConsumerStatefulWidget {
  const NewsMainScaffold({super.key});

  @override
  ConsumerState<NewsMainScaffold> createState() => _NewsMainScaffoldState();
}

class _NewsMainScaffoldState extends ConsumerState<NewsMainScaffold>
    with TickerProviderStateMixin {
  // 스크롤 controller
  final ScrollController _scrollController = ScrollController();
  double offset = 0;

  // 앱바 탭 controller
  late TabController _tabController;

  // 각 섹션을 식별한 Key
  final _sectionKeyLatest = GlobalKey();
  final _sectionKeyTrending = GlobalKey();
  final _sectionKeyTopic = GlobalKey();

  // 섹션 위치 저장
  final Map<int, double> _sectionOffsetMap = {};

  // 동작 꼬임 방지
  bool _isTabClickScroll = false;

  // 네비바, 페이지 인덱스
  int _currentIndex = 1;

  // 각 페이지
  late List<Widget> _pages;

  // 각 페이지 탭바
  late List<Widget> _tabBars;

  // 앱바, 네비바 애니메이션
  late AnimationController _animationController;
  late Animation<Offset> _appBarOffset;
  late Animation<Offset> _navBarOffset;

  // 앱바, 네비바 애니메이션 트리거
  bool isAnimating = false;

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

    _pages = [
      NewsHomePage(),
      NewsDiscoveryPage(sectionKeyLatest: _sectionKeyLatest, sectionKeyTrending: _sectionKeyTrending, sectionKeyTopic: _sectionKeyTopic),
      NewsSearchPage(),
      NewsNotificationsPage(),
    ];

    _tabBars = [
      NewsDiscoveryTabBar(tabController: _tabController),
      NewsDiscoveryTabBar(tabController: _tabController),
      NewsDiscoveryTabBar(tabController: _tabController),
      NewsDiscoveryTabBar(tabController: _tabController),
    ];

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _appBarOffset = Tween<Offset>(begin: Offset.zero, end: Offset(0, -1))
        .animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
    _navBarOffset = Tween<Offset>(begin: Offset.zero, end: Offset(0, 1))
        .animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
  }

  void _onNavTap(int index) {
    setState(() => _currentIndex = index);
  }

  // 안전하게 스크롤 위치 계산
  void _calculateSectionOffsets() {
    _sectionOffsetMap[0] = _getOffset(_sectionKeyLatest) - 146;
    _sectionOffsetMap[1] = _getOffset(_sectionKeyTrending) + 106 - 20;
    _sectionOffsetMap[2] = _getOffset(_sectionKeyTopic) + 106 - 20;
    // setState(() {}); // 혹시 UI에서 필요할 때
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
    if (offset >= ((_sectionOffsetMap[2]! - 100) ?? double.infinity)) {
      newIndex = 2;
    } else if (offset >= (_sectionOffsetMap[1] ?? double.infinity)) {
      newIndex = 1;
    } else {
      newIndex = 0;
    }

    _tabController.index = newIndex;

    // if (_tabController.index != newIndex) {
    //   _tabController.animateTo(newIndex);
    // }
  }

  void _triggerAppBarNavAnimation() {
    _animationController.forward();
  }

  void _handleClose() async {
    // 다시 원래 자리로 애니메이션
    await _animationController.reverse();

    // // 애니메이션 끝난 후 페이지 닫기
    // if (mounted) Navigator.pop(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    _tabController.dispose();
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // Provider 변화 감지
    ref.listen<bool>(appNavBarAnimatingProvider, (previous, next) {
      if (next == true) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    },);

    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: offset > 0 ? 106 : 146),
            child: SingleChildScrollView(
              controller: _scrollController,
              child: _pages[_currentIndex],
            ),
          ),
          SlideTransition(
              position: _appBarOffset, child: NewsAppbar(offset: offset, tabBar: _tabBars[_currentIndex])),
          Align(
              alignment: Alignment.bottomCenter,
              child: SlideTransition(position: _navBarOffset, child: NewsNav(selectedIndex: _currentIndex, onTab: _onNavTap,),)),
        ]),
      // bottomNavigationBar:
    );
  }
}
