import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImagesProduct extends StatefulWidget {
  final List<String> images;

  const ImagesProduct({
    super.key,
    required this.images,
  });

  @override
  ImagesProductState createState() => ImagesProductState();
}

class ImagesProductState extends State<ImagesProduct> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: SizedBox(
                  height: 40.h,
                  child: Image.asset('assets/icons/common/previous1.png'),
                ),
              ),
              Expanded(
                child: PhotoViewGallery.builder(
                  itemCount: widget.images.length,
                  pageController: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  builder: (context, index) {
                    return PhotoViewGalleryPageOptions(
                      imageProvider: AssetImage(widget.images[index]),
                      minScale: PhotoViewComputedScale.contained * 0.8,
                      maxScale: PhotoViewComputedScale.covered * 2,
                      heroAttributes: PhotoViewHeroAttributes(tag: widget.images[index]),
                    );
                  },
                  scrollPhysics: const BouncingScrollPhysics(),
                  backgroundDecoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    widget.images.length,
                    (index) => buildDot(index),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDot(int index) {
    return Container(
      height: 8.h,
      width: 8.h,
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index ? Colors.red : Colors.grey,
      ),
    );
  }
}
