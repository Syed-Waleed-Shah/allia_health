import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.padding,
    this.onTap,
  });
  final String text;
  final Widget? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final EdgeInsets? padding;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        alignment: Alignment.center,
        padding: padding ?? EdgeInsets.symmetric(vertical: 12, horizontal: 50),
        decoration: BoxDecoration(
          color: backgroundColor ?? Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(30),
          border:
              Border.all(color: borderColor ?? Theme.of(context).primaryColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              icon!,
              const SizedBox(width: 6),
            ],
            Text(
              text,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: textColor ?? Colors.white,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
