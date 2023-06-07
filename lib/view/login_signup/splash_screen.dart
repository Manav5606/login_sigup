import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:truster_app/controller/login_controller.dart';

import '../../const/color_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({required this.initialLink, Key? key}) : super(key: key);
  final PendingDynamicLinkData? initialLink;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
     Get.put(LoginController(widget.initialLink), permanent: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: Get.width * 0.7,
          height: Get.width * 0.7,
          child: Image.asset('assets/logo/logo.png'),
        ),
      ),
      backgroundColor: white,
    );
  }
}
