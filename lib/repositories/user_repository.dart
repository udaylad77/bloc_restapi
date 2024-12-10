import 'package:dio/dio.dart'; // Importing Dio for making HTTP requests
import '../models/user_model.dart'; // Importing the UserModel for mapping response data

class UserRepository {
  final Dio dio = Dio(); // Initializing Dio instance for making requests

  // Method to fetch users from the API
  Future<List<UserModel>> fetchUsers() async {
    // Making a GET request to fetch users from the 'users' endpoint with pagination
    final response = await dio.get('https://reqres.in/api/users?page=2');

    // Mapping the response data to a list of UserModel instances
    return (response.data['data'] as List)
        .map((user) => UserModel.fromJson(
            user)) // Using UserModel to convert JSON to model
        .toList();
  }

  // Method to add a new user by sending user data (name, job)
  Future<void> addUser(String name, String job) async {
    // Making a POST request to add a new user
    await dio
        .post('https://reqres.in/api/users', data: {'name': name, 'job': job});
  }

  // Method to edit an existing user's details by ID
  Future<void> editUser(int id, String name, String job) async {
    // Making a PUT request to update the user's information by their ID
    await dio.put('https://reqres.in/api/users/$id',
        data: {'name': name, 'job': job});
  }

  // Method to delete a user by ID
  Future<void> deleteUser(int id) async {
    // Making a DELETE request to remove the user by their ID
    await dio.delete('https://reqres.in/api/users/$id');
  }
}
