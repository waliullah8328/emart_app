import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/list.dart';
import 'package:emart_app/consts/strings.dart';
import 'package:emart_app/controller/product_controller.dart';
import 'package:emart_app/views/categories_screen/categories_details.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());



    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: categories.text.fontFamily(bold).white.make(),
        ),
        body: Container(
          padding: const EdgeInsets.all(12),
          child: GridView.builder(
            itemCount: 9,
            shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                mainAxisExtent: 200


              ),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Image.asset(categoriesImages[index],height: 120,width: 200,fit: BoxFit.cover,),
                    10.heightBox,
                    categoriesList[index].text.color(darkFontGrey).align(TextAlign.center).make()
                  ],
                ).box.white.rounded.clip(Clip.antiAlias).outerShadowSm.make().onTap(() {

                  controller.getSubCategories(categoriesList[index]);
                  Get.to(()=> CategoryDetails(title: categoriesList[index]));
                });
              },
          ),
        ),
      ),
    );
  }
}
