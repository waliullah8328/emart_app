import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/home_screen/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{

  RxBool isLoading = false.obs;

  // Text Controller
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final passwordRegex = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@#$%^&+=!]).{8,}$',
  );



  // Login method
  Future<UserCredential?> loginMethod({email,password,context})async{
    UserCredential? userCredential;
    try{
      await auth.signInWithEmailAndPassword(email: email, password: password);

    }
    on FirebaseAuthException catch(e){
      VxToast.show(context, msg: e.toString());

    }
    return userCredential;

  }

  // Login Action
  void loginAction() {
    if(formKey.currentState!.validate()){
      if(GetUtils.isEmail(emailController.text)){
        loginProcess();
      }
      else{
        Get.snackbar("Invalid Email", "Your Email is not Valid");
      }
    }
  }

  //Login Process
  void loginProcess() async{
    isLoading(true);


    try{
      final UserCredential userCredential = await signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
      );
      debugPrint("-------signInWithGoogle  =>  1  --------");

      // if(userCredential.user!.emailVerified){
      final user = userCredential.user!;

      debugPrint(user.email);

      debugPrint(user.displayName);
      debugPrint(user.photoURL);
      debugPrint(user.uid);
      debugPrint("Valid User");

      Get.snackbar("Login Successfully", "You are ready to go");
      Get.offAll(()=>const Home());
      // }else{
      //   debugPrint("Invalid User");
      // }
    }catch(e){
      isLoading(false);

      e.toString().text.make();
    }

  }

// SignIn Method
   Future<UserCredential> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      return credential;
    }  catch (e) {
      e.toString().text.make();
      throw UnimplementedError();
    }
  }
  // SignUp Method
  Future<UserCredential?> signUpMethod({email,password,context})async{
    UserCredential? userCredential;
    try{
      await auth.createUserWithEmailAndPassword(email: email, password: password);

    }
    on FirebaseAuthException catch(e){
      VxToast.show(context, msg: e.toString());

    }
    return userCredential;

  }

  // Storing data method

storeDataMethod ({name,password,email})async{
    DocumentReference store = await firestore.collection(usersCollection).doc(currentUser!.uid);
    store.set({
      "name": name,
      "password": password,
      "email": email,
      "imageUrl":"",
      "id": currentUser!.uid,
      "cart_count": "00",
      "order_count": "00",
      "wishlist_count": "00",
    });
}

// SignOut Method

signoutMethod (context)async{
    try{
      auth.signOut();

    }catch(e){
      VxToast.show(context, msg: e.toString());

    }

}





}