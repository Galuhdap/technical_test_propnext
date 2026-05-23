import 'package:flutter/material.dart';

class BoxWidget extends StatelessWidget {
  final double? width, height;
  final Color? color;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final EdgeInsetsGeometry? padding, margin;
  final Widget? child;
  const BoxWidget({
    super.key,
    this.width,
    this.height,
    this.color,
    this.borderRadius,
    this.border,
    this.padding,
    this.margin,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(0),
        child: Container(
          padding: padding,
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: borderRadius,
            border: border,
          ),
          child: child,
        ),
      ),
    );
  }
}
