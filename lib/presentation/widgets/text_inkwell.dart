import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TextInkwell extends StatelessWidget {
  final String labelText;
  final Color? labelColor;
  final double? labelFontSize;
  final FontWeight? labelFontWeight;
  final VoidCallback onTap;
  final String directoryText;
  final Color? directoryColor;
  final double? directoryFontSize;
  final FontWeight? directoryFontWeight;

  const TextInkwell({
    Key? key,
    required this.labelText,
    this.labelColor,
    this.labelFontSize,
    this.labelFontWeight,
    required this.onTap,
    required this.directoryText,
    this.directoryColor,
    this.directoryFontSize,
    this.directoryFontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          labelText,
          style: TextStyle(
            color: labelColor ?? Colors.black,
            fontSize: labelFontSize ?? 15,
            fontWeight: labelFontWeight ?? FontWeight.normal,
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Text(
            directoryText,
            style: TextStyle(
              color: directoryColor ?? Colors.black,
              fontSize: directoryFontSize ?? 15,
              fontWeight: directoryFontWeight ?? FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}
