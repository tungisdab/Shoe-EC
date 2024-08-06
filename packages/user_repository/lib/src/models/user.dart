import 'package:equatable/equatable.dart';
import 'package:user_repository/src/entities/user_entity.dart';

class MyUser extends Equatable {
  final String userId;
  final String name;
  final String imageUrl;
  final String email;
  final String phone;
  final String address;
  final List<String> cartProducts;
  final List<String> favoriteProducts;

  const MyUser({
    required this.userId,
    required this.name,
    required this.imageUrl,
    required this.email,
    required this.phone,
    required this.address,
    required this.cartProducts,
    required this.favoriteProducts,
  });

  static const empty = MyUser(
      userId: '', name: '', imageUrl: '', email: '', phone: '', address: '', cartProducts: [], favoriteProducts: []);

  MyUser copyWith(
      {String? userId,
      String? name,
      String? imageUrl,
      String? email,
      String? phone,
      String? address,
      List<String>? cartProducts,
      List<String>? favoriteProducts}) {
    return MyUser(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      cartProducts: cartProducts ?? this.cartProducts,
      favoriteProducts: favoriteProducts ?? this.favoriteProducts,
    );
  }

  MyUserEntity toEntity() {
    return MyUserEntity(
        userId: userId,
        name: name,
        imageUrl: imageUrl,
        email: email,
        phone: phone,
        address: address,
        cartProducts: cartProducts,
        favoriteProducts: favoriteProducts);
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
        userId: entity.userId,
        name: entity.name,
        imageUrl: entity.imageUrl,
        email: entity.email,
        phone: entity.phone,
        address: entity.address,
        cartProducts: entity.cartProducts,
        favoriteProducts: entity.favoriteProducts);
  }

  @override
  List<Object?> get props => [userId, name, imageUrl,email, phone, address, cartProducts, favoriteProducts];
}
