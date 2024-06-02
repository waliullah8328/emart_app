import 'package:emart_app/consts/consts.dart';

class FirestoreServices{



  // Get Users data
  static getUser(uid){
    return firestore.collection(usersCollection).where("id",isEqualTo: uid).snapshots();

  }

  // Get product according to categories

 static geProducts(category){
    return firestore.collection(productsCollection).where("p_category",isEqualTo: category).snapshots();

    
 }
}