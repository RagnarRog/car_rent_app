import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:car_rent_app/blocs/sing_in_bloc/sign_in_bloc.dart';
import 'package:car_rent_app/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:car_rent_app/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:car_rent_app/screens/auth/sign_in_screen.dart';
import 'package:car_rent_app/screens/auth/sign_up_screen.dart';
import 'package:user_repository/user_repository.dart' show FirebaseUserRepo;

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(initialIndex: 0, length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: size.height * 0.4,
            child: Container(
              color: theme.colorScheme.primary,
              child: Stack(
                children: [
                  Positioned(
                    bottom: 20,
                    right: -20,
                    child: Image.asset(
                      "assets/mercedes_main.png",
                      width: size.width * 0.7,
                      fit: BoxFit.cover,
                    ),
                  ),

                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 24, top: 20),
                      child: SizedBox(
                        width: size.width * 0.5,
                        child: const Text(
                          "Rent your dream car in Georgia",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            height: 1.1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 70),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: size.height * 0.65,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: TabBar(
                      dividerColor: Colors.transparent,
                      controller: tabController,
                      labelColor: theme.colorScheme.primary,
                      unselectedLabelColor: const Color.fromARGB(
                        255,
                        116,
                        116,
                        116,
                      ),
                      labelStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      unselectedLabelStyle: const TextStyle(fontSize: 16),
                      indicatorColor: Colors.grey,

                      tabs: const [
                        Tab(text: "Sign In"),
                        Tab(text: "Sign Up"),
                      ],
                    ),
                  ),

                  // Tab Views
                  // Tab Views
                  // Tab Views
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        // 1. SIGN IN BLOC (Needs Positional + Named)
                        BlocProvider<SignInBloc>(
                          create: (context) {
                            final repo = context
                                .read<AuthenticationBloc>()
                                .userRepository;
                            return SignInBloc(
                              repo as FirebaseUserRepo, // Positional
                              userRepository: repo, // Named
                            );
                          },
                          child: const SignInScreen(),
                        ),

                        // 2. SIGN UP BLOC (Needs Named Only)
                        BlocProvider<SignUpBloc>(
                          create: (context) => SignUpBloc(
                            userRepository: context
                                .read<AuthenticationBloc>()
                                .userRepository, // Named only
                          ),
                          child: const SignUpScreen(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
