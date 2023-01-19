import 'package:chat_app/controller/cubit/chat_cubit.dart';
import 'package:chat_app/controller/cubit/chat_states.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/presentation/style/app_colors.dart';
import 'package:chat_app/presentation/widgets/custom_text_field.dart';
import 'package:chat_app/presentation/widgets/message_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../utilities/app_strings.dart';

class ChatScreen extends StatefulWidget {
  final UserModel currentUser;
  final UserModel friend;

  const ChatScreen({
    Key? key,
    required this.currentUser,
    required this.friend,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var cubit = ChatCubit.get(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kPrimaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          padding: EdgeInsets.all(2.w),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        leadingWidth: 7.w,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                widget.friend.photo ?? AppStrings.defaultImage,
                scale: 1,
              ),
              radius: 22,
            ),
            SizedBox(
              width: 2.w,
            ),
            Text(
              widget.friend.name ?? AppStrings.unKnown,
              softWrap: true,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.call,
              color: Colors.white,
              size: 22,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.videocam_rounded,
              color: Colors.white,
              size: 22,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.info,
              color: Colors.white,
              size: 22,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        child: BlocConsumer<ChatCubit, ChatStates>(
          listener: (context, states) {},
          builder: (context, states) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    padding: EdgeInsets.symmetric(vertical: 3.w),
                    itemCount: cubit.allMessages.length,
                    itemBuilder: (BuildContext context, int index) {
                      if ((cubit.allMessages[index].msgId == widget.currentUser.id)
                          &&
                          (widget.friend.id == cubit.allMessages[index].receiverId)) {
                        return MessageCard(
                          photo: "${widget.currentUser.photo}",
                          message: "${cubit.allMessages[index].msgText}",
                          isIncoming: false,
                        );
                      } else if ((cubit.allMessages[index].msgId == widget.friend.id)
                          &&
                          (widget.currentUser.id == cubit.allMessages[index].receiverId)) {
                        return MessageCard(
                          photo: "${widget.friend.photo}",
                          message: "${cubit.msgModel.msgText}",
                          isIncoming: true,
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 10.h,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: messageController,
                          filled: true,
                          fillColor: AppColors.kPrimaryColor.withOpacity(0.9),
                          borderRadius: 5.h,
                          hintText: AppStrings.chatSearchAskMsg,
                          hintColor: Colors.white,
                          textAlign: TextAlign.start,
                          cursorColor: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      FloatingActionButton(
                        backgroundColor: AppColors.kPrimaryColor,
                        onPressed: () {
                          if (messageController.text.isNotEmpty) {
                            cubit.sentMessage(
                                messageController.text, widget.friend, 0);
                          }
                          messageController.clear();
                          scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(seconds: 1), curve: Curves.bounceIn);
                        },
                        child: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
