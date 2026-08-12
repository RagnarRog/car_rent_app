import 'package:car_rent_app/blocs/car_info_bloc/car_info_bloc.dart';
import 'package:car_rent_app/blocs/car_info_bloc/car_info_event.dart';
import 'package:car_rent_app/blocs/car_info_bloc/car_info_state.dart';
import 'package:car_rent_app/blocs/sing_in_bloc/sign_in_bloc.dart';
import 'package:car_rent_app/blocs/sing_in_bloc/sign_in_event.dart';
import 'package:car_rent_app/screens/home/add_car.dart';
import 'package:car_rent_app/screens/home/details_screen.dart';
import 'package:car_rent_app/widgets/car_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// FIX 2: Converted to StatefulWidget
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Fire the stream listener ONLY ONCE when the screen is first created
    final String? uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      context.read<CarBloc>().add(LoadCarsEvent(uid));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 7, 77, 10),
        foregroundColor: Colors.white,
        title: const Text('Hello User'),
        leading: IconButton(
          onPressed: () {
            context.read<SignInBloc>().add(const SignOutRequired());
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_sharp),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AddCarScreen()),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final sliderHeight = (constraints.maxWidth * 0.58).clamp(
                  190.0,
                  228.0,
                );

                return DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      SizedBox(
                        height: sliderHeight,
                        child: const TabBarView(
                          physics: BouncingScrollPhysics(),
                          children: [
                            CarCard(
                              title: 'Mercedes\nS-Class',
                              bgColor: Color(0xFF91F086),
                              imageAsset: 'assets/mercedes_main.png',
                            ),
                            CarCard(
                              title: 'Tesla\nModel S',
                              bgColor: Color(0xFF111716),
                              foregroundColor: Colors.white,
                              imageAsset: 'assets/tesla_main.png',
                              imageAlignment: Alignment.bottomCenter,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      const TabPageSelector(
                        indicatorSize: 8,
                        color: Colors.black12,
                        selectedColor: Color.fromARGB(255, 7, 77, 10),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 18),

          Expanded(
            child: BlocConsumer<CarBloc, CarState>(
              listener: (context, state) {
                if (state is CarError) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              builder: (context, state) {
                int carCount = 0;
                if (state is CarLoaded) {
                  carCount = state.cars.length;
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        "New Cars ($carCount)",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(child: _buildListContent(state)),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListContent(CarState state) {
    if (state is CarLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is CarLoaded) {
      if (state.cars.isEmpty) {
        return const Center(child: Text("No cars available at the moment."));
      }

      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        itemCount: state.cars.length,
        itemBuilder: (context, index) {
          final car = state.cars[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(car: car),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.1),
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    child: Image.network(
                      car.imageUrl,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 200,
                        color: Colors.grey[200],
                        child: const Icon(Icons.directions_car, size: 50),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              car.modelName,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: const [
                                Text(
                                  "5.00",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                SizedBox(width: 4),
                                Icon(Icons.star, color: Colors.green, size: 20),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${car.price}\$/Day",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF32D74B),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                "see details",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return const Center(child: Text("Start adding cars to see them here!"));
  }
}
