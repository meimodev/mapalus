import 'package:mapalus/data/services/firebase_services.dart';

class AppRepoContract {}

class AppRepo extends AppRepoContract {
  FirestoreService firestoreService = FirestoreService();

  Future<List<Map<String, dynamic>>> getDeliveryTimes() async {
    var data = await firestoreService.getDeliveryTimes();
    return data;
  }
}