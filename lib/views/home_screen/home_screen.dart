import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dawaam_foods/consts/consts.dart';
import 'package:dawaam_foods/consts/lists.dart';
import 'package:dawaam_foods/controllers/home_controller.dart';
import 'package:dawaam_foods/controllers/product_controller.dart';
import 'package:dawaam_foods/services/firestore_services.dart';
import 'package:dawaam_foods/views/category_screen/item_details.dart';
import 'package:dawaam_foods/views/home_screen/components/featured_button.dart';
import 'package:dawaam_foods/views/home_screen/search_screen.dart';
import 'package:dawaam_foods/widgets_common/home_button.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    var controller1 = Get.put(ProductController());

    return Container(
      padding: const EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
          child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 60,
            color: lightGrey,
            child: TextFormField(
              controller: controller.searchController,
              decoration: InputDecoration(
                border: InputBorder.none,
                suffixIcon: const Icon(Icons.search).onTap(
                  () {
                    if (controller.searchController.text.isNotEmptyAndNotNull) {
                      Get.to(
                        () => SearchScreen(
                          title: controller.searchController.text,
                        ),
                      );
                    }
                  },
                ),
                filled: true,
                fillColor: whiteColor,
                hintText: searchanything,
                hintStyle: const TextStyle(color: textfieldGrey),
              ),
              onFieldSubmitted: (value) {
                if (controller.searchController.text.isNotEmptyAndNotNull) {
                  Get.to(
                    () => SearchScreen(
                      title: controller.searchController.text,
                    ),
                  );
                }
              },
            ).box.outerShadow.make(),
          ),
          10.heightBox,
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  //swipper brands
                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: slidersList.length,
                      itemBuilder: ((context, index) {
                        return Image.asset(
                          slidersList[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      })),
                  10.heightBox,
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: List.generate(
                  //       2,
                  //       (index) => homeButtons(
                  //             height: context.screenHeight * 0.15,
                  //             width: context.screenWidth / 2.5,
                  //             icon: index == 0 ? icTodaysDeal : icFlashDeal,
                  //             title: index == 0 ? todayDeal : flashSale,
                  //           )),
                  // ),

                  //featured categories
                  20.heightBox,

                  Align(
                      alignment: Alignment.centerLeft,
                      child: featuredCategories.text
                          .color(darkFontGrey)
                          .size(18)
                          .fontFamily(semibold)
                          .make()),
                  20.heightBox,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: List.generate(
                          3,
                          (index) => Column(
                                children: [
                                  featuredButton(
                                      icon: featuredImages1[index],
                                      title: featuredTitles1[index]),
                                  10.heightBox,
                                  featuredButton(
                                      icon: featuredImages2[index],
                                      title: featuredTitles2[index]),
                                ],
                              )).toList(),
                    ),
                  ),

                  //2nd Swipper
                  10.heightBox,
                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      reverse: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: secondSlidersList.length,
                      itemBuilder: ((context, index) {
                        return Image.asset(
                          secondSlidersList[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      })),

                  //featured products

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
                        featuredProduct.text.white
                            .fontFamily(bold)
                            .size(18)
                            .make(),
                        10.heightBox,
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: FutureBuilder(
                              future: FirestoreServices.getFeaturedProducts(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation(redColor)),
                                  );
                                } else if (snapshot.data!.docs.isEmpty) {
                                  return "No featured products"
                                      .text
                                      .white
                                      .makeCentered();
                                } else {
                                  var featuredData = snapshot.data!.docs;
                                  return Row(
                                    children: List.generate(
                                      featuredData.length,
                                      (index) => Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.network(
                                            featuredData[index]['p_imgs'][0],
                                            width: 130,
                                            height: 130,
                                            fit: BoxFit.cover,
                                          ),
                                          10.heightBox,
                                          "${featuredData[index]['p_name']}"
                                              .text
                                              .fontFamily(semibold)
                                              .maxFontSize(14)
                                              .minFontSize(14)
                                              .maxLines(2)
                                              .ellipsis
                                              .color(darkFontGrey)
                                              .make(),
                                          5.heightBox,
                                          "${featuredData[index]['p_price']}"
                                              .numCurrencyWithLocale(
                                                  locale: 'ur_PK')
                                              .eliminateLast
                                              .eliminateLast
                                              .eliminateLast
                                              .text
                                              .color(redColor)
                                              .fontFamily(bold)
                                              .size(16)
                                              .make()
                                        ],
                                      )
                                          .box
                                          .white
                                          .height(220)
                                          .margin(const EdgeInsets.symmetric(
                                              horizontal: 6))
                                          .width(130)
                                          .roundedSM
                                          .padding(const EdgeInsets.all(8))
                                          .make()
                                          .onTap(() {
                                        Get.to(() => ItemDetails(
                                              title:
                                                  "${featuredData[index]['p_name']}",
                                              data: featuredData[index],
                                            ));
                                      }),
                                    ),
                                  );
                                }
                              }),
                        ),
                      ],
                    ),
                  ),

                  // 10.heightBox,
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: List.generate(
                  //       3,
                  //       (index) => homeButtons(
                  //             height: context.screenHeight * 0.15,
                  //             width: context.screenWidth / 3.5,
                  //             icon: index == 0
                  //                 ? icTopCategories
                  //                 : index == 1
                  //                     ? icBrands
                  //                     : icTopSeller,
                  //             title: index == 0
                  //                 ? topCategories
                  //                 : index == 1
                  //                     ? brand
                  //                     : topSeller,
                  //           )),
                  // ),

                  //all products section
                  20.heightBox,
                  StreamBuilder(
                      stream: FirestoreServices.allProducts(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(redColor),
                          );
                        } else {
                          var allproductsdata = snapshot.data!.docs;
                          return GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: allproductsdata.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 8,
                                      crossAxisSpacing: 8,
                                      mainAxisExtent: 250),
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      allproductsdata[index]['p_imgs'][0],
                                      height: 150,
                                      width: 200,
                                      fit: BoxFit.fill,
                                    ),
                                    const Spacer(),
                                    "${allproductsdata[index]['p_name']}"
                                        .text
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .maxFontSize(14)
                                        .minFontSize(14)
                                        .maxLines(2)
                                        .ellipsis
                                        .make(),
                                    10.heightBox,
                                    "${allproductsdata[index]['p_price']}"
                                        .numCurrencyWithLocale(locale: 'ur_PK')
                                        .eliminateLast
                                        .eliminateLast
                                        .eliminateLast
                                        .text
                                        .color(redColor)
                                        .fontFamily(bold)
                                        .size(16)
                                        .make(),
                                  ],
                                )
                                    .box
                                    .white
                                    .margin(const EdgeInsets.symmetric(
                                        horizontal: 6))
                                    .roundedSM
                                    .padding(const EdgeInsets.all(12))
                                    .make()
                                    .onTap(() {
                                  Get.to(() => ItemDetails(
                                        title:
                                            "${allproductsdata[index]['p_name']}",
                                        data: allproductsdata[index],
                                      ));
                                });
                              });
                        }
                      })
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
