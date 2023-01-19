import 'package:chat_app/controller/cubit/chat_states.dart';
import 'package:chat_app/presentation/widgets/custom_elevated_button.dart';
import 'package:chat_app/presentation/widgets/custom_text_field.dart';
import 'package:chat_app/presentation/widgets/text_inkwell.dart';
import 'package:chat_app/utilities/app_strings.dart';
import 'package:chat_app/utilities/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_facebook_keyhash/flutter_facebook_keyhash.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/cubit/chat_cubit.dart';
import '../../../utilities/helper.dart';
import '../../style/app_colors.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ChatCubit cubit = ChatCubit.get(context);
    return BlocConsumer<ChatCubit, ChatStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: 60.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25.h),
                      bottomLeft: Radius.circular(25.h),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: const Offset(3, 3),
                      )
                    ],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 4.h,
                        left: 6.w,
                        child: Text(
                          AppStrings.loginTitle,
                          style: TextStyle(
                            color: AppColors.kSecondaryColor,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 45.h,
                          width: 80.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade400,
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: const Offset(3, 3),
                              )
                            ],
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(18.h),
                              bottomLeft: Radius.circular(18.h),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6.h, vertical: 4.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomTextField(
                                  controller: emailController,
                                  label: AppStrings.mailLabel,
                                  hintText: AppStrings.mailHint,
                                  validator: (value) {
                                    return emailValidation(value);
                                  },
                                ),
                                CustomTextField(
                                  controller: passwordController,
                                  label: AppStrings.passLabel,
                                  hintText: AppStrings.loginPassHint,
                                  obscureText: true,
                                  validator: (value) {
                                    return passwordValidation(value);
                                  },
                                ),
                                CustomElevatedButton(
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      await cubit.login(
                                        emailController.text,
                                        passwordController.text,
                                      );
                                    }
                                    Navigator.pushReplacementNamed(context, AppRoutes.homePageRoute);
                                  },
                                  label: AppStrings.loginTitle,
                                  backgroundColor: Colors.blueAccent,
                                  width: 30.w,
                                  height: 6.h,
                                  borderRadius: 3.w,
                                  labelFontSize: 18,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: TextInkwell(
                    labelText: AppStrings.loginInqueryMsg,
                    labelFontSize: 18,
                    labelFontWeight: FontWeight.w600,
                    labelColor: Colors.blueGrey,
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed(AppRoutes.signupPageRoute);
                    },
                    directoryText: AppStrings.registerTitle,
                    directoryFontSize: 18,
                    directoryFontWeight: FontWeight.bold,
                    directoryColor: AppColors.kPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
