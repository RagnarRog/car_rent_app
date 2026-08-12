import 'package:car_rent_app/app.dart';
import 'package:car_rent_app/blocs/bookings_bloc/bookings_bloc.dart';
import 'package:car_rent_app/blocs/car_info_bloc/car_info_bloc.dart';
import 'package:car_rent_app/blocs/sing_in_bloc/sign_in_bloc.dart';
import 'package:car_rent_app/booking_repository/booking_repository.dart';
import 'package:car_rent_app/car_repository/car_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final carRepo = CarRepository();
  final bookingRepo = BookingRepository();
  final userRepo = FirebaseUserRepo();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignInBloc(userRepo, userRepository: userRepo),
        ),
        BlocProvider(create: (context) => CarBloc(carRepo)),
        BlocProvider(create: (context) => BookingsBloc(bookingRepo)),
      ],
      child: MyApp(userRepo),
    ),
  );
}
