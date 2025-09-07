import 'package:flutter/material.dart';
import 'package:ios_news/themes/app_theme.dart';
import 'package:flutter_svg/svg.dart';

class NewsNav extends StatelessWidget {
  const NewsNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84,
      decoration: BoxDecoration(
          color: context.bg3
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.spacing20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: context.spacing20,
          children: [
            NavIcon(label: '홈', path: 'assets/icons/home_off.svg',),
            NavIcon(label: '발견', path: 'assets/icons/compass_off.svg',),
            NavIcon(label: '검색', path: 'assets/icons/search_off.svg',),
            NavIcon(label: '알림', path: 'assets/icons/bell_off.svg',),
          ],
        ),
      ),
    );
  }
}

class NavIcon extends StatelessWidget {
  final String path;
  final String label;
  const NavIcon({super.key, required this.path, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(border: Border.all()),
      width: 68,
      height: 64,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Column(
          spacing: 2,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(path, width: 24),
            Text(label, style: context.koNav),
          ],
        ),
      ),
    );
  }
}
