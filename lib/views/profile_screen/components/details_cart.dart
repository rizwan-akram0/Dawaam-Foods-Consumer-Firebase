import 'package:dawaam_foods/consts/consts.dart';

Widget detailsCard({width, String? count, String? title}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.fontFamily(bold).color(darkFontGrey).make(),
      5.heightBox,
      title!.text.color(darkFontGrey).size(14).make(),
    ],
  )
      .box
      .white
      .rounded
      .width(width)
      .padding(const EdgeInsets.all(4))
      .height(80)
      .make();
}
