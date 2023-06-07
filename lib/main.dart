import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:truster_app/const/color_constants.dart';


import 'firebase_options.dart';
import 'view/login_signup/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } else if (Platform.isIOS) {
    await Firebase.initializeApp();
  }
  /*await Firebase.initializeApp(
    name: 'TrusterApp',
    options: DefaultFirebaseOptions.currentPlatform,
  );*/
  await GetStorage.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  // NotificationSettings settings = await messaging.requestPermission(
  //   alert: true,
  //   announcement: false,
  //   badge: true,
  //   carPlay: false,
  //   criticalAlert: false,
  //   provisional: false,
  //   sound: true,
  // );
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Check if you received the link via `getInitialLink` first
  final PendingDynamicLinkData? initialLink =
      await FirebaseDynamicLinks.instance.getInitialLink();

  if (initialLink != null) {
    final Uri deepLink = initialLink.link;
    // Example of using the dynamic link to push the user to a different screen
    print(deepLink.data.toString());
  }

  // FirebaseDynamicLinks.instance.onLink.listen(
  //   (pendingDynamicLinkData) {
  //     // Set up the `onLink` event listener next as it may be received here
  //     final Uri deepLink = pendingDynamicLinkData.link;
  //     // Example of using the dynamic link to push the user to a different screen
  //     print(deepLink.data.toString());
  //     log('app opened from dynamic link ${deepLink.queryParameters.toString()}');
  //     if (deepLink.path == '/paymentReturnUrl') {
  //       final transactionId =
  //           deepLink.queryParameters['transactionId'].toString();

  //       tr.Transaction? transaction = TransactionController
  //           .to.activeTransactions
  //           .firstWhereOrNull((element) => element.id == transactionId);
  //       if (transaction != null) {
  //         final index =
  //             TransactionController.to.activeTransactions.indexOf(transaction);
  //         // Get.offUntil(page, (route) => false);
  //         // Get.
  //         TransactionController.to
  //             .showTransactionDetails(transaction, index, true, fromMain: true);
  //       } else {
  //         createToast('Something went wrong');
  //       }
  //     } else {
  //       createToast('Something went wrong');
  //     }
  //   },
  // );
  runApp(MyApp(initialLink));
}

Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(" ${message.messageId} , ${message.notification}");
}


class MyApp extends StatelessWidget {
  const MyApp(this.initialLink, {super.key});

  final PendingDynamicLinkData? initialLink;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Truster App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: primaryColor,
        scaffoldBackgroundColor: white,
        appBarTheme: const AppBarTheme(
          backgroundColor: white,
          elevation: 0,
          foregroundColor: black,
          actionsIconTheme: IconThemeData(color: grey),
        ),
      ),
      home: SplashScreen(
        initialLink: initialLink,
      ),
    );
  }
}
