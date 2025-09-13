import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ios_news/pages/article_page.dart';
import 'package:ios_news/pages/news_main_scaffold.dart';
import 'package:ios_news/themes/app_theme.dart';

void main() {
  runApp(
      const ProviderScope(
        child: MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'iOS News App',
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/article') {
          return PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => const ArticlePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child,);
          },
            transitionDuration: const Duration(milliseconds: 200),
          );
        }
        return null;
      },
      routes: {
        '/': (context) => const NewsMainScaffold(),
        '/article': (context) => const ArticlePage(),
      },
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
      // home: const NewsMainScaffold(),
    );
  }
}
