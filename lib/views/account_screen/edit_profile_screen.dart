import 'dart:io';

import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/profile_controller.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:emart_app/widgets_common/custom_textfield.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../consts/images.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return bgWidget(
      child: Scaffold(
        appBar: AppBar(),
        body: Obx(() => SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      data["imageUrl"] == "" &&
                              controller.profileImgPath.isEmpty
                          ? Image.asset(
                              imgProfile2,
                              width: 85,
                              fit: BoxFit.fill,
                            ).box.roundedFull.clip(Clip.antiAlias).make()
                          : data["imageUrl"] != "" &&
                                  controller.profileImgPath.isEmpty
                              ? Image.network(
                                  data["imageUrl"],
                                  width: 85,
                                  fit: BoxFit.fill,
                                ).box.roundedFull.clip(Clip.antiAlias).make()
                              : Image.file(
                                  File(controller.profileImgPath.value),
                                  width: 85,
                                  fit: BoxFit.fill,
                                ).box.roundedFull.clip(Clip.antiAlias).make(),
                      10.heightBox,
                      ourButton(
                          Color: redColor,
                          textColor: whiteColor,
                          title: "Change",
                          onPress: () {
                            controller.changeImage(context: context);
                          }),
                      const Divider(),
                      20.heightBox,
                      customTextField(
                          hint: nameHint,
                          title: name,
                          isPass: false,
                          controller: controller.nameController),
                      10.heightBox,
                      customTextField(
                          hint: passwordHint,
                          title: oldPassword,
                          isPass: true,
                          controller: controller.oldPasswordController),
                      10.heightBox,
                      customTextField(
                          hint: passwordHint,
                          title: newPassword,
                          isPass: true,
                          controller: controller.newPasswordController),
                      20.heightBox,
                      controller.isloading.value
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(redColor),
                            )
                          : SizedBox(
                              width: context.screenWidth - 60,
                              child: ourButton(
                                  Color: redColor,
                                  textColor: whiteColor,
                                  title: "Save",
                                  onPress: () async {
                                    controller.isloading(true);

                                    // if image is not selected
                                    if(controller.profileImgPath.value.isNotEmpty){
                                      await controller.uploadProfileImage();
                                    }
                                    else{
                                      controller.profileImageLink = data["imageUrl"];
                                    }

                                    // If old password matches database
                                    if(data['password']== controller.oldPasswordController.text){

                                      await controller.changeAuthPassword(
                                        email: data['email'],
                                        password: controller.oldPasswordController.text,
                                        newPassword: controller.newPasswordController.text,
                                      );

                                      await controller.updateProfile(
                                        imgUrl: controller.profileImageLink,
                                        name: controller.nameController.text,
                                        password:
                                        controller.newPasswordController.text,
                                      );
                                      VxToast.show(context,
                                          msg: "Uploaded Succesfully");
                                    }
                                    else{
                                      VxToast.show(context,
                                          msg: "Wrong Old Password");
                                      controller.isloading(false);

                                    }



                                  }),
                            ),
                    ],
                  ),
                ))
            .box
            .white
            .shadowSm
            .padding(const EdgeInsets.all(16))
            .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
            .rounded
            .make(),
      ),
    );
  }
}
