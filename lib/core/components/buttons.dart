import 'package:flutter/material.dart';

enum AppButtonStyle { filled, outlined }

class Button extends StatelessWidget {
  const Button.filled({
    super.key,
    required this.onPressed,
    required this.label,
    this.width = double.infinity,
    this.height = 42,
    this.borderRadius = 8,
    this.icon,
    this.iconRight,
    this.disabled = false,
    this.fontSize = 12,
    this.backgroundColor,
    this.foregroundColor,
  }) : style = AppButtonStyle.filled;

  const Button.outlined({
    super.key,
    required this.onPressed,
    required this.label,
    this.width = double.infinity,
    this.height = 42,
    this.borderRadius = 8,
    this.icon,
    this.iconRight,
    this.disabled = false,
    this.fontSize = 12,
    this.backgroundColor,
    this.foregroundColor,
  }) : style = AppButtonStyle.outlined;

  final VoidCallback onPressed;
  final String label;
  final AppButtonStyle style;

  final double width;
  final double height;
  final double borderRadius;
  final Widget? icon;
  final Widget? iconRight;
  final bool disabled;
  final double fontSize;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final Color finalBackgroundColor = this.backgroundColor ?? (style == AppButtonStyle.filled
        ? scheme.primary
        : Colors.transparent);

    final Color finalForegroundColor = this.foregroundColor ?? (style == AppButtonStyle.filled
        ? scheme.onPrimary
        : scheme.primary);

    final Color borderColor = disabled
        ? (this.foregroundColor ?? scheme.primary).withAlpha(77)
        : (this.foregroundColor ?? scheme.primary);

    final textStyle = textTheme.labelLarge!.copyWith(
      color: finalForegroundColor,
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
    );

    final child = Row(
      mainAxisAlignment: iconRight != null
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.center,
      children: [
        if (icon != null)
          IconTheme(
            data: IconThemeData(color: finalForegroundColor, size: fontSize + 6),
            child: icon!,
          ),
        if (icon != null) const SizedBox(width: 8),
        Text(label, style: textStyle),
        if (iconRight != null) const SizedBox(width: 8),
        if (iconRight != null)
          IconTheme(
            data: IconThemeData(color: finalForegroundColor, size: fontSize + 6),
            child: iconRight!,
          ),
      ],
    );

    return SizedBox(
      width: width,
      height: height,
      child: style == AppButtonStyle.filled
          ? ElevatedButton(
              onPressed: disabled ? null : onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: finalBackgroundColor,
                foregroundColor: finalForegroundColor,
                disabledBackgroundColor: scheme.primary.withAlpha(77),
                disabledForegroundColor: scheme.onPrimary.withAlpha(153),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
              child: child,
            )
          : OutlinedButton(
              onPressed: disabled ? null : onPressed,
              style: OutlinedButton.styleFrom(
                foregroundColor: finalForegroundColor,
                disabledForegroundColor: scheme.primary.withAlpha(153),
                side: BorderSide(color: borderColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
              child: child,
            ),
    );
  }
}
