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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController _scrollController = ScrollController();
  double offset = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        offset = _scrollController.offset; // 스크롤 위치 저장
      });
    });
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
                NewsAppbar(offset: offset,),
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: [
                        NewsLatestArticle(),
                        NewsTrending(),
                        NewsTopic(),
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
