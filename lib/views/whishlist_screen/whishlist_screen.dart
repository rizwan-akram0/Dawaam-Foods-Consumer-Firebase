import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dawaam_foods/consts/consts.dart';
import 'package:dawaam_foods/services/firestore_services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class WhishlistScreen extends StatelessWidget {
  const WhishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title:
            "My Whishlist".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getWhishlist(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor)),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child:
                  "No items in whishlist yet!".text.color(darkFontGrey).make(),
            );
          } else {
            var data = snapshot.data!.docs;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: Image.network(
                          "${data[index]['p_imgs'][0]}",
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                        title: "${data[index]['p_name']}"
                            .text
                            .fontFamily(semibold)
                            .size(16)
                            .make(),
                        subtitle: "${data[index]['p_price']}"
                            .numCurrencyWithLocale(locale: "ur_PK")
                            .text
                            .size(14)
                            .color(redColor)
                            .fontFamily(semibold)
                            .make(),
                        trailing: const Icon(
                          Icons.favorite,
                          color: redColor,
                        ).onTap(() async {
                          firestore
                              .collection(productsCollection)
                              .doc(data[index].id)
                              .set({
                            'p_whishlist':
                                FieldValue.arrayRemove([currentUser!.uid])
                          }, SetOptions(merge: true));
                        }),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
