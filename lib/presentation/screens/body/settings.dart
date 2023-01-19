import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/presentation/style/app_colors.dart';
import 'package:chat_app/presentation/widgets/custom_expansion_widget.dart';
import 'package:chat_app/utilities/app_strings.dart';
import 'package:expansion_widget/expansion_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SettingsPage extends StatelessWidget {
  final UserModel? user;
  bool expand = false;

  SettingsPage({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          padding: EdgeInsets.only(top: 1.h),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30,
          ),
        ),
        toolbarHeight: 10.h,
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, 6.h),
          child: Padding(
            padding: EdgeInsets.only(left: 18.w, bottom: 2.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://www.pngfind.com/pngs/m/676-6764065_default-profile-picture-transparent-hd-png-download.png',
                    scale: 1,
                  ),
                  radius: 33,
                ),
                SizedBox(
                  width: 2.w,
                ),
                const Text(
                  'null',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: AppColors.kPrimaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(60),
            bottomRight: Radius.circular(60),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomExpansionWidget(
                title: AppStrings.settingsUpdateTitle,
                subtitle: AppStrings.settingsUpdateSubTitle,
                icon: Icons.update_outlined,
              ),
              CustomExpansionWidget(
                title: AppStrings.settingsDarkMTitle,
                subtitle: AppStrings.settingsDarkMSubTitle,
                icon: Icons.dark_mode,
                suffixSwitch: true,
                iconBoxColor: AppColors.kErrorColor,
              ),
              CustomExpansionWidget(
                title: AppStrings.settingsChangeLanguageTitle,
                icon: Icons.language,
                iconBoxColor: Colors.teal,
              ),
              CustomExpansionWidget(
                title: AppStrings.settingsAboutTitle,
                subtitle: AppStrings.settingsAboutSubTitle,
                icon: Icons.info,
                iconBoxColor: Colors.purple,
              ),
              const Text(
                AppStrings.settingsAccountTitle,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
              CustomExpansionWidget(
                title: AppStrings.settingsSignOutTitle,
                icon: Icons.exit_to_app,
                iconBoxColor: Colors.transparent,
                iconColor: Colors.grey,
              ),
              CustomExpansionWidget(
                title: AppStrings.settingsDeleteAccountTitle,
                icon: Icons.delete_rounded,
                iconBoxColor: Colors.transparent,
                iconColor: Colors.grey,
                titleColor: AppColors.kErrorColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
