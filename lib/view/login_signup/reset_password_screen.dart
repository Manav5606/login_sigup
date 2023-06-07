import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../const/theme_const.dart';
import '../../controller/login_controller.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({Key? key}) : super(key: key);
  final LoginController controller = LoginController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reset Password',
          style: appBarTextStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: Obx(
          () => Form(
            // key: controller.signUpFormKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Password*',
                    style: textLabelTextStyle,
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                            onPressed: () {
                              controller.showResetPassword.toggle();
                            },
                            icon: Icon(
                                controller.showResetPassword.value ? Icons.visibility_outlined : Icons.visibility_off_outlined))),
                    obscureText: !controller.showResetPassword.value,
                    controller: controller.resetPasswordText,
                    validator: (value) {
                      if (value == '') {
                        return 'Please enter password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Confirm Password*',
                    style: textLabelTextStyle,
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                            onPressed: () {
                              controller.showResetConfirmPassword.toggle();
                            },
                            icon: Icon(controller.showResetConfirmPassword.value
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined))),
                    obscureText: !controller.showResetConfirmPassword.value,
                    controller: controller.resetConfirmPasswordText,
                    validator: (value) {
                      if (value == '') {
                        return 'Please retype password';
                      } else if (value != '') {
                        return controller.validateConfirmPassword(value);
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // controller.signup();
                    },
                    style: buttonStylePrimary,
                    child: const Text('Set New Password'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
