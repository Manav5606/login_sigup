import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:truster_app/controller/login_controller.dart';
import 'package:truster_app/utils/time_format.dart';

import '../../const/color_constants.dart';
import '../../const/theme_const.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);
  final LoginController controller=LoginController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: const Text(
          'Verification',
          style: appBarTextStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: Obx(
              () => Form(
            // key: controller.ssnVerificationFormKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: !controller.verificationCodeSent.value
                    ? [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      'We’ll send you the 5 digit Verification code to your resgisterd mobile number to verify your phone number.',
                      style: TextStyle(color: grey, fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 15),
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

                  /*TextFormField(
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(borderSide: BorderSide(style: BorderStyle)),
                        suffixIcon: ),
                    // controller: controller.emailText,
                    readOnly: true,
                    validator: (value) {
                      if (value == '') {
                        return 'Please enter DOB';
                      }
                      return null;
                    },
                  ),*/
                  const SizedBox(height: 30),
                  Obx(
                        () => ElevatedButton(
                      onPressed: () {
                       
                      },
                      style: buttonStylePrimary,
                      child: controller.loggingIn.value
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
                          Text('Sending Verification Code')
                        ],
                      )
                          : const Text('Send Verification Code'),
                    ),
                  ),
                ]
                    : [
                  const Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      'Enter the 5 digit verification code sent to your registered mobile number',
                      style: TextStyle(color: grey, fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      controller.phoneNumberText.text,
                      style: const TextStyle(color: primary, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: Get.width * 0.15,
                        child: TextFormField(
                          decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: Get.width * 0.15,
                        child: TextFormField(
                          decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: Get.width * 0.15,
                        child: TextFormField(
                          decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: Get.width * 0.15,
                        child: TextFormField(
                          decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: Get.width * 0.15,
                        child: TextFormField(
                          decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),

                  /*TextFormField(
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(borderSide: BorderSide(style: BorderStyle)),
                        suffixIcon: ),
                    // controller: controller.emailText,
                    readOnly: true,
                    validator: (value) {
                      if (value == '') {
                        return 'Please enter DOB';
                      }
                      return null;
                    },
                  ),*/
                  const SizedBox(height: 30),
                  Obx(
                        () => ElevatedButton(
                      onPressed: () {
                    ;
                      },
                      style: buttonStylePrimary,
                      child: controller.verifyingOTP.value
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
                          Text('Verifying')
                        ],
                      )
                          : const Text('Verify'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                      onPressed: controller.resentTimeCountdown.value > 0 ? null : () {},
                      child: controller.resentTimeCountdown.value > 0
                          ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Resend Verification Code '),
                          const Icon(Icons.timer_outlined,size: 18,),
                          Text(' ${TimeFormat.formattedTime(controller.resentTimeCountdown.value)}'),
                        ],
                      )
                          : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.repeat_rounded),
                          Text('Resend Verification Code'),
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
