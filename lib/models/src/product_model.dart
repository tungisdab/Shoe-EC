import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;
  final String brand;
  final List<String> color;
  final String description;
  final List<String> images;
  final String name;
  final String price;
  final String quantity;
  final String quantitySold;
  final String sale;
  final String vote;

  ProductModel({
    required this.id,
    required this.brand,
    required this.color,
    required this.description,
    required this.images,
    required this.name,
    required this.price,
    required this.quantity,
    required this.quantitySold,
    required this.sale,
    required this.vote,
  });

  factory ProductModel.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return ProductModel(
      id: doc.id,
      brand: data['brand'] ?? '',
      color: List<String>.from(data['color'] ?? []),
      description: data['description'] ?? '',
      images: List<String>.from(data['images'] ?? []),
      name: data['name'] ?? '',
      price: data['price'] ?? '',
      quantity: data['quantity'] ?? '',
      quantitySold: data['quantitysold'] ?? '',
      sale: data['sale'] ?? '',
      vote: data['vote'] ?? '',
    );
  }
}
