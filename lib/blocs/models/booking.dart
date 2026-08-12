class Bookings {
  final String userId;
  final String carId;
  final String carName;
  final String totalAmount;
  final DateTime? startDate;
  final DateTime? endDate;

  Bookings({
    required this.userId,
    required this.carId,
    required this.carName,
    required this.totalAmount,
    this.startDate,
    this.endDate,
  });
}
