import 'package:bloc/bloc.dart';
import 'package:car_rent_app/blocs/models/booking.dart';
import "package:car_rent_app/booking_repository/booking_repository.dart";

part 'bookings_event.dart';
part 'bookings_state.dart';

class BookingsBloc extends Bloc<BookingEvent, BookingState> {
  final BookingRepository _bookingRepository;

  // We pass the repository through the constructor (Dependency Injection)
  BookingsBloc(this._bookingRepository) : super(BookingInitial()) {
    on<AddBookingsEvent>((event, emit) async {
      emit(BookingLoading()); // Triggers the loading UI

      try {
        // 1. Create the model with all the 'binding' info
        final newBooking = Bookings(
          totalAmount: event.totalAmount,
          startDate: event.startDate,
          endDate: event.endDate,
          userId: event.userId, // Links to User
          carId: event.carId, // Links to Car
          carName: event.carModel, // Snapshot of car name
        );

        // 2. Save to Firestore via Repository
        await _bookingRepository.addBooking(newBooking);

        // 3. Signal success (You could create a BookingSuccess state here)
        emit(BookingInitial());
      } catch (e) {
        emit(BookingError("Booking failed: ${e.toString()}"));
      }
    });
  }
}
