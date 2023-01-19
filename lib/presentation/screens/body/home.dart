import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:chat_app/controller/cubit/chat_cubit.dart';
import 'package:chat_app/controller/cubit/chat_states.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/presentation/screens/body/chat_screen.dart';
import 'package:chat_app/presentation/screens/body/chat_screen_stream.dart';
import 'package:chat_app/presentation/style/app_colors.dart';
import 'package:chat_app/presentation/widgets/custom_text_field.dart';
import 'package:chat_app/presentation/widgets/user_component.dart';
import 'package:chat_app/utilities/app_strings.dart';
import 'package:chat_app/utilities/routes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sizer/sizer.dart';

import '../../../models/msg_model.dart';

class HomePage extends StatefulWidget {
  final UserModel? user;

  const HomePage({
    Key? key,
    this.user,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activeIndex = 0;

  @override
  void initState() {
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings("ic_launcher");
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? androidNotification = notification!.android;
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(channel.id, channel.name,
              icon: "ic_launcher"),
        ),
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? androidNotification = notification!.android;
      if (notification != null && androidNotification != null) {
        showDialog(
          context: context,
          builder:(_) => AlertDialog(
            title: Text(notification.title!),
            content: Column(
              children: [
                Text(notification.body!),
              ],
            ),
          ),
        );
      }
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(channel.id, channel.name,
              icon: "ic_launcher"),
        ),
      );
    });
    super.initState();
    getToken();
  }
  String? Token;
  getToken()async{
    Token = await FirebaseMessaging.instance.getToken();
  }
  @override
  Widget build(BuildContext context) {
    ChatCubit cubit = ChatCubit.get(context);
    return BlocConsumer<ChatCubit, ChatStates>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    widget.user!.photo ?? AppStrings.defaultImage,
                    scale: 1,
                  ),
                  radius: 22,
                ),
                SizedBox(
                  width: 2.w,
                ),
                Text(
                  widget.user!.name ?? AppStrings.chats,
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
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.brightness_4_outlined,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ],
            backgroundColor: AppColors.kPrimaryColor,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  height: 12.w,
                  child: CustomTextField(
                    borderRadius: 50,
                    filled: true,
                    prefixIcon: Icons.search,
                    hintText: AppStrings.search,
                    fillColor: Colors.grey.shade300,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: cubit.users.length,
                  itemBuilder: (BuildContext context, int index) {
                    /*cubit.lastUserMessage['${cubit.users[index]}'] = MsgModel(
                        incoming: true,
                        dateTime: DateTime.now().toString(),
                        msgId: '${cubit.users[index].id}',
                        msgText: 'Hello Start Chatting',
                        receiverId: '${cubit.registerUser.id}',
                        senderId: '${cubit.users[index].id}');*/
                    return UserCardComponent(
                      onTap: () {
                        // cubit.allMessages = cubit.getMessage2(cubit.users[index]);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return ChatScreenStream(
                                  friend: cubit.users[index]);
                              //return ChatScreen(currentUser: cubit.registerUser, friend: cubit.users[index]);
                            },
                          ),
                        );
                      },
                      user: cubit.users[index],
                      msg: cubit.lastUserMessage['${cubit.users[index].id}'] ??
                          cubit.msgModel,
                    );
                  },
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: AppColors.kPrimaryColor,
            child: const Icon(
              Icons.person_pin,
              color: AppColors.kContentColorLightTheme,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: AnimatedBottomNavigationBar(
            inactiveColor: Colors.grey,
            activeColor: AppColors.kPrimaryColor,
            icons: const [
              Icons.call,
              Icons.person_pin,
              Icons.settings,
              Icons.camera,
            ],
            activeIndex: activeIndex,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.sharpEdge,
            leftCornerRadius: 0,
            rightCornerRadius: 0,
            onTap: (index) {
              if (index == 2) {
                Navigator.pushNamed(context, AppRoutes.settingsPageRoute);
              }
              setState(() {
                activeIndex = index;
              });
            },
          ),
        );
      },
    );
  }
}
