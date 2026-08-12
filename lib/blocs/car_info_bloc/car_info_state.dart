import 'package:car_rent_app/blocs/models/car.dart';

abstract class CarState {}

class CarInitial extends CarState {}

class CarLoading extends CarState {}

class CarUploading extends CarState {
  final double progress;
  CarUploading(this.progress);
}

class CarLoaded extends CarState {
  final List<Car> cars;
  CarLoaded(this.cars);
}

class CarError extends CarState {
  final String message;
  CarError(this.message);
}
