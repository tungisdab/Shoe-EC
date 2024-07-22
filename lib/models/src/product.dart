class Product {
  String name;
  String path;
  String price;
  String sale;
  bool isFavorite = false;
  bool isOrdered = false;
  int quantityColor;
  int quantitySize;
  int quantitySold;
  double star;
  List<String> images = [];

  Product(
      {required this.name,
      required this.path,
      required this.price,
      required this.sale,
      required this.isFavorite,
      required this.isOrdered,
      required this.quantityColor,
      required this.quantitySize,
      required this.quantitySold,
      required this.star,
      required this.images,
      });
}
