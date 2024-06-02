import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/Services/firestore_services.dart';
import 'package:emart_app/consts/consts.dart';

import 'package:emart_app/controller/product_controller.dart';
import 'package:emart_app/views/categories_screen/items_details.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:emart_app/widgets_common/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryDetails extends StatelessWidget {

  String? title;
  CategoryDetails({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();

    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: title!.text.fontFamily(bold).white.make(),
        ),
        body: StreamBuilder(
            stream: FirestoreServices.geProducts(title),
            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
              if(!snapshot.hasData){
                return Center(child: loadingIndicator(),);


              }
              else if(snapshot.data!.docs.isNotEmpty){
                return Center(child: "No products are found!".text.color(darkFontGrey).make(),);

              }

              else{
                var data = snapshot.data!.docs;
                return Container(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                              controller.subCat.length,
                                  (index) => "${controller.subCat[index]}"
                                  .text
                                  .fontFamily(semibold)
                                  .size(12)
                                  .color(darkFontGrey)
                                  .makeCentered()
                                  .box
                                  .white
                                  .rounded
                                  .size(120, 60)
                                  .margin(const EdgeInsets.symmetric(horizontal: 4))
                                  .make()),
                        ),
                      ),

                      // Items Container
                      20.heightBox,
                      Expanded(
                          child: GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: data.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 250,
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8
                            ),
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    data[index]["p_imgs"][0],
                                    width: 200,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),

                                  "${data[index]["p_name"]}"
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make(),
                                  10.heightBox,
                                  "${data[index]["p_price"]}".numCurrency
                                      .text
                                      .color(redColor)
                                      .fontFamily(bold)
                                      .size(16)
                                      .make()
                                ],
                              )
                                  .box
                                  .white
                                  .margin(const EdgeInsets.symmetric(horizontal: 4))
                                  .roundedSM
                                  .outerShadow
                                  .padding(const EdgeInsets.all(12))
                                  .make().onTap(() {
                                Get.to(()=>  ItemsDetails(title: "${data[index]["p_name"]}",data: data[index]));
                              });
                            },
                          )),
                    ],
                  ),
                );
              }
            },
        ),
      ),
    );
  }
}
