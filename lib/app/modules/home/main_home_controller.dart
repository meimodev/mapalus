import 'dart:developer' show log;

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mapalus/shared/routes.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';
import 'package:mapalus_flutter_commons/repos/repos.dart';

class MainHomeController extends GetxController {
  final appRepo = Get.find<AppRepo>();

  // final userRepo = Get.find<UserRepo>();

  DateTime? currentBackPressTime;

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  @override
  void onInit() async {
    super.onInit();

    final latestVersion = await appRepo.checkIfLatestVersion(false);
    if (!latestVersion) {
      Get.offNamed(Routes.updateApp);
      return;
    }

    _initNotificationHandler();
  }

  void navigateTo(int index) {
    pageController.jumpToPage(
      index,
    );
  }

  void _initNotificationHandler() async {
    const androidChannel = AndroidNotificationChannel(
      'order_channel', // id
      'order channel',
      description: 'used to handle order notification exclusively',
      importance: Importance.high,
      enableVibration: true,
      enableLights: true,
      playSound: true,
      showBadge: true,
    );

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final initializationSettingsIos = DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) {
        log('[MAIN HOME CONTROLLER] IOS Local Notification $id $title $body $payload');
      },
    );
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIos,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        log("[MAIN HOME CONTROLLER] onDidReceiveNotificationResponse $response");
      },
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);

    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      log("[MAIN HOME CONTROLLER] Initial Message is not null $initialMessage");
      _handleMessage(
        message: initialMessage,
        flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
        androidChannel: androidChannel,
      );
    }

    FirebaseMessaging.onMessage.listen((event) {
      log("[MAIN HOME CONTROLLER] onMessage data $event");
      _handleMessage(
        message: event,
        flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
        androidChannel: androidChannel,
      );
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      log("[MAIN HOME CONTROLLER] onMessageOpenedApp data $event");
      _handleMessage(
        message: event,
        flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
        androidChannel: androidChannel,
      );
    });
  }

  Future<void> _handleMessage({
    required RemoteMessage message,
    required FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    AndroidNotificationChannel? androidChannel,
  }) async {
    RemoteNotification? notification = message.notification;

    if (notification != null) {
      AndroidNotification? android = notification.android;
      AndroidNotificationDetails? androidNotificationDetails;
      if (android != null) {
        androidNotificationDetails = AndroidNotificationDetails(
          androidChannel!.id,
          androidChannel.name,
          channelDescription: androidChannel.description,
          importance: Importance.max,
          priority: Priority.high,
          // enableVibration: true,
          // enableLights: true,
        );
      }

      await flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(android: androidNotificationDetails),
      );
    }
  }
}
