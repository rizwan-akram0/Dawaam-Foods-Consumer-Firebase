import 'package:dawaam_foods/consts/consts.dart';
import 'package:dawaam_foods/consts/lists.dart';
import 'package:dawaam_foods/controllers/product_controller.dart';
import 'package:dawaam_foods/views/chat_screen/chat_screen.dart';
import 'package:dawaam_foods/widgets_common/our_button.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  final dynamic data;
  const ItemDetails({super.key, this.title, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return WillPopScope(
      onWillPop: () async {
        controller.resetValues(int.parse(data['p_price']));
        return true;
      },
      child: Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                controller.resetValues(int.parse(data['p_price']));
                Get.back();
              },
              icon: const Icon(Icons.arrow_back),
            ),
            title: title!.text
                .maxLines(1)
                .ellipsis
                .minFontSize(18)
                .maxFontSize(18)
                .color(darkFontGrey)
                .fontFamily(bold)
                .make(),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.share,
                  )),
              Obx(
                () => IconButton(
                    onPressed: () {
                      if (controller.isFav.value) {
                        controller.removeFromWhishlist(data.id, context);
                      } else {
                        controller.addToWhishlist(data.id, context);
                      }
                    },
                    icon: Icon(
                      controller.isFav.value == false
                          ? Icons.favorite_outline
                          : Icons.favorite_outlined,
                      color: controller.isFav.value ? redColor : darkFontGrey,
                    )),
              ),
            ]),
        body: Column(
          children: [
            Expanded(
                child: Container(
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //swiper section

                      VxSwiper.builder(
                          autoPlay: true,
                          height: 350,
                          aspectRatio: 16 / 9,
                          itemCount: data['p_imgs'].length,
                          viewportFraction: 1.0,
                          itemBuilder: (context, index) {
                            return Image.network(
                              data["p_imgs"][index],
                              width: double.infinity,
                              fit: BoxFit.cover,
                            );
                          }).box.shadowXs.make(),
                      10.heightBox,

                      //title and details section
                      title!.text
                          .size(16)
                          .color(darkFontGrey)
                          .fontFamily(semibold)
                          .make(),

                      10.heightBox,
                      //rating
                      VxRating(
                        isSelectable: false,
                        value: double.parse(data['p_rating']),
                        onRatingUpdate: (value) {},
                        normalColor: textfieldGrey,
                        selectionColor: golden,
                        count: 5,
                        maxRating: 5,
                        size: 25,
                      ),

                      10.heightBox,
                      "${data["p_price"]}"
                          .numCurrencyWithLocale(locale: "ur_PK")
                          .text
                          .color(redColor)
                          .fontFamily(bold)
                          .size(18)
                          .make(),

                      10.heightBox,

                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "Chat with"
                                    .text
                                    .white
                                    .fontFamily(semibold)
                                    .make(),
                                5.heightBox,
                                "Seller"
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .size(18)
                                    .make(),
                              ],
                            ),
                          ),
                          const CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.message_rounded,
                              color: darkFontGrey,
                            ),
                          ).onTap(() {
                            Get.to(
                              () => const ChatScreen(),
                              arguments: [data['p_seller'], data['vendor_id']],
                            );
                          })
                        ],
                      )
                          .box
                          .rounded
                          .shadowXs
                          .height(60)
                          .padding(const EdgeInsets.symmetric(horizontal: 16))
                          .color(textfieldGrey)
                          .make(),

                      //color section
                      20.heightBox,
                      Obx(
                        () => Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Size: ".text.color(fontGrey).make(),
                                ),
                                Row(
                                  children: List.generate(
                                      data['p_colors'].length,
                                      (index) => Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              VxBox(
                                                      child: "20 G"
                                                          .text
                                                          .makeCentered())
                                                  .size(40, 40)
                                                  .rounded
                                                  // .color(Color(data['p_colors']
                                                  //         [index])
                                                  .color((redColor)
                                                      .withOpacity(1.0))
                                                  .margin(const EdgeInsets
                                                      .symmetric(horizontal: 4))
                                                  .make()
                                                  .onTap(() {
                                                controller
                                                    .changeColorIndex(index);
                                              }),
                                              Visibility(
                                                  visible: index ==
                                                      controller
                                                          .colorIndex.value,
                                                  child: const Icon(Icons.done,
                                                      color: Colors.white))
                                            ],
                                          )),
                                )
                              ],
                            ).box.padding(const EdgeInsets.all(8)).make(),

                            //quantity row
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child:
                                      "Quantity: ".text.color(fontGrey).make(),
                                ),
                                Obx(
                                  () => Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            controller.decreaseQuantity();
                                            controller.calculateTotalPrice(
                                                int.parse(data['p_price']));
                                          },
                                          icon: const Icon(Icons.remove)),
                                      controller.quantity.value.text
                                          .size(1)
                                          .color(darkFontGrey)
                                          .fontFamily(bold)
                                          .make(),
                                      IconButton(
                                          onPressed: () {
                                            controller.increaseQuantity(
                                                int.parse(data['p_quantity']));
                                            controller.calculateTotalPrice(
                                                int.parse(data['p_price']));
                                          },
                                          icon: const Icon(Icons.add)),
                                      10.widthBox,
                                      "(${data['p_quantity']} available)"
                                          .text
                                          .color(textfieldGrey)
                                          .make(),
                                    ],
                                  ),
                                ),
                              ],
                            ).box.padding(const EdgeInsets.all(8)).make(),

                            //total row
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Total: ".text.color(fontGrey).make(),
                                ),
                                "${controller.totalPrice.value}"
                                    .numCurrencyWithLocale(locale: "ur_PK")
                                    .text
                                    .color(redColor)
                                    .size(16)
                                    .fontFamily(bold)
                                    .make(),
                              ],
                            ).box.padding(const EdgeInsets.all(8)).make(),
                          ],
                        ).box.white.rounded.shadowSm.make(),
                      ),

                      //description section

                      10.heightBox,
                      "Description"
                          .text
                          .color(darkFontGrey)
                          .fontFamily(semibold)
                          .make(),
                      10.heightBox,

                      Container(
                        child:
                            "${data['p_desc']}".text.color(darkFontGrey).make(),
                      )
                          .box
                          .white
                          .roundedSM
                          .padding(const EdgeInsets.all(5))
                          .shadowSm
                          .make(),

                      30.heightBox,

                      // //buttons section
                      // 10.heightBox,
                      // ListView(
                      //   physics: const NeverScrollableScrollPhysics(),
                      //   shrinkWrap: true,
                      //   children: List.generate(
                      //     itemDetailsButonList.length,
                      //     (index) => ListTile(
                      //       title: itemDetailsButonList[index]
                      //           .text
                      //           .fontFamily(semibold)
                      //           .color(darkFontGrey)
                      //           .make(),
                      //       trailing: const Icon(Icons.arrow_forward),
                      //     ),
                      //   ),
                      // ),
                      // //products you may like
                      // 20.heightBox,
                      // productsyoumaylike.text
                      //     .fontFamily(bold)
                      //     .size(16)
                      //     .color(darkFontGrey)
                      //     .make(),

                      // 10.heightBox,

                      // //copied this widget from home screen featured products
                      // SingleChildScrollView(
                      //   scrollDirection: Axis.horizontal,
                      //   physics: const BouncingScrollPhysics(),
                      //   child: Row(
                      //     children: List.generate(
                      //         6,
                      //         (index) => Column(
                      //               crossAxisAlignment: CrossAxisAlignment.start,
                      //               children: [
                      //                 Image.asset(
                      //                   imgP1,
                      //                   width: 150,
                      //                   fit: BoxFit.cover,
                      //                 ),
                      //                 10.heightBox,
                      //                 "Laptop 4GB/64GB"
                      //                     .text
                      //                     .fontFamily(semibold)
                      //                     .color(darkFontGrey)
                      //                     .make(),
                      //                 10.heightBox,
                      //                 "\$600"
                      //                     .text
                      //                     .color(redColor)
                      //                     .fontFamily(bold)
                      //                     .size(16)
                      //                     .make(),
                      //               ],
                      //             )
                      //                 .box
                      //                 .white
                      //                 .margin(
                      //                     const EdgeInsets.symmetric(horizontal: 6))
                      //                 .roundedSM
                      //                 .padding(const EdgeInsets.all(8))
                      //                 .make()),
                      //   ),
                      // ),
                    ],
                  )),
            )),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ourButton(
                  color: redColor,
                  onPress: () {
                    if (controller.quantity.value > 0) {
                      controller.addToCart(
                          color: data['p_colors'][controller.colorIndex.value],
                          context: context,
                          vendorID: data['vendor_id'],
                          img: data['p_imgs'][0],
                          qty: controller.quantity.value,
                          sellername: data['p_seller'],
                          title: data['p_name'],
                          tprice: controller.totalPrice.value);
                      VxToast.show(context, msg: "Added to cart");
                    } else {
                      VxToast.show(context, msg: "Quantity can't be 0");
                    }
                  },
                  title: "Add to cart"),
            )
          ],
        ),
      ),
    );
  }
}
