import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/user_model.dart';
import '../repositories/user_repository.dart';

part 'user_event.dart'; // Importing the user event part
part 'user_state.dart'; // Importing the user state part

// The UserBloc handles different events and states related to users
class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository =
      UserRepository(); // Instance of UserRepository to interact with the backend

  // Constructor to initialize the bloc and define which event to handle
  UserBloc() : super(UserInitial()) {
    // Handling different user-related events
    on<FetchUsersEvent>(_onFetchUsers); // Fetch users
    on<AddUserEvent>(_onAddUser); // Add a user
    on<EditUserEvent>(_onEditUser); // Edit a user
    on<DeleteUserEvent>(_onDeleteUser); // Delete a user
  }

  // Handling the FetchUsersEvent
  Future<void> _onFetchUsers(
      FetchUsersEvent event, Emitter<UserState> emit) async {
    emit(UserLoading()); // Emit loading state while fetching users
    try {
      final users = await userRepository
          .fetchUsers(); // Fetch the users from the repository
      emit(
          UserLoaded(users: users)); // Emit loaded state with the list of users
    } catch (e) {
      emit(UserError(
          message:
              'Failed to load users.')); // Emit error state if fetching fails
    }
  }

  // Handling the AddUserEvent
  Future<void> _onAddUser(AddUserEvent event, Emitter<UserState> emit) async {
    try {
      await userRepository.addUser(
          event.name, event.job); // Add user using repository
      add(FetchUsersEvent()); // Fetch the updated list of users
    } catch (e) {
      emit(UserError(
          message: 'Failed to add user.')); // Emit error state if adding fails
    }
  }

  // Handling the EditUserEvent
  Future<void> _onEditUser(EditUserEvent event, Emitter<UserState> emit) async {
    try {
      await userRepository.editUser(
          event.id, event.name, event.job); // Edit user using repository
      add(FetchUsersEvent()); // Refetch the users after editing
    } catch (e) {
      emit(UserError(
          message: e.toString())); // Emit error state with the error message
    }
  }

  // Handling the DeleteUserEvent
  Future<void> _onDeleteUser(
      DeleteUserEvent event, Emitter<UserState> emit) async {
    try {
      await userRepository.deleteUser(event.id); // Delete user using repository
      add(FetchUsersEvent()); // Refetch users after deleting
    } catch (e) {
      emit(UserError(
          message: e.toString())); // Emit error state with the error message
    }
  }
}
