import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:truster_app/controller/login_controller.dart';

import '../../helper/fcm_helper.dart';


class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  final LoginController loginController = LoginController.to;
  User? currentUser = FirebaseAuth.instance.currentUser;
  String fc = "";

  @override
  void initState() {
    // TODO: implement initState
    // FCMHelper().sendPushNotification(
    //     notificationBody: 'Account Created Succesfully',
    //     notificationTitle: 'Welcome',
    //     userToken: TrusterUser(uid: currentUser!.uid).fcmToken!);
    // getUserData(currentUser!.uid);
    // print(currentUser!.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          child: Center(
              child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  loginController.logoutUser();
                },
                child: Text("LogOut"),
              ),
              ElevatedButton(
                onPressed: () {
                  FCMHelper().sendPushNotification(
                      notificationBody: 'Account Created Succesfully',
                      notificationTitle: 'Welcome',
                      userToken: fc);
                },
                child: Text("Send Notification"),
              ),
            ],
          )),
        ));
  }

  void getUserData(String userId) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (snapshot.exists) {
        String? userName = snapshot.get('fcmToken');
        if (userName != null) {
          setState(() {
            fc = userName;
          });
          print(userName);
        } else {
          print('User name is null');
        }
      } else {
        print('User does not exist');
      }
    } catch (e) {
      print('Error retrieving user data: $e');
    }
  }
}