import 'package:app_shoes_ec/components/components.dart';
import 'package:app_shoes_ec/data/data.dart';
import 'package:app_shoes_ec/widgets/widgets.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final double screenWidth = MediaQuery.of(context).size.width;

    int crossAxisCount;
    if (screenWidth > 1000) {
      crossAxisCount = 5;
    } else if (screenWidth > 800) {
      crossAxisCount = 4;
    } else if (screenWidth > 600) {
      crossAxisCount = 3;
    } else if (screenWidth > 350) {
      crossAxisCount = 2;
    } else {
      crossAxisCount = 1;
    }

    return Scaffold(
      // backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const RecipeDetailAppBar(),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(10.r),
                child: GridView.builder(
                  addAutomaticKeepAlives: true,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 10.h,
                    mainAxisSpacing: 10.h,
                  ),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return item(
                      data[index].name,
                      data[index].path,
                      data[index].price,
                      data[index].sale,
                      data[index].isFavorite,
                      data[index].isOrdered,
                      data[index].quantityColor,
                      data[index].quantitySize,
                      data[index].quantitySold,
                      data[index].star,
                      data[index].images,
                    );
                  },
                ),
              ),
            ),
          ],
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

          double imageHeight = itemHeight * 0.5;
          double iconSize =
              itemHeight > itemWidth ? itemWidth * 0.1 : itemHeight * 0.1;
          double fontSize =
              itemHeight > itemWidth ? itemWidth * 0.095 : itemHeight * 0.095;

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (e) => DetailProduct(
                    name: name,
                    path: path,
                    price: price,
                    sale: sale,
                    isFavorite: isFavorite,
                    isOrdered: isOrdered,
                    quantityColor: quantityColor,
                    quantitySize: quantitySize,
                    quantitySold: quantitySold,
                    star: star,
                    images: images,
                  ),
                ),
              );
            },
            child: Container(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        DottedBorder(
                          color: const Color.fromARGB(255, 200, 79, 79),
                          strokeWidth: 2.h,
                          dashPattern: [10.h, 10.h],
                          strokeCap: StrokeCap.round,
                          borderType: BorderType.RRect,
                          radius: Radius.circular(10.r),
                          child: SizedBox(
                            height: imageHeight,
                            width: double.infinity,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.asset(path, fit: BoxFit.cover)),
                          ),
                        ),
                        Positioned(
                          top: 5.h,
                          left: 5,
                          child: Icon(
                            isFavorite ? IconlyBold.heart : IconlyBroken.heart,
                            size: 25.h,
                            color: Colors.red.shade400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
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
