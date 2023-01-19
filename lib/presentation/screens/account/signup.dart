import 'package:chat_app/controller/cubit/chat_cubit.dart';
import 'package:chat_app/presentation/screens/body/home.dart';
import 'package:chat_app/presentation/widgets/authen_icon_Button.dart';
import 'package:chat_app/presentation/widgets/custom_elevated_button.dart';
import 'package:chat_app/presentation/widgets/custom_text_field.dart';
import 'package:chat_app/presentation/widgets/text_inkwell.dart';
import 'package:chat_app/utilities/app_assets.dart';
import 'package:chat_app/utilities/app_strings.dart';
import 'package:chat_app/utilities/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import '../../../controller/cubit/chat_states.dart';
import '../../style/app_colors.dart';


class SignUpPge extends StatefulWidget {
  SignUpPge({Key? key}) : super(key: key);

  @override
  State<SignUpPge> createState() => _SignUpPgeState();
}

class _SignUpPgeState extends State<SignUpPge> {
  TextEditingController emailController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool? password;

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ChatCubit cubit = ChatCubit.get(context);
    return BlocConsumer<ChatCubit, ChatStates>(
      listener: (context, state) {
        if(state is FailedToStoreImage){
          CustomSnackBar.error(message: "failed");
        }
        if(state is SuccessfullyStoredImage){
          CustomSnackBar.success(message: "welcome");
        }
        if(state is RegisterSuccessEmail){
          CustomSnackBar.success(message: "welcome");
        }

      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.kPrimaryColor,
          body: SizedBox(
            height: 100.h,
            width: 100.w,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 75.h,
                    width: 90.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25.w),
                        topRight: Radius.circular(25.w),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Text(
                            AppStrings.registerTitle,
                            style: TextStyle(
                              color: AppColors.kPrimaryColor,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          CustomTextField(
                            label: AppStrings.nameLabel,
                            controller: nameController,
                            hintText: AppStrings.nameHint,
                            suffixIcon: Icons.person_outline_outlined,
                            validator: (value) {
                              if (value!.length == 0 || value.length < 3) {
                                return AppStrings.emailEmpty;
                              } else {
                                return null;
                              }
                            },
                          ),
                          CustomTextField(
                            label: AppStrings.mailLabel,
                            controller: emailController,
                            hintText: AppStrings.mailHint,
                            suffixIcon: Icons.mail,
                            validator: (value) {
                              if (value!.length == 0) {
                                return AppStrings.emailEmpty;
                              }
                              if (!RegExp(
                                      "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9+_.-]+.[a-z]")
                                  .hasMatch(value)) {
                                return AppStrings.validEmail;
                              } else {
                                return null;
                              }
                            },
                          ),
                          CustomTextField(
                            label: AppStrings.passLabel,
                            controller: passwordController,
                            hintText: AppStrings.registerPassHint,
                            obscureText: true,
                          ),
                          CustomElevatedButton(
                            onPressed: () async {
                               if (formKey.currentState!.validate()) {
                              await cubit.registerByEmailAndPassword(
                                emailController.text,
                                passwordController.text,
                                nameController.text,
                              );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(AppStrings.success),
                                    duration: Duration(seconds: 5),
                                  ),
                                );
                                Navigator.pushReplacementNamed(context, AppRoutes.homePageRoute);
                               }
                            },
                            label: AppStrings.registerTitle,
                            labelFontSize: 18,
                            labelFontWeight: FontWeight.bold,
                            borderRadius: 6.w,
                            width: 50.w,
                            height: 6.h,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AuthenIcon(
                                onPressed: () async {
                                  await cubit.signInByGoogle();
                                  //cubit.getUsers();
                                  Navigator.pushNamed(context, AppRoutes.homePageRoute);
                                },
                                imagePath: AppAssets.googleLogo,
                                width: 10.w,
                                height: 10.w,
                                fit: BoxFit.cover,
                                shape: BoxShape.circle,
                              ),
                              AuthenIcon(
                                onPressed: () async {
                                  await cubit.signInWithFacebook();
                                  Navigator.pushNamed(context, AppRoutes.homePageRoute);
                                  },
                                imagePath: AppAssets.facebookLogo,
                                width: 10.w,
                                height: 10.w,
                                shape: BoxShape.circle,
                              ),
                            ],
                          ),
                          CustomElevatedButton(
                            onPressed: () async{
                              await cubit.images(camera: 'cam');
                            },
                            label: AppStrings.registerChooseButton,
                            labelFontSize: 16,
                            labelFontWeight: FontWeight.bold,
                            borderRadius: 6.w,
                            width: 40.w,
                            height: 6.h,
                            backgroundColor: AppColors.kSecondaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3.w,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: TextInkwell(
                      labelText: AppStrings.registerInqueryMsg,
                      labelColor: Colors.white,
                      labelFontSize: 18,
                      onTap: () {
                        Navigator.pushReplacementNamed(context, AppRoutes.loginPageRoute);
                      },
                      directoryText: AppStrings.loginTitle,
                      directoryColor: Colors.white,
                      directoryFontSize: 18,
                      directoryFontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
