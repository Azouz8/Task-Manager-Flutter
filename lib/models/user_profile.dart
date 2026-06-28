import 'package:hive/hive.dart';

// This file name must match the part statement for code generation
part 'user_profile.g.dart';

@HiveType(typeId: 0)
class UserProfile extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String phoneNumber;

  @HiveField(3)
  final String bio;

  UserProfile({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.bio,
  });

  // Helper method to clone objects easily when changing values
  UserProfile copyWith({
    String? name,
    String? email,
    String? phoneNumber,
    String? bio,
  }) {
    return UserProfile(
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      bio: bio ?? this.bio,
    );
  }
}
