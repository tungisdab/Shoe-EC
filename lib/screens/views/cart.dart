import 'package:app_shoes_ec/data/data.dart';
import 'package:app_shoes_ec/models/models.dart';
import 'package:app_shoes_ec/styles/style.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<Product> isOrderedProduct = [];

  @override
  void initState() {
    isOrderedProduct = data.where((product) => product.isOrdered).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.bgColor,
      body: SafeArea(
        child: GridView.builder(
          addAutomaticKeepAlives: true,
          // shrinkWrap: true,
          // physics: const NeverScrollableScrollPhysics(),
          physics: const ScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 2,
            crossAxisSpacing: 10.h,
            mainAxisSpacing: 10.h,
          ),
          itemCount: isOrderedProduct.length,
          itemBuilder: (context, index) {
            return item(
              isOrderedProduct[index].name,
              isOrderedProduct[index].path,
              isOrderedProduct[index].price,
              isOrderedProduct[index].sale,
              isOrderedProduct[index].isFavorite,
              isOrderedProduct[index].isOrdered,
              isOrderedProduct[index].quantityColor,
              isOrderedProduct[index].quantitySize,
              isOrderedProduct[index].quantitySold,
              isOrderedProduct[index].star,
              isOrderedProduct[index].images,
            );
          },
        ),
      ),
    );
  }

  Widget item(
          String name,
          String path,
          String price,
          String sale,
          bool isFavorite,
          bool isOrdered,
          int quantityColor,
          int quantitySize,
          int quantitySold,
          double star,
          List<String> images) =>
      LayoutBuilder(
        builder: (context, constraints) {
          double itemWidth = constraints.maxWidth;
          double itemHeight = constraints.maxHeight;

          double imageHeight = itemHeight;
          double imageWidth = itemWidth * 0.35;
          double iconSize =
              itemHeight > itemWidth ? itemWidth * 0.1 : itemHeight * 0.1;
          double fontSize =
              itemHeight > itemWidth ? itemWidth * 0.05 : itemHeight * 0.05;

          return GestureDetector(
            // onTap: () {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (e) => DetailProduct(
            //         name: name,
            //         path: path,
            //         price: price,
            //         sale: sale,
            //         isFavorite: isFavorite,
            //         isOrdered: isOrdered,
            //         quantityColor: quantityColor,
            //         quantitySize: quantitySize,
            //         quantitySold: quantitySold,
            //         star: star,
            //         images: images,
            //       ),
            //     ),
            //   );
            // },
            child: Container(
              margin: EdgeInsets.only(left: 10.r, right: 10.r, top: 10.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(3, 5),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        DottedBorder(
                          color: Colors.red.shade300,
                          strokeWidth: 2.h,
                          dashPattern: [10.h, 10.h],
                          strokeCap: StrokeCap.round,
                          borderType: BorderType.RRect,
                          radius: Radius.circular(10.r),
                          child: SizedBox(
                            height: imageHeight,
                            width: imageWidth,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.asset(path, fit: BoxFit.cover)),
                          ),
                        ),
                        Positioned(
                          top: 5.h,
                          left: 5,
                          // child: SizedBox(
                          //   height: iconSize * 2,
                          //   child: isFavorite
                          //       ? Image.asset(
                          //           "assets/icons/common/lo3.png",
                          //         )
                          //       : Image.asset(
                          //           "assets/icons/common/lo.png",
                          //         ),
                          // ),
                           child: Icon(
                            isFavorite ? IconlyBold.heart : IconlyBroken.heart,
                            size: 25.h,
                            color: Colors.red.shade400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10).w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: fontSize,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(
                            'đ: $price',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: fontSize,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    IconlyBroken.discount,
                                    size: iconSize,
                                    color: Colors.red,
                                  ),
                                  Text(
                                    ': $sale%',
                                    style: TextStyle(
                                      fontSize: fontSize,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    IconlyBroken.star,
                                    size: iconSize,
                                    color: Colors.yellow.shade700,
                                  ),
                                  Text(
                                    ': $star',
                                    style: TextStyle(
                                      fontSize: fontSize,
                                      color: Colors.red.shade400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
}
