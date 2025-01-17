

import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/auth_controller.dart';
import 'package:emart_app/views/home_screen/home.dart';
import 'package:emart_app/views/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../consts/list.dart';
import '../../widgets_common/applogo_widget.dart';
import '../../widgets_common/bg_widget.dart';
import '../../widgets_common/custom_textfield.dart';
import '../../widgets_common/our_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool? isChecked = false;
  final controller = Get.put(AuthController());

  // text Controller
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Center(
              child: Column(
                children: [
                  (context.screenHeight * 0.1).heightBox,
                  applogoWidget(),
                  "Join the $appname".text
                      .fontFamily(bold)
                      .white
                      .size(18)
                      .make(),
                  15.heightBox,
                  Obx(() => controller.isLoading.value ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  )
                      :Column(
                    children: [
                      customTextField(hint: nameHint, title: name,controller: nameController,isPass: false),
                      customTextField(hint: emailHint, title: email,controller: emailController,isPass: false),
                      customTextField(hint: passwordHint, title: password,controller: passwordController,isPass: true),
                      customTextField(hint: passwordHint, title: retypePassword,controller: passwordRetypeController,isPass: true),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(onPressed: (){

                        }, child: forgetPass.text.make()),

                      ),


                      Row(
                        children: [
                          Checkbox(
                              checkColor: redColor,
                              value: isChecked, onChanged: (value){
                                setState(() {
                                  isChecked = value;
                                });

                          }),
                          10.widthBox,
                          Expanded(
                            child: RichText(text: const TextSpan(
                                children: [
                                  TextSpan(text: "I agree with the ",style: TextStyle(
                                    fontFamily: regular,
                                    color: fontGrey,
                                  )),
                                  TextSpan(text: termsAndCondition,style: TextStyle(
                                    fontFamily: regular,
                                    color: redColor,
                                  )),
                                  TextSpan(text: " & ",style: TextStyle(
                                    fontFamily: regular,
                                    color: fontGrey,
                                  )),
                                  TextSpan(text: privacyPolicy,style: TextStyle(
                                    fontFamily: regular,
                                    color: redColor,
                                  )),
                                ]
                            )),
                          ),



                        ],
                      ),
                      5.heightBox,
                      ourButton(Color: isChecked == true ?redColor: lightGrey,
                          title: signup,
                          textColor: whiteColor,
                          onPress: () async {
                        controller.isLoading(true);
                        if(isChecked != false){
                          try{
                            await controller.signUpMethod(context: context,email: emailController.text,password: passwordController.text).then((value) {
                              return controller.storeDataMethod(
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,

                              );
                            }).then((value) {
                              VxToast.show(context, msg: loggedIn);
                              Get.offAll(()=> const Home());
                            });

                          }catch(e){
                            auth.signOut();
                            VxToast.show(context, msg: e.toString());
                            controller.isLoading(false);

                          }

                        }

                          }).box.width(context.screenWidth - 50)
                          .make(),
                      10.heightBox,
                      RichText(text: const TextSpan(
                        children: [
                          TextSpan(
                            text: allReadyHaveAccount,
                            style: TextStyle(
                              fontFamily: bold,
                              color: fontGrey,
                            )
                          ),
                          TextSpan(
                              text: login,
                              style: TextStyle(
                                fontFamily: bold,
                                color: fontGrey,
                              )
                          )
                        ]
                      )).onTap(() { Get.back();}),



                    ],
                  )).box.white.rounded
                      .padding(const EdgeInsets.all(16))
                      .width(context.screenWidth - 70)
                      .shadowSm
                      .make(),

                ],
              ),
            )

        ));
  }
}
