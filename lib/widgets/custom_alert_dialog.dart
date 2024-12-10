import 'package:flutter/material.dart'; // Importing the material design package for UI components

class CustomAlertDialog extends StatelessWidget {
  final String title; // Title of the alert dialog
  final String message; // Message to be displayed in the dialog
  final VoidCallback
      onConfirm; // Function to be executed when 'Confirm' is pressed

  // Constructor to initialize the dialog with title, message, and onConfirm callback
  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    // Building the AlertDialog widget
    return AlertDialog(
      title: Text(title), // Displaying the title in the dialog
      content: Text(message), // Displaying the message in the dialog
      actions: [
        // 'Cancel' button
        TextButton(
          onPressed: () => Navigator.pop(context), // Close the dialog on press
          child: const Text('Cancel'), // Text for the Cancel button
        ),
        // 'Confirm' button
        TextButton(
          onPressed: onConfirm, // Calling the onConfirm callback when pressed
          child: const Text('Confirm'), // Text for the Confirm button
        ),
      ],
    );
  }
}
