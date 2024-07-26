import 'package:equatable/equatable.dart';

class MyUserEntity extends Equatable {
  final String userId;
  final String name;
  final String imageUrl;
  final String email;
  final String phone;
  final String address;

  const MyUserEntity({
    required this.userId,
    required this.name,
    required this.imageUrl,
    required this.email,
    required this.phone,
    required this.address
  });

  Map<String, Object?>  toDocument() {
    return {
      'userId': userId,
      'name': name,
      'imageUrl': imageUrl,
      'email': email,
      'phone': phone,
      'address': address
    };
  }

  static MyUserEntity fromDocument(Map<String, dynamic> doc) {
    return MyUserEntity(
      userId: doc['userId'],
      name: doc['name'],
      imageUrl: doc['imageUrl'],
      email: doc['email'],
      phone: doc['phone'],
      address: doc['address'],
    );
  }


  @override
  List<Object?> get props => [userId, name, imageUrl,email, phone, address];
  
}

