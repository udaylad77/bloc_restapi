import 'package:flutter/material.dart'; // Importing material design package for UI components
import 'package:flutter_bloc/flutter_bloc.dart'; // Importing flutter_bloc package for state management using BLoC
import 'blocs/user_bloc.dart'; // Importing UserBloc, which handles the logic for user-related events and states
import 'screens/home_screen.dart'; // Importing the HomeScreen widget to be displayed on the home page

void main() {
  runApp(const MyApp()); // Running the MyApp widget to start the Flutter app
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Constructor for MyApp widget (No state)

  @override
  Widget build(BuildContext context) {
    // Returning the root widget of the app
    return MultiBlocProvider(
      providers: [
        // Providing UserBloc instance to the widget tree
        BlocProvider<UserBloc>(
          create: (context) => UserBloc()
            ..add(FetchUsersEvent()), // Fetching users when the app starts
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // Disabling the debug banner
        title: 'User Management', // Setting the title of the app
        theme: ThemeData(
            primarySwatch: Colors.blue), // Setting the theme color for the app
        home:
            const HomeScreen(), // Setting HomeScreen as the initial screen of the app
      ),
    );
  }
}
