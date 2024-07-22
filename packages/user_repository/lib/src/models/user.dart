import 'package:equatable/equatable.dart';
import 'package:user_repository/src/entities/user_entity.dart';

class MyUser extends Equatable {
  final String userId;
  final String name;
  final String email;
  final String phone;

  const MyUser({
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
  });

  static const empty = MyUser(userId: '', name: '', email: '', phone: '');

  MyUser copyWith(
      {String? userId, String? name, String? email, String? phone}) {
    return MyUser(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }

  MyUserEntity toEntity() {
    return MyUserEntity(userId: userId, name: name, email: email, phone: phone);
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
        userId: entity.userId,
        name: entity.name,
        email: entity.email,
        phone: entity.phone);
  }

  @override
  List<Object?> get props => [userId, name, email, phone];
}
