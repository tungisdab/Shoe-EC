import 'package:app_shoes_ec/models/models.dart';
import 'package:app_shoes_ec/screens/screens.dart';
import 'package:app_shoes_ec/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class DetailProduct extends StatelessWidget {
  final ProductModel product;

  const DetailProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              topBar(context),
              SizedBox(height: 10.h),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    imageField(context, widthScreen),
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

  Widget imageField(BuildContext context, double widthScreen) => Container(
    padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h, bottom: 10.h),
    height: 400.h,
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.tertiary,
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
    child: GestureDetector(
      onTap: () => _showPhotoGallery(context),
      child: PageView.builder(
        itemCount: product.images.length,
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            product.images[index],
            fit: BoxFit.contain,
          );
        },
      ),
    ),
  );

  void _showPhotoGallery(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PhotoViewGalleryScreen(images: product.images),
      ),
    );
  }

  Widget numberofImage(double widthScreen) => Align(
    alignment: Alignment.bottomRight,
    child: Container(
      height: 30.h,
      width: widthScreen * 0.2,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.red,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          '1 / ${product.images.length}',
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
              product.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 10.w),
            Text('Đã bán: ${product.quantitySold}'),
          ],
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'đ${ConvertMoney.formatMoney(product.price, product.sale)}',
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
                    text: 'đ${product.price}',
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
                  '-${product.sale}%',
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
            // SizedBox(
            //     height: 30.h,
            //     child: Icon(
            //       product.isFavorite ? IconlyBold.heart : IconlyBroken.heart,
            //       size: 25.h,
            //       color: Colors.red.shade400,
            //     )),
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
                  product.color.length.toString(),
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
                  ': ${product.vote}',
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

  Widget topBar(BuildContext context) => Row(
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

class PhotoViewGalleryScreen extends StatelessWidget {
  final List<String> images;

  const PhotoViewGalleryScreen({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only( top: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(IconlyBroken.arrow_left_square, color: Colors.white, size: 30,),
                  ),
              Expanded(
                
                child: PhotoViewGallery.builder(
                  itemCount: images.length,
                  builder: (context, index) {
                    return PhotoViewGalleryPageOptions(
                      imageProvider: NetworkImage(images[index]),
                      minScale: PhotoViewComputedScale.contained,
                       maxScale: PhotoViewComputedScale.covered,
                    );
                  },
                  scrollPhysics: const BouncingScrollPhysics(),
                  backgroundDecoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  pageController: PageController(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}