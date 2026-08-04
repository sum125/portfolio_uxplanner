import 'package:flutter/material.dart';
import 'nav_items.dart';

class PageHeader extends StatelessWidget {
  final String label;

  const PageHeader({
    super.key,
    this.label = 'KIM SUMIN — UX / SERVICE PLANNER', // 기본값 지정
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'IBM Plex Mono',
            fontSize: 12,
            color: Color(0xFFA6A29B),
          ),
        ),
        const NavItems(alignment: MainAxisAlignment.end),
      ],
    );
  }
}
