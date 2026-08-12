import 'package:car_rent_app/blocs/models/booking.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addBooking(Bookings booking) async {
    await _firestore.collection("bookings").add({
      "userId": booking.userId,
      "carId": booking.carId,
      "carName": booking.carName,
      "total_amount": booking.totalAmount,
      "start_date": booking.startDate,
      "end_date": booking.endDate,
      "bookedAt": FieldValue.serverTimestamp(),
    });
  }
}
