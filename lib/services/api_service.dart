import 'package:dio/dio.dart'; // Importing Dio for making HTTP requests

class ApiService {
  final Dio dio = Dio(BaseOptions(
      baseUrl: 'https://reqres.in/api/')); // Initializing Dio with the base URL

  // Method to fetch a list of users from the API, based on the page number
  Future<List<dynamic>> fetchUsers(int page) async {
    // Making a GET request to fetch users from the 'users' endpoint with pagination
    final response = await dio.get('users?page=$page');
    // Returning the 'data' from the response which contains the user information
    return response.data['data'];
  }

  // Method to add a new user to the API
  Future<Map<String, dynamic>> addUser(Map<String, String> userData) async {
    // Making a POST request to the 'users' endpoint to create a new user
    final response = await dio.post('users', data: userData);
    // Returning the response data (newly created user details)
    return response.data;
  }

  // Method to update an existing user by ID
  Future<Map<String, dynamic>> updateUser(
      int id, Map<String, String> userData) async {
    // Making a PUT request to the 'users/{id}' endpoint to update the user information
    final response = await dio.put('users/$id', data: userData);
    // Returning the updated user data from the response
    return response.data;
  }

  // Method to delete a user by ID
  Future<void> deleteUser(int id) async {
    // Making a DELETE request to the 'users/{id}' endpoint to delete the user
    await dio.delete('users/$id');
  }
}
