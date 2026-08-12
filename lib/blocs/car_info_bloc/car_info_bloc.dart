import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:car_rent_app/blocs/car_info_bloc/car_info_event.dart';
import 'package:car_rent_app/blocs/car_info_bloc/car_info_state.dart';
import 'package:car_rent_app/blocs/models/car.dart';
import 'package:car_rent_app/car_repository/car_repository.dart';

class CarBloc extends Bloc<CarEvent, CarState> {
  final CarRepository repository;
  StreamSubscription? _subscription;

  CarBloc(this.repository) : super(CarInitial()) {
    // 1. Loading Cars (Real-time Stream)
    on<LoadCarsEvent>((event, emit) {
      emit(CarLoading());
      _subscription?.cancel();

      // Pass the userId from the event to the repository
      _subscription = repository
          .getCars(event.userId)
          .listen(
            (cars) => add(UpdateCarListEvent(cars)),
            onError: (error) => add(CarErrorEvent(error.toString())),
          );
    });

    // 2. Updating the UI when Stream sends new data
    on<UpdateCarListEvent>((event, emit) {
      emit(CarLoaded(event.cars));
    });

    // 3. Handling Errors
    on<CarErrorEvent>((event, emit) {
      emit(CarError(event.errorMessage));
    });

    // 4. Adding a New Car
    on<AddCarEvent>((event, emit) async {
      try {
        final newCar = Car(
          id: '', // Firestore generates this, so we pass empty
          modelName: event.modelName,
          imageUrl: event.imageUrl,
          price: event.price,
          phone: event.phone,
          info: event.info,
          fuelType: event.fuelType,
          userId: event.userId,
        );

        await repository.addCar(newCar);
        // No need to emit success here, the Stream in LoadCarsEvent
        // will automatically pick up the new car and refresh the UI.
      } catch (e) {
        emit(CarError("Failed to add car: $e"));
      }
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
