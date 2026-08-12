import 'package:car_rent_app/blocs/models/car.dart';

abstract class CarEvent {}

// Triggered when the app starts to fetch data
class LoadCarsEvent extends CarEvent {
  final String userId;
  LoadCarsEvent(this.userId);
}

// Triggered automatically when Firestore data changes
class UpdateCarListEvent extends CarEvent {
  final List<Car> cars;
  UpdateCarListEvent(this.cars);
}

// Triggered when an error occurs during the stream
class CarErrorEvent extends CarEvent {
  final String errorMessage;
  CarErrorEvent(this.errorMessage);
}

// Triggered when adding a new car from the UI

// THIS IS WHAT IS MISSING:
class AddCarEvent extends CarEvent {
  final String modelName;
  final String imageUrl;
  final String price;
  final int phone;
  final String info;
  final String fuelType;
  final String userId;

  AddCarEvent({
    required this.modelName,
    required this.imageUrl,
    required this.price,
    required this.phone,
    required this.info,
    required this.fuelType,
    required this.userId,
  });
}
