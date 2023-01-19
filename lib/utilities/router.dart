import 'package:chat_app/controller/cubit/chat_cubit.dart';
import 'package:chat_app/controller/cubit/chat_states.dart';
import 'package:chat_app/presentation/screens/account/login.dart';
import 'package:chat_app/presentation/screens/account/signup.dart';
import 'package:chat_app/presentation/screens/body/chat_screen.dart';
import 'package:chat_app/presentation/screens/body/home.dart';
import 'package:chat_app/presentation/screens/body/settings.dart';
import 'package:chat_app/utilities/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Route<dynamic> onGenerate(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AppRoutes.loginPageRoute:
      return MaterialPageRoute(
        builder: (_) => LoginPage(),
        settings: routeSettings,
      );

    case AppRoutes.signupPageRoute:
      return MaterialPageRoute(
        builder: (_) => SignUpPge(),
        settings: routeSettings,
      );

    case AppRoutes.settingsPageRoute:
      return MaterialPageRoute(
        builder: (_) => SettingsPage(),
        settings: routeSettings,
      );

    case AppRoutes.homePageRoute:
      return MaterialPageRoute(
        builder: (_) => BlocConsumer<ChatCubit, ChatStates>(
          listener: (context, states) {},
          builder: (context, states) {
            return HomePage(
              user: ChatCubit.get(context).registerUser,
            );
          },
        ),
        settings: routeSettings,
      );

    case AppRoutes.chatScreenRoute:
      return MaterialPageRoute(
        builder: (_) => BlocConsumer<ChatCubit, ChatStates>(
          listener: (context, states) {},
          builder: (context, states) {
            return ChatScreen(
              currentUser: ChatCubit.get(context).registerUser,
              friend: ChatCubit.get(context).registerUser,
            );
          },
        ),
        settings: routeSettings,
      );

    default:
      return MaterialPageRoute(
        builder: (_) => LoginPage(),
        settings: routeSettings,
      );
  }
}
