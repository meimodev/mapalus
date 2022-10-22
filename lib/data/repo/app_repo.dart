import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';
import 'dart:developer' as dev;

class AppRepoContract {}

class AppRepo extends AppRepoContract {
  FirestoreService firestoreService = FirestoreService();

  Future<List<Map<String, dynamic>>> getDeliveryTimes() async {
    final res = await firestoreService.getDeliveryTimes();
    final data = res as Map<String, dynamic>;
    return List<Map<String, dynamic>>.from(data['deliveries']);
  }

  Future<bool> checkIfLatestVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String version = packageInfo.version;
    Version localVersion = Version.fromList(version.split('.'));

    var data = await firestoreService.getAppVersion();
    Version remoteVersion = Version.fromMap(data as Map<String, dynamic>);

    dev.log('[APP VERSION] local $localVersion remote $remoteVersion');

    if (remoteVersion > localVersion) {
      return false;
    }
    return true;
  }

  Future<String> getCurrentVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return 'v${packageInfo.version}';
  }

  Future<Map<String, dynamic>> getPricingModifier() async {
    var data = await firestoreService.getPricingModifier();
    return data as Map<String, dynamic>;
  }
}
