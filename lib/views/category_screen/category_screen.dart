import 'package:dawaam_foods/consts/consts.dart';
import 'package:dawaam_foods/consts/lists.dart';
import 'package:dawaam_foods/controllers/product_controller.dart';
import 'package:dawaam_foods/views/category_screen/category_details.dart';
import 'package:dawaam_foods/widgets_common/bg_widget.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    // var controller = Get.find<ProductController>();

    return bgWidget(
        child: Scaffold(
      appBar: AppBar(
        title: categories.text.white.fontFamily(bold).make(),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: 6,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisExtent: 230,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8),
          itemBuilder: (context, index) {
            return Column(
              children: [
                Image.asset(
                  categoryImage[index],
                  height: 170,
                  width: 200,
                  fit: BoxFit.contain,
                ),
                10.heightBox,
                categoriesList[index]
                    .text
                    .color(darkFontGrey)
                    .align(TextAlign.center)
                    .make(),
              ],
            )
                .box
                .white
                .rounded
                .clip(Clip.antiAlias)
                .outerShadow
                .make()
                .onTap(() {
              controller.getSubCategories(categoriesList[index]);
              Get.to(() => CategoryDetails(
                    title: categoriesList[index],
                  ));
            });
          },
        ),
      ),
    ));
  }
}
