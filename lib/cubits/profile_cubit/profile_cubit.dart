import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../../models/user_profile.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  // Define the constant box name for consistency
  static const String _boxName = 'userProfileBox';
  static const String _profileKey = 'current_user';

  ProfileCubit() : super(ProfileInitial());

  /// Fetches user profile from Hive local box storage
  Future<void> loadProfile() async {
    emit(ProfileLoading());
    try {
      final box = await Hive.openBox<UserProfile>(_boxName);
      final profile = box.get(_profileKey);

      if (profile != null) {
        emit(ProfileLoaded(profile));
      } else {
        // Fallback or default structure if no local profile exists yet
        final defaultProfile = UserProfile(
          name: "John Doe",
          email: "example@domain.com",
          phoneNumber: "+123456789",
          bio: "Software Engineer & Tech Enthusiast",
        );
        emit(ProfileLoaded(defaultProfile));
      }
    } catch (e) {
      emit(ProfileError("Failed to load profile data: ${e.toString()}"));
    }
  }

  /// Saves or updates the user profile details locally
  Future<void> updateProfile(UserProfile updatedProfile) async {
    try {
      final box = await Hive.openBox<UserProfile>(_boxName);
      await box.put(_profileKey, updatedProfile);

      // Update the state immediately so UI renders new changes
      emit(ProfileLoaded(updatedProfile));
    } catch (e) {
      emit(ProfileError("Failed to save changes. Please try again."));
    }
  }
}
