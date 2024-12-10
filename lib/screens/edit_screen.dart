import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/user_bloc.dart'; // Import the UserBloc to dispatch events related to user actions
import '../models/user_model.dart'; // Import the UserModel to display user information

class EditScreen extends StatelessWidget {
  final UserModel user; // Receive the user to be edited

  // Constructor receives the UserModel instance to populate the fields
  const EditScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    // Create controllers for the name and job text fields, initializing with the current user's data
    final nameController = TextEditingController(text: user.firstName);
    final jobController = TextEditingController(
        text: user.email); // Placeholder for job, can be updated

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit User'), // Set the title of the app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(
            16.0), // Add padding around the body of the screen
        child: Column(
          children: [
            // TextField for editing the name
            TextField(
              controller:
                  nameController, // Use the nameController to control this field
              decoration: const InputDecoration(
                  labelText: 'Name'), // Set the label of the field
            ),
            const SizedBox(height: 16), // Add some space between the fields
            // TextField for editing the job (placeholder text used here)
            TextField(
              controller:
                  jobController, // Use the jobController to control this field
              decoration: const InputDecoration(
                  labelText: 'Job'), // Set the label of the field
            ),
            const SizedBox(height: 32), // Add space before the button
            // Button to save the changes
            ElevatedButton(
              onPressed: () {
                // Get the trimmed text from the text fields
                final name = nameController.text.trim();
                final job = jobController.text.trim();

                // Check if any of the fields are empty
                if (name.isEmpty || job.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill in all fields.')),
                  );
                  return; // Exit if fields are empty
                }

                // Dispatch the EditUserEvent with the updated name and job to update the user
                context
                    .read<UserBloc>() // Access the UserBloc in the context
                    .add(EditUserEvent(
                        id: user.id,
                        name: name,
                        job: job)); // Add the event to the bloc
                Navigator.pop(
                    context); // Close the screen and go back to the previous one
                print(
                    '🐢 Update user event dispatched'); // Log the event dispatch
              },
              child: const Text('Save Changes'), // Set the text for the button
            ),
          ],
        ),
      ),
    );
  }
}
