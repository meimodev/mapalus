import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mapalus/data/models/user_app.dart';

class FirestoreService {
  FirebaseFirestore fireStore;

  FirestoreService() : fireStore = FirebaseFirestore.instance;

  Future<void> getProducts() async {
    CollectionReference col = fireStore.collection('products');
    DocumentSnapshot doc = await col.doc('1').get();

    Map data = doc.data() as Map<String, dynamic>;
    print(data);
  }

  Future<UserApp?> getUser(String phone) async {
    CollectionReference col = fireStore.collection('users');
    DocumentSnapshot doc = await col.doc(phone).get();

    if (doc.exists) {
      Map data = doc.data() as Map<String, dynamic>;
      UserApp userApp = UserApp(
        phone: phone,
        name: data['name'],
      );
      return userApp;
    } else {
      return null;
    }
  }

  Future<bool> checkPhoneRegistration(String phone) async {
    CollectionReference col = fireStore.collection('users');
    DocumentSnapshot doc = await col.doc(phone).get();

    return doc.exists;
  }

  Future<UserApp> createUser(UserApp user) async {
    CollectionReference users = fireStore.collection('users');

    users
        .doc(user.phone)
        .set(user.toMap())
        .then((value) => '[FIRESTORE] User successfully registered');

    return user;
  }

  Future<List<Map<String, dynamic>>> getDeliveryTimes() async {
    CollectionReference col = fireStore.collection('delivery_time');
    DocumentSnapshot doc = await col.doc('-env').get();

    Map data = doc.data() as Map<String, dynamic>;

    return Future.value(List<Map<String, dynamic>>.from(data["deliveries"]));
  }
}