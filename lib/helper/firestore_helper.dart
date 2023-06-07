import 'package:cloud_firestore/cloud_firestore.dart';
import '../const/firestore_collections.dart';
import '../modal/truster_user.dart';

class FirestoreHelper {
 

  static Future<void> addUser(TrusterUser user) async {}

  static Future<void> updateUser(TrusterUser user) async {}

  

  static Future<TrusterUser?> getUserDetails(String userId) async {
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection(usersCollection).doc(userId).get();
    if (snapshot.exists && snapshot.data()!.isNotEmpty) {
      print(snapshot.data().toString() + DateTime.now().toString());
      return TrusterUser.fromJson(snapshot.data()!);
    } else {
      return null;
    }
  }


}
