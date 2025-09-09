import 'package:ctc_calc/theme/appcolor.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderRadius,
    this.showShadow = true,
  });

  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? backgroundColor;
  final double? borderRadius;
  final bool showShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.cardBackground,
        borderRadius: BorderRadius.circular(borderRadius ?? 12),
        boxShadow: showShadow
            ? [
                BoxShadow(
                  color: Colors.grey.withAlpha(25),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                  spreadRadius: 4,
                ),
                BoxShadow(
                  color: Colors.grey.withAlpha(13),
                  blurRadius: 6,
                  offset: const Offset(0, 1),
                  spreadRadius: 2,
                ),
              ]
            : null,
      ),
      child: child,
    );
  }
}
