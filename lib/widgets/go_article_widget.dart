import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/article.dart';
import '../pages/article_page.dart';
import '../providers/app_nav_bar_animating.dart';

class GoArticleWidget extends ConsumerWidget {
  final Article article;
  final Widget child;
  const GoArticleWidget({
    super.key,
    required this.article,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 200),
          pageBuilder: (context, animation, secondaryAnimation) => ArticlePage(article: article),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ));
        ref.read(appNavBarAnimatingProvider.notifier).trigger();
      },
      child: child,
    );
  }
}
