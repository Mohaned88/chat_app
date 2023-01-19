import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/models/msg_model.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class UserCardComponent extends StatelessWidget {
  final UserModel user;
  final MsgModel msg;
  final GestureTapCallback? onTap;

  const UserCardComponent({
    Key? key,
    required this.user,
    required this.msg,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        height: 20.w,
        child: Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage("${user.photo}"),

            ),
            title: Text("${user.name}"),
            subtitle: Text("${msg.msgText} - ${msg.dateTime}"),
          ),
        ),
      ),
    );
  }
}
