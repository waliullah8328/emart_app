import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/Services/firestore_services.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/list.dart';
import 'package:emart_app/controller/auth_controller.dart';
import 'package:emart_app/controller/profile_controller.dart';
import 'package:emart_app/views/account_screen/components/details_card.dart';
import 'package:emart_app/views/account_screen/edit_profile_screen.dart';
import 'package:emart_app/views/auth_screen/login_screen.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(ProfileController());



    return bgWidget(
      child: Scaffold(
        body: StreamBuilder(
            stream: FirestoreServices.getUser(currentUser!.uid),
            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
              if(!snapshot.hasData){
                return const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor),),);
              }
              else{
                var data = snapshot.data!.docs[0];
                return SafeArea(child: Column(

                  children: [
                    // Edit profile button
                    const Align(
                        alignment: Alignment.topRight,
                        child: Icon(Icons.edit,color: whiteColor,)).onTap(() {

                      controller.nameController.text = data["name"];

                      Get.to(()=> EditProfileScreen(data: data,));

                    }),



                    // User Details Section

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          data["imageUrl"]==""?
                          Image.asset(imgProfile2,width: 85,fit: BoxFit.fill,).box.roundedFull.clip(Clip.antiAlias).make()
                          :Image.network(data['imageUrl'],width: 85,fit: BoxFit.fill,).box.roundedFull.clip(Clip.antiAlias).make(),
                          10.widthBox,
                          Expanded(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "${data["name"]}".text.fontFamily(semibold).white.make(),

                              "${data["email"]}".text.white.make(),
                            ],
                          )),
                          OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                    color: Colors.white,

                                  )
                              ),
                              onPressed: () async {
                                await Get.put(AuthController()).signoutMethod(context);
                                Get.offAll(()=> const LoginScreen());

                              }, child: logout.text.fontFamily(semibold).white.make()),
                        ],
                      ),
                    ),
                    15.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        detailsCard(count: data["cart_count"],title: "in your cart",width: context.screenWidth/3.4),
                        detailsCard(count: data["wishlist_count"],title: "in your wishlist",width: context.screenWidth/3.4),
                        detailsCard(count: data["order_count"],title: "your orders",width: context.screenWidth/3.4),
                      ],
                    ),

                    // Button Section


                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: accountButtonList.length,
                      separatorBuilder: (context, index) {
                        return const Divider(
                          color: lightGrey,
                        );
                      },
                      itemBuilder: (context, index) {
                        return ListTile(
                          title:accountButtonList[index].text.fontFamily(semibold).color(darkFontGrey).make(),
                          leading: Image.asset(accountButtonIcon[index],width: 22,),

                        );

                      },
                    ).box.white.rounded.margin(const EdgeInsets.all(12)).padding(const EdgeInsets.symmetric(horizontal: 16)).shadowSm.make().box.color(redColor).make(),

                  ],
                ));
              }

            },
        ),
      ),
    );
  }
}