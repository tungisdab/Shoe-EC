import 'package:equatable/equatable.dart';

class MyUserEntity extends Equatable {
  final String userId;
  final String name;
  final String email;
  final String phone;

  const MyUserEntity({
    required this.userId,
    required this.name,
    required this.email,
    required this.phone
  });

  Map<String, Object?>  toDocument() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'phone': phone,
    };
  }

  static MyUserEntity fromDocument(Map<String, dynamic> doc) {
    return MyUserEntity(
      userId: doc['userId'],
      name: doc['name'],
      email: doc['email'],
      phone: doc['phone']
    );
  }


  @override
  List<Object?> get props => [userId, name, email, phone];
  
}

