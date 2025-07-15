import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomBottomNavigationBarItem extends StatelessWidget {
  const CustomBottomNavigationBarItem({
    super.key,
    required this.asset,
    required this.label,
    this.isActive = false,
    this.onTap,
  });
  final String asset;
  final String label;
  final bool isActive;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final Color? color = isActive ? Theme.of(context).primaryColor : null;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            asset,
            height: 22,
            width: 22,
            color: color,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(color: color),
          ),
          const SizedBox(height: 8),
          Container(
            height: 3,
            width: 50,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
