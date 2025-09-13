import 'package:flutter/material.dart';
import 'package:ios_news/themes/app_theme.dart';
import 'package:flutter_svg/svg.dart';
import '../data/nev_items.dart';

class NewsNav extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int>? onTab;

  const NewsNav({super.key, this.selectedIndex = 0, this.onTab});

  @override
  State<NewsNav> createState() => _NewsNavState();
}

class _NewsNavState extends State<NewsNav> {
  late int _currentIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentIndex = widget.selectedIndex;
  }

  void _onTap(int index) {
    setState(() => _currentIndex = index);
    widget.onTab?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84,
      decoration: BoxDecoration(color: context.bg3),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.spacing20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: context.spacing20,
          children: List.generate(navItems.length, (index) {
            final item = navItems[index];
            return NavIconButton(
                path: item['icon']!,
                label: item['label']!,
                isSelected: _currentIndex == index,
                onTap: () => _onTap(index));
          }),
        ),
      ),
    );
  }
}

class NavIconButton extends StatefulWidget {
  final String path;
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  const NavIconButton(
      {super.key,
      required this.path,
      required this.label,
      required this.isSelected,
      this.onTap});

  @override
  State<NavIconButton> createState() => _NavIconButtonState();
}

class _NavIconButtonState extends State<NavIconButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final scale = _isPressed ? 0.9 : 1.0;
    final color = widget.isSelected ? context.accent : context.black;

    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
        widget.onTap?.call(); // 외부 콜백 호출
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      child: SizedBox(
        width: 68,
        height: 64,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Column(
            spacing: 2,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AnimatedScale(
                  scale: scale,
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.easeInOut,
                  child: SvgPicture.asset(
                    widget.path,
                    width: 24,
                    colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                  )),
              AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: context.koNav.copyWith(color: color),
                  child: Text(widget.label),
              ),
            ],
          ),
        ),
      ),
    );
  }
}