import '../../models/user_profile.dart';

abstract class ProfileState {}

// Initial state before any data processing starts
class ProfileInitial extends ProfileState {}

// Emitted while loading data from the local storage
class ProfileLoading extends ProfileState {}

// Emitted when the data is successfully fetched or updated
class ProfileLoaded extends ProfileState {
  final UserProfile profile;
  ProfileLoaded(this.profile);
}

// Emitted if an operation fails
class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}
