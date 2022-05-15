import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mapalus/data/services/firebase_services.dart';

class NotificationService {
  static NotificationService? _instance;

  static NotificationService get instance =>
      _instance ??= NotificationService._();

  String? serverKey;
  List<String>? partnerFCMToken;

  NotificationService._() {
    _fetchServerKey();
    _fetchPartnerFCMToken();

    /// Server Key
    ///AAAAT6X35y8:APA91bGRDEWY5NoZ_yGcDMlKHIBJfl-Zy24LEhW9nODanXRonLr1LB
    ///We64_aEKEYHP7lJWwI7D3CBn9TKxJVOU_lQ-tfo6OOpY99_XosPRpa5qFG1g989GjY
    ///X0W1ovTn70GHG_z6twg_
  }

  Future<void> _fetchServerKey() async {
    var fs = FirestoreService();
    var data = await fs.getAppKeys();
    var mapData = data as Map<String, dynamic>;

    serverKey = mapData['server_key'];
  }

  Future<void> _fetchPartnerFCMToken() async {
    var fs = FirestoreService();
    var data = await fs.getPartnerKey("089525699078");
    var mapData = data as Map<String, dynamic>;

    partnerFCMToken = List<String>.of(mapData['fcm_token']);
  }

  Future<bool> sendNotification({
    required String title,
    required String message,
    List<String> toToken = const [],
  }) async {
    if (serverKey == null) {
      await _fetchServerKey();
    }
    if (partnerFCMToken == null) {
      await _fetchPartnerFCMToken();
    }

    List<String> sourceToken = toToken.isEmpty ? partnerFCMToken! : toToken;
    for (String token in sourceToken) {
      constructNotification(title, message, token);
    }

    return true;
  }

  Future<void> constructNotification(
    String title,
    String message,
    String token,
  ) async {
    const baseUrl = "https://fcm.googleapis.com/fcm/send";
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "key=$serverKey",
    };
    final body = {
      "to": token,
      "notification": {
        "title": title,
        "body": message,
      },
      "data": {
        "url": "https://www.mapalusindonesia.com",
      }
    };

    try {
      Dio dio = Dio();
      var response = await dio.post(
        baseUrl,
        data: body,
        options: Options(headers: headers),
      );
      if (kDebugMode) {
        print(response);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}