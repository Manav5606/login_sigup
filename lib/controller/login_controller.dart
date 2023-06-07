import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:local_auth/local_auth.dart';
import 'package:truster_app/const/firestore_collections.dart';
import 'package:truster_app/modal/truster_user.dart';
import 'package:truster_app/view/home/home_screen.dart';
import 'package:truster_app/view/login_signup/forgot_password_screen.dart';
import 'package:truster_app/view/login_signup/login_screen.dart';
import '../utils/country_code.dart';
import '../view/login_signup/on_boarding_screen.dart';
import '../view/login_signup/sign_up_screen.dart';



class LoginController extends GetxController {
  static LoginController get to => Get.find();
  RxBool showPassword = RxBool(false);
  RxBool showResetPassword = RxBool(false);
  RxBool showResetConfirmPassword = RxBool(false);
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  TextEditingController emailText = TextEditingController();
  TextEditingController passwordText = TextEditingController();
  TextEditingController resetPasswordText = TextEditingController();
  TextEditingController resetConfirmPasswordText = TextEditingController();
  RxBool loggingIn = RxBool(false);
  RxBool userNotFoundError = RxBool(false);
  Rx<TrusterUser?> trusterUser = Rx(null);
  RxBool userAlreadySignedIn = RxBool(false);
  RxBool useBiometric = RxBool(false);

  //Forgot Password
  RxBool verificationCodeSent = RxBool(false);
  RxString selectedCountryCode = RxString('');
  RxList countryLists = RxList.empty();
  TextEditingController phoneNumberText = TextEditingController();
  RxBool showMobileError = RxBool(false);
  Timer? resendCodeTimer;
  RxInt resentTimeCountdown = RxInt(120);
  RxBool verifyingOTP = RxBool(false);
  final FirebaseAuth fbAuth = FirebaseAuth.instance;

  //Signup controller
  RxBool showSignUpPassword = RxBool(false);
  RxBool showSignupConfirmPassword = RxBool(false);
  RxBool showMobileErrorSignup = RxBool(false);
  RxBool showDLImageError = RxBool(false);
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> ssnVerificationFormKey = GlobalKey<FormState>();
  TextEditingController usernameText = TextEditingController();
  TextEditingController signupEmailText = TextEditingController();
  TextEditingController signupPhoneNumberText = TextEditingController();
  TextEditingController signupPasswordText = TextEditingController();
  TextEditingController confirmPasswordText = TextEditingController();
  TextEditingController nameText = TextEditingController();
  TextEditingController ssnNumberText = TextEditingController();
  TextEditingController dobText = TextEditingController();
  TextEditingController dlFileNameText = TextEditingController();
  TextEditingController otpDigit1 = TextEditingController();
  TextEditingController otpDigit2 = TextEditingController();
  TextEditingController otpDigit3 = TextEditingController();
  TextEditingController otpDigit4 = TextEditingController();
  TextEditingController otpDigit5 = TextEditingController();
  TextEditingController otpDigit6 = TextEditingController();
  FocusNode otpDigit1Focus = FocusNode();
  FocusNode otpDigit2Focus = FocusNode();
  FocusNode otpDigit3Focus = FocusNode();
  FocusNode otpDigit4Focus = FocusNode();
  FocusNode otpDigit5Focus = FocusNode();
  FocusNode otpDigit6Focus = FocusNode();
  RxBool creatingAccount = RxBool(false);
  RxBool sendingOtp = RxBool(false);
  RxBool signupVerifyingOTP = RxBool(false);
  RxBool verifyingSSN = RxBool(false);
  RxBool detailsNotFoundError = RxBool(false);
  RxBool signupVerificationCodeSent = RxBool(false);
  Rx<DateTime> selectedDOB = Rx(DateTime.now());
  final DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  File? dlImageFile;
  final storageRef = FirebaseStorage.instance.ref();
  String verificationId = '';
  int? resendToken;
  User? currentUser = FirebaseAuth.instance.currentUser;
  PendingDynamicLinkData? initialLink;

  @override
  void onInit() {
    super.onInit();
    checkLogin();
    getCountryList();
    fcmTokenListener();
  }

  LoginController(PendingDynamicLinkData? pendingLink) {
    if (pendingLink != null) {
      initialLink = pendingLink;
      print(pendingLink.link.path);
    }
  }

  void signup() async {
    creatingAccount(true);
    if (signUpFormKey.currentState!.validate()) {
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailText.text,
          password: passwordText.text,
        );
        currentUser = credential.user;
        await currentUser?.sendEmailVerification();
        final String? fcmToken = await FirebaseMessaging.instance.getToken();
        if (currentUser != null) {
          trusterUser.value = TrusterUser(
              uid: currentUser!.uid,
              username: usernameText.text,
              email: emailText.text,
              fcmToken: fcmToken!,
              fullName: nameText.text,
              mobile: phoneNumberText.text,
              countryCode: CountryCode.getCountryCodeFromString(
                  selectedCountryCode.value),
              imageUrl: '',
              ssnNumber: '',
              dob: DateTime(1900, 1, 1),
              dlImageUrl: '',
              phoneVerified: false,
              ssnVerified: false);
          debugPrint(trusterUser.value!.toJson().toString());
          await addUserData();
          Get.to(() => LoginScreen());
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Fluttertoast.showToast(msg: 'The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          Fluttertoast.showToast(
              msg: 'The account already exists for that email.');
        } else {
          Fluttertoast.showToast(msg: e.code);
          if (kDebugMode) {
            print(e.code);
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
      // Get.to(() => SSNVerificationScreen());
    }
    creatingAccount(false);
  }

  Future<void> addUserData() async {
    await FirebaseFirestore.instance
        .collection(usersCollection)
        .doc(currentUser!.uid)
        .set(trusterUser.value!.toJson());
  }

  validateMobile() async {
    if (phoneNumberText.text == '') {
      showMobileError(true);
    } else {
      showMobileError(false);
    }
  }

  /*void goToLoginScreen() async {
    Get.off(() => LoginScreen());
  }*/

  String? validateConfirmPassword(String? value) {
    String? error;
    if (value != passwordText.text) {
      error = 'Password didn\'t match';
    }
    return error;
  }

  selectDOB(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: selectedDOB.value,
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (selectedDate != null) {
      selectedDOB.value = selectedDate;
      dobText.text = dateFormat.format(selectedDate);
    }
  }

  void checkLogin() async {
    await Future.delayed(const Duration(seconds: 3));
    if (fbAuth.currentUser != null) {
      debugPrint('userLoggedIn');
      currentUser = fbAuth.currentUser;
      if (GetStorage().hasData('useBiometric')) {
        useBiometric.value = await GetStorage().read('useBiometric');
      }
      userAlreadySignedIn(true);
      emailText.text = currentUser!.email!;
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => OnBoardingScreen());
      debugPrint('userNotLoggedIn');
    }
    //
  }

  Future<void> loginWithBiometric() async {
    final LocalAuthentication auth = LocalAuthentication();
    final List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();

    if (availableBiometrics.isNotEmpty) {
      // Some biometrics are enrolled.
      if (Platform.isAndroid) {
        if (availableBiometrics.contains(BiometricType.strong) ||
            availableBiometrics.contains(BiometricType.fingerprint) ||
            availableBiometrics.contains(BiometricType.face)) {
          // Specific types of biometrics are available.
          // Use checks like this with caution!

          try {
            final bool didAuthenticate = await auth.authenticate(
                localizedReason: 'Please authenticate to Login');
            if (didAuthenticate) {
              print('auth done');
              loggingIn(true);
              await fetchDataOnLogin();
              loggingIn(false);
            }
          } catch (e) {
            // ...
            print(e.toString());
          }
        }
      } else if (Platform.isIOS) {
        if (availableBiometrics.contains(BiometricType.strong) ||
            availableBiometrics.contains(BiometricType.face) ||
            availableBiometrics.contains(BiometricType.fingerprint)) {
          // Specific types of biometrics are available.
          // Use checks like this with caution!

          try {
            final bool didAuthenticate = await auth.authenticate(
                localizedReason: 'Please authenticate to Login');
            if (didAuthenticate) {
              print('auth done');
              loggingIn(true);
              await fetchDataOnLogin();
              loggingIn(false);
            }
          } catch (e) {
            // ...
            print(e.toString());
          }
        }
      }
    } else {
      print('bio blank');
    }
  }

  fetchDataOnLogin() async {
    final result = await getUserData();
    if (result) {
      // if (trusterUser.value!.phoneVerified && trusterUser.value!.ssnVerified) {
        Get.offAll(() => HomeScreen());
      
    } else {
      FirebaseAuth.instance.signOut();
      Get.offAll(() => OnBoardingScreen());
    }
  }

  Future<bool> getUserData() async {
    bool result = false;
    try {
      final String? fcmToken = await FirebaseMessaging.instance.getToken();
      await FirebaseFirestore.instance
          .collection(usersCollection)
          .doc(currentUser!.uid)
          .get()
          .then((snapShot) {
        if (snapShot.exists && snapShot.data()!.isNotEmpty) {
          trusterUser.value = TrusterUser.fromJson(snapShot.data()!);
          debugPrint(trusterUser.value!.toJson().toString());
          result = true;
        }
      });
      if (trusterUser.value!.fcmToken != fcmToken!) {
        trusterUser.value!.fcmToken = fcmToken;
        await FirebaseFirestore.instance
            .collection(usersCollection)
            .doc(currentUser!.uid)
            .update({'fcmToken': fcmToken});
        await FirebaseFirestore.instance
            .collection(contactsCollection)
            .doc(currentUser!.uid)
            .update({'fcmToken': fcmToken});
      }
    } catch (e) {
      logoutUser();
    }

    return result;
  }

  Future<void> fcmTokenListener() async {
    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
      FirebaseFirestore.instance
          .collection(usersCollection)
          .doc(currentUser!.uid)
          .update({'fcmToken': fcmToken});
      FirebaseFirestore.instance
          .collection(contactsCollection)
          .doc(currentUser!.uid)
          .update({'fcmToken': fcmToken});
    });
  }

  void goToLoginScreen(bool fromOnBoarding) async {
    if (fromOnBoarding) {
      Get.to(() => LoginScreen());
    } else {
      Get.off(() => LoginScreen());
    }
  }

  void goToSignUpScreen(bool fromOnBoarding) async {
    if (fromOnBoarding) {
      Get.to(() => SignUpScreen());
    } else {
      Get.off(() => SignUpScreen());
    }
  }

  void login() async {
    if (loginFormKey.currentState!.validate()) {
      try {
        loggingIn(true);
        log('email: ${emailText.text}, password: ${passwordText.text}');
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailText.text, password: passwordText.text);
        currentUser = fbAuth.currentUser!;

        // await Future.delayed(const Duration(seconds: 2));

        if (FirebaseAuth.instance.currentUser != null && await getUserData()) {
          passwordText.text = '';
          passwordText.clear();
         
            Get.offAll(() => HomeScreen());
         
        }
        // userNotFoundError(true);}
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          debugPrint('No user found for this email.');
          Fluttertoast.showToast(msg:'No user found for this email.');
        } else if (e.code == 'wrong-password') {
          debugPrint('Wrong password provided for user.');
          Fluttertoast.showToast(msg:'Wrong password provided for user.');
        } else {
          debugPrint(e.code);
          Fluttertoast.showToast(msg:e.code);
        }
      }
      loggingIn(false);
    }
  }

  //Forgot Password screen
  // validateMobile() async {
  //   if (phoneNumberText.text == '') {
  //     showMobileError(true);
  //   } else {
  //     showMobileError(false);
  //   }
  // }

  getCountryList() async {
    countryLists.clear();
    countryLists.addAll(['US', 'UK', 'IN']);
    selectedCountryCode.value = countryLists[0];
    debugPrint(countryLists.toString());
    debugPrint(selectedCountryCode.value);
  }

  
  

  goToForgotPassword() async {
    getCountryList();
    Get.to(() => ForgotPasswordScreen());
  }

  /* String? validateConfirmPassword(String? value) {
    String? error;
    if (value != passwordText.text) {
      error = 'Password didn\'t match';
    }
    return error;
  }*/

  Future<void> logoutUser() async {
    FirebaseAuth.instance.signOut();
    userAlreadySignedIn(false);
    emailText.clear();
    emailText.text = '';
    trusterUser.value = null;
    currentUser = null;
    // TransactionController.to.dispose();
    Get.offAll(() => OnBoardingScreen());
    // Get.delete<TransactionController>();
  }
}
