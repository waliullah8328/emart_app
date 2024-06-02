import 'package:emart_app/consts/colors.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/list.dart';
import 'package:emart_app/views/home_screen/components/feature_button.dart';
import 'package:emart_app/widgets_common/home_button.dart';
import 'package:flutter/material.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 60,
            color: lightGrey,
            child: TextFormField(
              
              decoration: const InputDecoration(
                border: InputBorder.none,
                suffixIcon: Icon(Icons.search),
                filled: true,
                fillColor: whiteColor,
                hintText:searchAnything,
                hintStyle: TextStyle(color: textfieldGrey),
              ),
            ),

          ),

          Expanded(
            child: SingleChildScrollView(
             physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  // Swiper bands
                  VxSwiper.builder(
                    aspectRatio: 16/9,
                    autoPlay: true,
                    height: 150,
                    enlargeCenterPage: true,
                    itemCount: sliderList.length,
                    itemBuilder:(context, index) {
                      return Image.asset(sliderList[index],fit: BoxFit.fill,).box.rounded.clip(Clip.antiAlias).margin(EdgeInsets.symmetric(horizontal: 8)).make();
                    },

                  ),
                  10.heightBox,
                  // deals Button

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(2,(index) => homeButton(
                      height: context.screenHeight*0.15,
                      width: context.screenWidth/2.5,
                      icon: index == 0? icTodaysDeal: icFlashDeal,
                      title: index == 0? todayDeal: flashSale,

                    )),
                  ),

                  // Second Swiper
                  10.heightBox,
                  VxSwiper.builder(
                    aspectRatio: 16/9,
                    autoPlay: true,
                    height: 150,
                    enlargeCenterPage: true,
                    itemCount: secondSliderList.length,
                    itemBuilder:(context, index) {
                      return Image.asset(secondSliderList[index],fit: BoxFit.fill,).box.rounded.clip(Clip.antiAlias).margin(EdgeInsets.symmetric(horizontal: 8)).make();
                    },

                  ),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(3, (index) => homeButton(
                        height: context.screenHeight*0.13,
                        width: context.screenWidth/3.5,
                        icon: index == 0? icTopCategories: index== 1? icBrands: icTopSeller,
                        title: index == 0? topCategories: index == 1? brand: topSellers

                    )),
                  ),


                  // Features and Categories
                  20.heightBox,
                  Align(
                      alignment: Alignment.centerLeft,
                      child: featureCategories.text.color(darkFontGrey).size(18).fontFamily(semibold).make()),
                  20.heightBox,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                          3, (index) => Column(
                        children: [
                          featureButton(
                            title: featuredTitles1[index],
                            icon: featuredImages1[index],
                          ),
                          10.heightBox,
                          featureButton(
                            title: featuredTitles2[index],
                            icon: featuredImages2[index],
                          ),

                        ],


                      ),
                      ).toList()
                    ),
                  ),

                  // Featured Product
                  20.heightBox,
                  Container(
                    padding: const EdgeInsets.all(12),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: redColor,
                    ),
                    child: Column(
                      
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        featuredProduct.text.white.fontFamily(bold).size(18).make(),
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
                  // 3rd Swiper
                  10.heightBox,
                  VxSwiper.builder(
                    aspectRatio: 16/9,
                    autoPlay: true,
                    height: 150,
                    enlargeCenterPage: true,
                    itemCount: secondSliderList.length,
                    itemBuilder:(context, index) {
                      return Image.asset(secondSliderList[index],fit: BoxFit.fill,).box.rounded.clip(Clip.antiAlias).margin(EdgeInsets.symmetric(horizontal: 8)).make();
                    },

                  ),

                  // All Product Section
                  20.heightBox,
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 6,
                    shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        mainAxisExtent: 300
                      ),
                      itemBuilder: (context, index) {
                        return  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(imgP5,width: 200,height: 200,fit: BoxFit.cover,),
                            const Spacer(),
                            "Laptop 4GB/64GB".text.fontFamily(semibold).color(darkFontGrey).make(),
                            10.heightBox,
                            "\$600".text.color(redColor).fontFamily(bold).size(16).make()
                          ],

                        ).box.white.margin(const EdgeInsets.symmetric(horizontal: 4)).roundedSM.padding(const EdgeInsets.all(12)).make();
                      },
                  ),

                ],
              ),
            ),
          )



        ],
      )),

    );
  }
}
