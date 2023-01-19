import 'app_strings.dart';

String? passwordValidation(String value) {
  if (value.length <= 3) {
    return AppStrings.shortPassword;
  }
  return null;
}

String? emailValidation(value) {
  if (value!.length == 0) {
    return AppStrings.emailEmpty;
  }
  else if (!RegExp(AppStrings.regExp).hasMatch(value)) {
    return AppStrings.validEmail;
  }
    return null;
}