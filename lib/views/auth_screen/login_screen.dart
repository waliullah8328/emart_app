import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/list.dart';
import 'package:emart_app/views/auth_screen/signup_screen.dart';
import 'package:emart_app/views/home_screen/home.dart';
import 'package:emart_app/widgets_common/applogo_widget.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:emart_app/widgets_common/custom_textfield.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    return bgWidget(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogoWidget(),
            "Log in to $appname".text.fontFamily(bold).white.size(18).make(),
            15.heightBox,
            Form(
              key: controller.formKey,
              child: Obx(() => Column(
                children: [
                  customTextField(hint: emailHint,title: email,isPass: false,controller: controller.emailController),
                  customTextField(hint: passwordHint,title: password,isPass: true,controller: controller.passwordController),
                  Align(
                    alignment: Alignment.centerRight,

                      child: TextButton(onPressed: (){}, child: forgetPass.text.make())),
                  5.heightBox,
                  controller.isLoading.value == true
                      ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  )
                      :ourButton(Color: redColor,title: login,textColor: whiteColor,onPress: (){
                        controller.loginAction();
                  }, ).box.width(context.screenWidth - 50 ).make(),
                  5.heightBox,
                  createNewAccount.text.color(fontGrey).make(),
                  5.heightBox,
                  ourButton(Color: lightgolden,title: signup,textColor: redColor,onPress:(){
                    Get.to(()=> const SignUpScreen());
                  } ).box.width(context.screenWidth - 50 ).make(),
                  10.heightBox,
                  loginWith.text.color(fontGrey).make(),
                  5.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: lightGrey,
                        radius: 25,
                        child: Image.asset(socialIconList[index],width: 30,),),
                    )),

                  ),

                ],
              )).box.white.rounded.padding(const EdgeInsets.all(16)).width(context.screenWidth -70).shadowSm.make(),
            ),

          ],
        ),
      )

    ));
  }
}
