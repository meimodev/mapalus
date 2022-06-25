import 'package:flutter/foundation.dart';
import 'package:mapalus/data/models/version.dart';
import 'package:mapalus/data/services/firebase_services.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppRepoContract {}

class AppRepo extends AppRepoContract {
  FirestoreService firestoreService = FirestoreService();

  Future<List<Map<String, dynamic>>> getDeliveryTimes() async {
    var data = await firestoreService.getDeliveryTimes();
    return data;
  }

  Future<bool> checkIfLatestVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String version = packageInfo.version;
    Version localVersion = Version.fromList(version.split('.'));

    var data = await firestoreService.getAppVersion();
    Version remoteVersion = Version.fromMap(data as Map<String, dynamic>);

    if (kDebugMode) {
      print('[APP VERSION] local $localVersion remote $remoteVersion');
    }

    if (remoteVersion > localVersion) {
      return false;
    }
    return true;
  }

  Future<String> getCurrentVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return 'v${packageInfo.version}';
  }
}