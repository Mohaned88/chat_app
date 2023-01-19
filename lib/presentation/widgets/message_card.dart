import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../style/app_colors.dart';

class MessageCard extends StatelessWidget {
  final String photo;
  final String message;
  final bool isIncoming;

  const MessageCard({
    Key? key,
    required this.photo,
    required this.message,
    required this.isIncoming,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isIncoming
        ? Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 14.w),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    photo,
                  ),
                  radius: 4.w,
                ),
              ),
              SizedBox(
                width: 1.w,
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.third,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(3.w),
                    bottomLeft: Radius.circular(3.w),
                    topRight: Radius.circular(3.w),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(3.w),
                  child: Center(
                    child: Text(
                      message,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: Container()),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.third,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(3.w),
                    bottomLeft: Radius.circular(3.w),
                    topLeft: Radius.circular(3.w),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(3.w),
                  child: Center(
                    child: Text(
                      message,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 1.w,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 14.w),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    photo,
                  ),
                  radius: 4.w,
                ),
              ),
            ],
          );
  }
}
