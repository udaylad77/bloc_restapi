import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/user_bloc.dart';  // Import the UserBloc to dispatch events related to user actions

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Create controllers for the name and job text fields to capture user input
    final nameController = TextEditingController();
    final jobController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add User'),  // Set the title of the app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),  // Add padding around the body of the screen
        child: Column(
          children: [
            // TextField for entering the name
            TextField(
              controller: nameController,  // Use the nameController to control this field
              decoration: const InputDecoration(labelText: 'Name'),  // Set the label of the field
            ),
            const SizedBox(height: 16),  // Add some space between the fields
            // TextField for entering the job
            TextField(
              controller: jobController,  // Use the jobController to control this field
              decoration: const InputDecoration(labelText: 'Job'),  // Set the label of the field
            ),
            const SizedBox(height: 32),  // Add space before the button
            // Button to add the user
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
                  return;  // Exit if fields are empty
                }

                // Dispatch the AddUserEvent with the entered name and job to add a new user
                context
                    .read<UserBloc>()  // Access the UserBloc in the context
                    .add(AddUserEvent(name: name, job: job));  // Add the event to the bloc
                Navigator.pop(context);  // Close the screen and go back to the previous one
                print('🐢Add user event dispatched');  // Log the event dispatch
              },
              child: const Text('Add User'),  // Set the text for the button
            ),
          ],
        ),
      ),
    );
  }
}
