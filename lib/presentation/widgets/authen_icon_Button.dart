import 'package:flutter/material.dart';

class AuthenIcon extends StatelessWidget {
  final double? width;
  final double? height;
  final BoxShape? shape;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final String? imagePath;
  final BoxFit? fit;
  final VoidCallback onPressed;

  const AuthenIcon({
    Key? key,
    this.width,
    this.height,
    this.shape,
    this.backgroundColor,
    this.padding,
    required this.imagePath,
    this.fit,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding ?? const EdgeInsets.all(0),
      decoration: BoxDecoration(
        shape: shape ?? BoxShape.rectangle,
        color: backgroundColor ?? Colors.white,
      ),
      child: IconButton(
        onPressed: onPressed,
        padding: const EdgeInsets.all(0),
        icon: Image.asset(
          imagePath ?? "",
          fit: fit,
        ),
      ),
    );
  }
}
