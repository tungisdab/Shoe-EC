import 'package:cloud_firestore/cloud_firestore.dart';

class MyUserEntity {
  final String userId;
  final String name;
  final String imageUrl;
  final String email;
  final String phone;
  final String address;
  final List<String> cartProducts;
  final List<String> favoriteProducts;

  MyUserEntity({
    required this.userId,
    required this.name,
    required this.imageUrl,
    required this.email,
    required this.phone,
    required this.address,
    required this.cartProducts,
    required this.favoriteProducts,
  });

  Map<String, Object?> toJson() {
    return {
      'userId': userId,
      'name': name,
      'imageUrl': imageUrl,
      'email': email,
      'phone': phone,
      'address': address,
      'cartProducts': cartProducts,
      'favoriteProducts': favoriteProducts,
    };
  }

  static MyUserEntity fromJson(Map<String, Object?> json) {
    return MyUserEntity(
      userId: json['userId'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String,
      cartProducts: List<String>.from(json['cartProducts'] as List),
      favoriteProducts: List<String>.from(json['favoriteProducts'] as List),
    );
  }

  Map<String, Object?> toDocument() {
    return {
      'userId': userId,
      'name': name,
      'imageUrl': imageUrl,
      'email': email,
      'phone': phone,
      'address': address,
      'cartProducts': cartProducts,
      'favoriteProducts': favoriteProducts,
    };
  }

  static MyUserEntity fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, Object?>;
    return MyUserEntity(
      userId: data['userId'] as String,
      name: data['name'] as String,
      imageUrl: data['imageUrl'] as String,
      email: data['email'] as String,
      phone: data['phone'] as String,
      address: data['address'] as String,
      cartProducts: List<String>.from(data['cartProducts'] as List),
      favoriteProducts: List<String>.from(data['favoriteProducts'] as List),
    );
  }
}
