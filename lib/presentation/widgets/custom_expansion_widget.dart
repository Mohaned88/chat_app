import 'package:expansion_widget/expansion_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'dart:math' as math;
import '../../utilities/app_strings.dart';
import '../style/app_colors.dart';

class CustomExpansionWidget extends StatefulWidget {
  String? title;
  Color? titleColor;
  String? subtitle;
  IconData? icon;
  Color? iconColor;
  Color? iconBoxColor;
  bool suffixSwitch ;
  ValueChanged<bool>? suffixOnPressed;

  CustomExpansionWidget({
    Key? key,
    this.title,
    this.titleColor,
    this.subtitle,
    this.icon,
    this.iconColor,
    this.iconBoxColor,
    this.suffixSwitch = false,
    this.suffixOnPressed,
  }) : super(key: key);

  @override
  State<CustomExpansionWidget> createState() => _CustomExpansionWidgetState();
}

class _CustomExpansionWidgetState extends State<CustomExpansionWidget> {
  bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.w),
      child: !widget.suffixSwitch
          ? ExpansionWidget(
              titleBuilder:
                  (double animationValue, _, bool isExpaned, toogleFunction) {
                return InkWell(
                  onTap: () => toogleFunction(animated: true),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 12.w,
                        width: 12.w,
                        decoration: BoxDecoration(
                          color: widget.iconBoxColor ?? Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          widget.icon ??
                              Icons.highlight_remove_outlined, //Icons.update,
                          color: widget.iconColor ?? Colors.white,
                          size: 35,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.title ?? "",
                              //AppStrings.settingsUpdateTitle,
                              style: TextStyle(
                                color: widget.titleColor ??
                                    AppColors.kContentColorLightTheme,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            if (widget.subtitle != null) ...[
                              Text(
                                widget.subtitle ?? "",
                                //AppStrings.settingsUpdateSubTitle,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                            ]
                          ],
                        ),
                      ),
                      Transform.rotate(
                        angle: math.pi * animationValue / 2,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.keyboard_arrow_right,
                          size: 40,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              },
              content: Container(
                width: double.infinity,
                color: Colors.grey.shade100,
                padding: const EdgeInsets.all(20),
                child: const Text('Expaned Content'),
              ),
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 12.w,
                  width: 12.w,
                  decoration: BoxDecoration(
                    color: widget.iconBoxColor ?? Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    widget.icon ??
                        Icons.highlight_remove_outlined, //Icons.update,
                    color: widget.iconColor ?? Colors.white,
                    size: 35,
                  ),
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.title ?? "",
                        //AppStrings.settingsUpdateTitle,
                        style: TextStyle(
                          color: widget.titleColor ??
                              AppColors.kContentColorLightTheme,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      if (widget.subtitle != null) ...[
                        Text(
                          widget.subtitle ?? "",
                          //AppStrings.settingsUpdateSubTitle,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
                Switch(
                  value: switchValue,
                  onChanged: (val) {
                    setState(
                      () {
                        switchValue = val;
                      },
                    );
                  },
                ),
              ],
            ),
    );
  }
}
