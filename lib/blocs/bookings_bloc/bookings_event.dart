part of 'bookings_bloc.dart';

abstract class BookingEvent {}

class AddBookingsEvent extends BookingEvent {
  final String totalAmount;
  final DateTime? startDate;
  final DateTime? endDate;
  final String userId; // New: The ID of the logged-in user
  final String carId; // New: The ID of the car being rented
  final String
  carModel; // New: Useful for showing "You booked a [Model Name]" in history

  AddBookingsEvent({
    required this.totalAmount,
    required this.startDate,
    required this.endDate,
    required this.userId,
    required this.carId,
    required this.carModel,
  });
}
