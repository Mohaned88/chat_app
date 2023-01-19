import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final double? width;
  final double? height;
  final VoidCallback onPressed;
  final String label;
  final Color? backgroundColor;
  final double? borderRadius;
  final Color? labelColor;
  final double? labelFontSize;
  final FontWeight? labelFontWeight;

  const CustomElevatedButton({
    Key? key,
    this.width,
    this.height,
    required this.onPressed,
    required this.label,
    this.backgroundColor,
    this.borderRadius,
    this.labelColor,
    this.labelFontSize,
    this.labelFontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 2),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: labelColor ?? Colors.white,
            fontSize: labelFontSize ?? 15,
            fontWeight: labelFontWeight ?? FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
