part of 'bookings_bloc.dart';

abstract class BookingState {}

class BookingLoading extends BookingState {}

class BookingInitial extends BookingState {}

class BookingUploading extends BookingState {
  final double progress;
  BookingUploading(this.progress);
}

class BookingLoaded extends BookingState {
  final List<Bookings> booking;
  BookingLoaded(this.booking);
}

class BookingError extends BookingState {
  final String message;
  BookingError(this.message);
}
