import 'package:app_shoes_ec/components/components.dart';
import 'package:app_shoes_ec/screens/screens.dart';
import 'package:app_shoes_ec/styles/style.dart';
import 'package:app_shoes_ec/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';

class DetailProduct extends StatefulWidget {
  final String name;
  final String path;
  final String price;
  final String sale;
  final bool isFavorite;
  final bool isOrdered;
  final int quantityColor;
  final int quantitySize;
  final int quantitySold;
  final double star;
  final List<String> images;

  const DetailProduct({
    super.key,
    required this.name,
    required this.path,
    required this.price,
    required this.sale,
    required this.isFavorite,
    required this.isOrdered,
    required this.images,
    required this.quantityColor,
    required this.quantitySize,
    required this.quantitySold,
    required this.star,
  });

  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _showPhotoGallery() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImagesProduct(
          images: widget.images,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              topBar(),
              SizedBox(
                height: 10.h,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    imageField(widthScreen),
                    detail(),
                  ],
                ),
              ),
              bottomBar(widthScreen),
            ],
          ),
        ),
      ),
    );
  }

  Widget imageField(double widthScreen) => Container(
        padding:
            EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h, bottom: 10.h),
        height: 400.h,
        decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiary,
          // color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
                            color: Theme.of(context).colorScheme.shadow,

              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(3, 5),
            ),
          ],
        ),
        width: double.infinity,
        child: Column(
          children: [
            image(),
            SizedBox(height: 10.h),
            numberofImage(widthScreen),
          ],
        ),
      );

  Widget image() => Expanded(
        child: GestureDetector(
          onTap: () => _showPhotoGallery(),
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (BuildContext context, int index) {
              return Image.asset(
                widget.images[index],
                fit: BoxFit.contain,
              );
            },
            itemCount: widget.images.length,
          ),
        ),
      );

  Widget numberofImage(double widthScreen) => Align(
        alignment: Alignment.bottomRight,
        child: Container(
          height: 30.h,
          width: widthScreen * 0.2,
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.red,
              ),
              borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: Text(
              '${_currentPage + 1} / ${widget.images.length}',
            ),
          ),
        ),
      );

  Widget detail() => Container(
        padding: EdgeInsets.only(top: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10.w),
                Text('Đã bán: ${widget.quantitySold}'),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'đ${ConvertMoney.formatMoney(widget.price, widget.sale)}',
                        style: TextStyle(
                          fontSize: 26.sp,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const WidgetSpan(
                        child: SizedBox(width: 8),
                      ),
                      TextSpan(
                        text: 'đ${widget.price}',
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                          decorationThickness: 2.0,
                        ),
                      ),
                      const WidgetSpan(
                        child: SizedBox(width: 8),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: Colors.red,
                    ),
                  ),
                  height: 40.h,
                  width: 40.w,
                  child: Center(
                    child: Text(
                      '-${widget.sale}%',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                SizedBox(
                    height: 30.h,
                    child: Icon(
                      widget.isFavorite ? IconlyBold.heart : IconlyBroken.heart,
                      size: 25.h,
                      color: Colors.red.shade400,
                    )),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      'Số màu: ',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      widget.quantityColor.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      IconlyBroken.star,
                      size: 24,
                      color: Colors.yellow.shade700,
                    ),
                    Text(
                      ': ${widget.star}',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.red.shade400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );

  Widget topBar() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              IconlyBroken.arrow_left_square,
              size: 30.h,
              color: Colors.red.shade400,
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Cart()),
                  );
                },
                child: SizedBox(
                  height: 30.h,
                  child: Icon(
                    IconlyBroken.buy,
                    size: 30.h,
                    color: Colors.red.shade400,
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Icon(
                IconlyBroken.search,
                size: 30.h,
                color: Colors.red.shade400,
              ),
            ],
          ),
        ],
      );

  Widget bottomBar(double widthScreen) => Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.red,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                height: 60.h,
                width: widthScreen * 0.4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      IconlyBroken.plus,
                      size: 24.h,
                      color: Colors.red.shade400,
                    ),
                    const Text('Thêm vào giỏ hàng'),
                  ],
                ),
              ),
              Container(
                height: 60.h,
                width: widthScreen * 0.4,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: const Center(
                  child: Text(
                    'Mua ngay',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
