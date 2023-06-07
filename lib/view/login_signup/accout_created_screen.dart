import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:truster_app/const/color_constants.dart';
import 'package:truster_app/const/theme_const.dart';
import 'package:truster_app/view/home/home_screen.dart';
import 'package:truster_app/view/login_signup/login_screen.dart';

class AccountCreatedScreen extends StatelessWidget {
  const AccountCreatedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: Get.height * 0.15),
          Image.asset(
            'assets/images/success.png',
            width: Get.width * 0.5,
            height: Get.width * 0.5,
          ),
          Text(
            'Your Truster account has been created successfully',
            style: headerTextStyle.copyWith(color: primary, fontWeight: FontWeight.bold, fontSize: 24),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
              onPressed: () {
                Get.offAll(() => HomeScreen());
              },
              style: buttonStylePrimary,
              child: const Text('Go to Home'),
            ),
          )
        ],
      ),
    );
  }
}
