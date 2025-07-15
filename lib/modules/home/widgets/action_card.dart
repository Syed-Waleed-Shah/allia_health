import 'package:allia_health/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActionCard extends StatelessWidget {
  const ActionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.actionLabel,
    this.iconPath,
    this.actionLabelColor,
  });
  final String title;
  final String subtitle;
  final String actionLabel;
  final String? iconPath;
  final Color? actionLabelColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: Theme.of(context).colorScheme.outline.withAlpha(100)),
      ),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (iconPath != null) ...[
            SvgPicture.asset(iconPath!),
            const SizedBox(width: 6),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          CustomButton(
            text: actionLabel,
            textColor: actionLabelColor ?? Colors.black,
            backgroundColor: Colors.transparent,
            borderColor: Theme.of(context).primaryColor,
            padding: EdgeInsets.symmetric(
              vertical: 6,
              horizontal: 20,
            ),
          ),
        ],
      ),
    ).animate().slide();
  }
}
