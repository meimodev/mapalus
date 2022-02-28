import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices {
  FirebaseFirestore fireStore;

  FirebaseServices() : fireStore = FirebaseFirestore.instance;

  Future<void> getProducts() async {
    CollectionReference col = fireStore.collection('products');
    DocumentSnapshot doc = await col.doc('1').get();

    Map data = doc.data() as Map<String, dynamic>;
    print(data);
  }
}