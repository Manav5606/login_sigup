import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:truster_app/const/color_constants.dart';
import 'package:truster_app/const/theme_const.dart';
import 'package:truster_app/controller/login_controller.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key}) : super(key: key);
  final controller = LoginController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              height: Get.height,
              width: Get.width,
              child: Image.asset(
                'assets/images/on_boarding_screen_bg.png',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: Get.height,
              width: Get.width,
              decoration: BoxDecoration(color: primary.withOpacity(0.95)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'Make your transaction confidently',
                      style: headerTextStyle,
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Turpis tellus odio pulvinar morbi a justo, in. Vel ullamcorper amet proin sodales diam in sem laoreet.',
                      style: smallTextStyle,
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  controller.goToSignUpScreen(true);
                                },
                                style: buttonStyleSecondary,
                                child: const Text('Signup'))),
                        const SizedBox(width: 20),
                        Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  controller.goToLoginScreen(true);
                                },
                                style: buttonStyleOutlined,
                                child: const Text('Login'))),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
