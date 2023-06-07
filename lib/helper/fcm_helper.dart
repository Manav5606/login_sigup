import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FCMHelper {
  static const String fcmServerKey =
      'AAAA8zBFMBc:APA91bEez_ArK98GHSzTcHDRKq2U7TS8jU8EqqOcE8lpDC927QwvCBagel_7C5_i5NlNHg_IlfZo_Gc3l3cUqM2AE-5crkJn_TZdy4dtEBhPAas0PPDUiVv5sylw17_OTVXI9tiyH0KC';

  Future<void> sendPushNotification(
      {required String notificationBody, required String notificationTitle, required String userToken}) async {
    try {
      final response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{'content-type': 'application/json', 'Authorization': 'key=$fcmServerKey'},
        body: jsonEncode(
          <String, dynamic>{
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': notificationBody,
              'title': notificationTitle,
            },
            'notification': <String, dynamic>{
              'title': notificationTitle,
              'body': notificationBody,
              'android_channel_id': 'truster_transaction',
            },
            'to': userToken
          },
        ),
      );
      debugPrint(response.statusCode.toString());
      debugPrint(response.body);
    } catch (e) {
      // Get.snackbar(
      //   '*** tmr Error sending push notification',
      //   e.toString(),
      // );
      debugPrint(e.toString());
    }
  }
}
