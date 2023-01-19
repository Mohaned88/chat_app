import 'package:chat_app/controller/cubit/chat_cubit.dart';
import 'package:chat_app/controller/cubit/chat_states.dart';
import 'package:chat_app/models/msg_model.dart';
import 'package:chat_app/presentation/widgets/message_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../models/user_model.dart';
import '../../../utilities/app_strings.dart';
import '../../style/app_colors.dart';
import '../../widgets/custom_text_field.dart';

class ChatScreenStream extends StatefulWidget {
  final UserModel friend;

  ChatScreenStream({
    Key? key,
    required this.friend,
  }) : super(key: key);

  @override
  State<ChatScreenStream> createState() => _ChatScreenStreamState();
}

class _ChatScreenStreamState extends State<ChatScreenStream> {
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
      body: BlocConsumer<ChatCubit, ChatStates>(
        builder: (BuildContext context, state) {
          return StreamBuilder<QuerySnapshot>(
            stream: cubit.getMessagesStream(widget.friend).snapshots(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                List<MsgModel> messagesList = [];
                snapshot.data!.docs.forEach((element) {
                  messagesList.add(MsgModel.fromJson(element));
                });
                cubit.lastUserMessage['${widget.friend.id}']
                = messagesList.isNotEmpty
                    ? messagesList[messagesList.length-1]
                    : MsgModel(
                  incoming: true,
                  dateTime: DateTime.now().toString(),
                  msgId: '${widget.friend.id}',
                  msgText: 'Hello Start Chatting',
                  receiverId: '${cubit.registerUser.id}',
                  senderId: '${widget.friend.id}'
                );
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: messagesList.length,
                          itemBuilder: (context, index) {
                            if (messagesList[index].msgId == cubit.registerUser.id && widget.friend.id == messagesList[index].receiverId) {
                              return MessageCard(
                                photo: "${cubit.registerUser.photo}",
                                message: "${messagesList[index].msgText}",
                                isIncoming: false,
                              );
                            } else if (messagesList[index].msgId == widget.friend.id && cubit.registerUser.id == messagesList[index].receiverId){
                              return MessageCard(
                                photo: "${widget.friend.photo}",
                                message: "${messagesList[index].msgText}",
                                isIncoming: true,
                              );
                            }
                            return const SizedBox();
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
                                fillColor:
                                    AppColors.kPrimaryColor.withOpacity(0.9),
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
                                  cubit.sentMessage(messageController.text, widget.friend, 0);
                                  scrollController.animateTo(
                                    scrollController.position.maxScrollExtent,
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.bounceOut,
                                  );
                                }
                                messageController.clear();
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
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          );
        },
        listener: (BuildContext context, Object? state) {},
      ),
    );
  }
}
