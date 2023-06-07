import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:truster_app/controller/login_controller.dart';

import '../../const/color_constants.dart';
import '../../const/theme_const.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final LoginController controller = LoginController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: const Text(
          'Signup',
          style: appBarTextStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: Obx(
          () => Form(
            key: controller.signUpFormKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'UserName*',
                    style: textLabelTextStyle,
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'abc@gmail.com', border: OutlineInputBorder()),
                    controller: controller.usernameText,
                    validator: (value) {
                      if (value == '') {
                        return 'Please enter username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Email Address*',
                    style: textLabelTextStyle,
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'abc@gmail.com', border: OutlineInputBorder()),
                    controller: controller.emailText,
                    validator: (value) {
                      if (value == '') {
                        return 'Please enter email address';
                      } else if (!value!.isEmail) {
                        return 'Please enter valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Phone Number*',
                    style: textLabelTextStyle,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      SizedBox(
                        width: Get.width * 0.2,
                        child: controller.selectedCountryCode.value == ''
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Color(0xFFD2D2D2),
                                  strokeWidth: 2,
                                ))
                            : DropdownButtonFormField<String>(
                                value: controller.selectedCountryCode.value,
                                items: controller.countryLists
                                    .map((element) => DropdownMenuItem<String>(
                                          value: element,
                                          child: Text(element),
                                        ))
                                    .toList(),
                                onChanged: (value) {},
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  isDense: true,
                                  errorStyle: TextStyle(height: 0),
                                ),
                                validator: (value) {
                                  if (controller.phoneNumberText.text == '') {
                                    return '';
                                  }
                                  return null;
                                },
                              ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText:
                                '${controller.selectedCountryCode.value == 'US' ? '(+1)' : controller.selectedCountryCode.value == 'UK' ? '(+44)' : '(+91)'} 4155552617',
                            border: const OutlineInputBorder(),
                            errorStyle: const TextStyle(height: 0),
                          ),
                          controller: controller.phoneNumberText,
                          validator: (value) {
                            if (value == '') {
                              controller.validateMobile();
                              return '';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  if (controller.showMobileError.value)
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, top: 8),
                      child: Text(
                        'Please enter mobile number',
                        style: textLabelTextStyle.copyWith(color: Colors.red[800], fontSize: 12),
                      ),
                    ),
                  const SizedBox(height: 20),
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
                              controller.showPassword.toggle();
                            },
                            icon:
                                Icon(controller.showPassword.value ? Icons.visibility_outlined : Icons.visibility_off_outlined))),
                    obscureText: !controller.showPassword.value,
                    controller: controller.passwordText,
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
                              controller.showSignupConfirmPassword.toggle();
                            },
                            icon: Icon(controller.showSignupConfirmPassword.value
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined))),
                    obscureText: !controller.showSignupConfirmPassword.value,
                    controller: controller.confirmPasswordText,
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
                      controller.signup();
                    },
                    style: buttonStylePrimary,
                    child: controller.creatingAccount.value
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Color(0xFFD2D2D2),
                                    strokeWidth: 2,
                                  )),
                              SizedBox(
                                width: 15,
                              ),
                              Text('Creating Account')
                            ],
                          )
                        : const Text('Continue'),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Text(
                        'Already a User? ',
                        style: TextStyle(fontSize: 16),
                      ),
                      InkWell(
                        onTap: () {
                          controller.goToLoginScreen(false);
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(color: primary, fontSize: 16),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
