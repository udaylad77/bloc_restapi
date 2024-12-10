part of 'user_bloc.dart'; // This is the part file that belongs to the 'user_bloc.dart' file

// Abstract class UserEvent extends Equatable to ensure the event can be compared in the bloc
abstract class UserEvent extends Equatable {
  @override
  List<Object?> get props =>
      []; // Equatable allows comparison between different events (no props for base class)
}

// Event to fetch the list of users
class FetchUsersEvent extends UserEvent {}

// Event to add a new user
class AddUserEvent extends UserEvent {
  final String name; // User's name
  final String job; // User's job

  // Constructor to initialize the user details
  AddUserEvent({required this.name, required this.job});

  @override
  List<Object?> get props =>
      [name, job]; // The props for equatable comparison: name and job
}

// Event to edit an existing user's details
class EditUserEvent extends UserEvent {
  final int id; // User's ID to identify which user to edit
  final String name; // New name for the user
  final String job; // New job for the user

  // Constructor to initialize the user details
  EditUserEvent({required this.id, required this.name, required this.job});

  @override
  List<Object?> get props =>
      [id, name, job]; // The props for equatable comparison: id, name, and job
}

// Event to delete a user
class DeleteUserEvent extends UserEvent {
  final int id; // User's ID to identify which user to delete

  // Constructor to initialize the user ID for deletion
  DeleteUserEvent({required this.id});

  @override
  List<Object?> get props =>
      [id]; // The props for equatable comparison: user id
}
