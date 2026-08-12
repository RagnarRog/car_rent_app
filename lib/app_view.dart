import 'package:car_rent_app/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:car_rent_app/screens/get_started_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens/home/home_screen.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Auth',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          surface: Colors.white,
          onSurface: Colors.black,
          primary: Color.fromRGBO(7, 123, 45, 1),
          onPrimary: Colors.white,
          error: Colors.red,
          outline: Color(0xFF424242),
        ),
      ),

      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state.status == AuthenticationStatus.authenticated) {
            return const HomeScreen();
          } else {
            return const GetStartedScreen();
          }
        },
      ),
    );
  }
}
