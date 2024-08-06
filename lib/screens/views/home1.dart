import 'package:app_shoes_ec/api/api.dart';
import 'package:app_shoes_ec/models/models.dart';
import 'package:app_shoes_ec/widgets/widgets.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';

class Home1 extends StatefulWidget {
  const Home1({super.key});

  @override
  State<Home1> createState() => _Home1State();
}

class _Home1State extends State<Home1> with AutomaticKeepAliveClientMixin {
  final ProductService productService = ProductService();
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
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const RecipeDetailAppBar(),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(10.r),
                child: StreamBuilder<List<ProductModel>>(
                  stream: productService.getProducts(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No products available'));
                    } else {
                      final products = snapshot.data!;
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 10.h,
                          mainAxisSpacing: 10.h,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return item(product);
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget item(ProductModel product) => LayoutBuilder(
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
              // Handle tap event here
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
                              child: Image.network(
                                product.images.isNotEmpty
                                    ? product.images.first
                                    : 'https://via.placeholder.com/150',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        // Positioned(
                        //   top: 5.h,
                        //   left: 5,
                        //   child: Icon(
                        //     isFavorite ? IconlyBold.heart : IconlyBroken.heart,
                        //     size: 25.h,
                        //     color: Colors.red.shade400,
                        //   ),
                        // ),
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
                            product.name,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: fontSize,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(
                            'đ: ${product.price}',
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
                                    ': ${product.sale}%',
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
                                    ': ${product.vote}',
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
