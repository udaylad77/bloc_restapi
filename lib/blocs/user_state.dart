part of 'user_bloc.dart'; // This is the part file that belongs to the 'user_bloc.dart' file

// Abstract class UserState extends Equatable to ensure state comparison in the bloc
abstract class UserState extends Equatable {
  @override
  List<Object?> get props =>
      []; // Equatable allows comparison between different states (no props for base class)
}

// Initial state when the user data hasn't been fetched or updated
class UserInitial extends UserState {}

// State when the data is being loaded (e.g., waiting for a response from an API)
class UserLoading extends UserState {}

// State when user data is successfully loaded
class UserLoaded extends UserState {
  final List<UserModel> users; // The list of users to be displayed

  // Constructor to initialize the loaded users list
  UserLoaded({required this.users});

  @override
  List<Object?> get props =>
      [users]; // The props for equatable comparison: the list of users
}

// State when there is an error (e.g., failed API call, no internet)
class UserError extends UserState {
  final String message; // The error message

  // Constructor to initialize the error message
  UserError({required this.message});

  @override
  List<Object?> get props =>
      [message]; // The props for equatable comparison: the error message
}
