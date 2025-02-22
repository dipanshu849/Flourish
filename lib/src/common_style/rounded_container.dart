import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final double radius;
  final Widget? child;
  final bool showBorder;
  final Color borderColor;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const RoundedContainer({
    Key? key,
    this.width,
    this.height,
    this.radius = 10,
    this.child,
    this.showBorder = false,
    this.borderColor = Colors.transparent,
    this.backgroundColor = Colors.transparent,
    this.padding,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: showBorder ? Border.all(color: borderColor, width: 1) : null,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: child,
    );
  }
}
