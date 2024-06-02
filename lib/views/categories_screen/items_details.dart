
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/list.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:flutter/material.dart';

class ItemsDetails extends StatelessWidget {
  final String? title;
  final dynamic data;
  const ItemsDetails({super.key,required this.title, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
        title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
        actions: [
          IconButton(onPressed: (){

          }, icon: const Icon(Icons.share)),
          IconButton(onPressed: (){

          }, icon: const Icon(Icons.favorite_outline)),
        ],
      ),
      body: Column(
        children: [
           Expanded(child: Padding(
            padding: const EdgeInsets.all(8),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Swiper section
                  VxSwiper.builder(
                    autoPlay: true,
                      height: 350,
                      aspectRatio: 16/9,
                      viewportFraction: 1.0,
                      itemCount: data["p_imgs"].length,
                      itemBuilder:(context, index) {
                        return Image.network(data["p_imgs"][index],width: double.infinity,fit: BoxFit.cover,);
                      },),
                  10.heightBox,
                  //title and details section
                  title!.text.size(16).color(darkFontGrey).fontFamily(semibold).make(),
                  10.heightBox,
                  // Rating
                  VxRating(onRatingUpdate: (value) {

                  },normalColor: textfieldGrey,selectionColor: golden,count: 5,size: 25,stepInt: true),

                  10.heightBox,
                  "\$30,000".text.color(redColor).fontFamily(bold).size(18).make(),

                  10.heightBox,
                   Row(
                     
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Seller".text.white.fontFamily(semibold).make(),
                            5.heightBox,
                            "In House Bands".text.color(darkFontGrey).fontFamily(semibold).size(16).make(),
                          ],
                        ),
                      ),
                      const CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.message_rounded,color: darkFontGrey,),
                      ),
                    ],
                  ).box.height(60).padding(const EdgeInsets.symmetric(horizontal: 16)).color(textfieldGrey).make(),


                  // Colors Section
                  20.heightBox,
                  Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: "Color".text.color(textfieldGrey).make(),
                          ),
                          
                          Row(
                            children: List.generate(3, (index) => VxBox().size(40, 40).color(Vx.randomPrimaryColor)
                                .margin(const EdgeInsets.symmetric(horizontal: 4)).roundedFull.make()),
                          ),
                        ],
                      ).box.padding(const EdgeInsets.all(8)).make(),


                      // Quality Row
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: "Quantity".text.color(textfieldGrey).make(),
                          ),

                          Row(
                            children: [
                              IconButton(onPressed: (){}, icon: const Icon(Icons.remove)),
                              "0".text.color(darkFontGrey).fontFamily(bold).size(16).make(),
                              IconButton(onPressed: (){}, icon: const Icon(Icons.add)),
                              10.widthBox,
                              "(0 available)".text.color(textfieldGrey).make()
                            ],
                          ),
                        ],
                      ).box.padding(const EdgeInsets.all(8)).make(),


                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: "Total: ".text.color(textfieldGrey).make(),
                          ),

                          "\$ 0.00".text.size(16).color(redColor).make()
                        ],
                      ).box.padding(const EdgeInsets.all(8)).make(),
                    ],
                  ).box.white.shadowSm.make(),




                  // Description section
                  10.heightBox,

                  "Description".text.color(darkFontGrey).fontFamily(semibold).make(),
                  10.heightBox,
                  "This is dummy item and dummy description here...".text.color(darkFontGrey).make(),

                  // Button Section
                  10.heightBox,
                  ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: List.generate(itemsDetailsButtonList.length, (index) => ListTile(
                      title: itemsDetailsButtonList[index].text.fontFamily(semibold).color(darkFontGrey).make(),
                      trailing: const Icon(Icons.arrow_forward),

                    )),


                  ),
                  // Product may also you like
                  10.heightBox,
                  productYouMayLike.text.fontFamily(bold).color(darkFontGrey).size(16).make(),
                  10.heightBox,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(

                      children: List.generate(6, (index) =>
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(imgP1,width: 150,fit: BoxFit.cover,),
                              10.heightBox,
                              "Laptop 4GB/64GB".text.fontFamily(semibold).color(darkFontGrey).make(),
                              10.heightBox,
                              "\$600".text.color(redColor).fontFamily(bold).size(16).make()
                            ],

                          ).box.white.margin(const EdgeInsets.symmetric(horizontal: 4)).roundedSM.padding(const EdgeInsets.all(8)).make(),
                      ),
                    ),
                  ),


                ],
              ),
            ),


          )),

          SizedBox(
            width: double.infinity,
            height: 60,
            child: ourButton(
              Color: redColor,
            onPress: (){},
            textColor: whiteColor,
            title: "Add to Cart"
          ),),
        ],
      ),
    );
  }
}
