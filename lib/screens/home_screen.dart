import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/user_bloc.dart'; // Import the UserBloc to manage user-related events and states
import '../widgets/custom_alert_dialog.dart'; // Import the custom alert dialog for confirmation
import 'add_screen.dart'; // Import the AddScreen to navigate to the add user page
import 'edit_screen.dart'; // Import the EditScreen to navigate to the edit user page

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Management'), // Title of the app bar
      ),
      body: BlocBuilder<UserBloc, UserState>(
        // Listening to changes in the UserBloc
        builder: (context, state) {
          // Check the current state of the UserBloc and render the appropriate UI
          if (state is UserLoading) {
            return const Center(
                child:
                    CircularProgressIndicator()); // Show loading spinner while fetching data
          } else if (state is UserLoaded) {
            // When the users are loaded successfully, show them in a ListView
            return ListView.builder(
              itemCount: state.users
                  .length, // Set the number of items based on the users' list
              itemBuilder: (context, index) {
                final user = state
                    .users[index]; // Get the user data for the current index
                return Card(
                  // Create a card for each user
                  margin: const EdgeInsets.all(8.0), // Set margin for each card
                  child: ListTile(
                    leading: CircleAvatar(
                      // Display the user's avatar as a circular image
                      backgroundImage: NetworkImage(user.avatar),
                    ),
                    title: Text(
                        '${user.firstName} ${user.lastName}'), // Display the user's full name
                    subtitle: Text(
                        user.email), // Display the user's email as subtitle
                    trailing: Row(
                      mainAxisSize: MainAxisSize
                          .min, // Make sure the icons are tightly packed
                      children: [
                        // Edit button to navigate to EditScreen
                        IconButton(
                          icon: const Icon(Icons.edit,
                              color: Colors.blue), // Edit icon
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditScreen(
                                    user: user), // Navigate to EditScreen
                              ),
                            );
                          },
                        ),
                        // Delete button to show a confirmation dialog before deletion
                        IconButton(
                          icon: const Icon(Icons.delete,
                              color: Colors.red), // Delete icon
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => CustomAlertDialog(
                                title:
                                    'Delete User', // Title for the confirmation dialog
                                message:
                                    'Are you sure you want to delete this user?', // Message for confirmation
                                onConfirm: () {
                                  context.read<UserBloc>().add(DeleteUserEvent(
                                      id: user
                                          .id)); // Dispatch the delete user event
                                  Navigator.pop(
                                      context); // Close the dialog after confirmation
                                  print(
                                      '🐢 Delete user event dispatched'); // Log the delete action
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is UserError) {
            return Center(
                child: Text(state
                    .message)); // Show error message if there's an issue loading users
          }
          return const Center(
              child: Text(
                  'No users found.')); // Fallback message if no data is available
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const AddScreen()), // Navigate to AddScreen for adding new user
          );
        },
        child: const Icon(Icons.add), // Icon for the floating action button
      ),
    );
  }
}
