import 'package:car_rent_app/blocs/models/car.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CarRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addCar(Car car) async {
    await _firestore.collection("cars").add({
      "modelName": car.modelName,
      "imageUrl": car.imageUrl,
      "price": car.price,
      "fuelType": car.fuelType,
      "info": car.info,
      "phone": car.phone,
      "userId": car.userId,
    });
  }

  Stream<List<Car>> getCars(String currentUserId) {
    return _firestore
        .collection("cars")
        .where("userId", isEqualTo: currentUserId)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            final data = doc.data();
            return Car(
              id: doc.id,
              userId: data['userId'] ?? '',
              modelName: data['modelName'] ?? '',
              price: data['price'] ?? '0',
              imageUrl: data['imageUrl'] ?? '',
              phone: data["phone"] ?? 0,
              info: data["info"] ?? '',
              fuelType: data["fuelType"] ?? '',
            );
          }).toList();
        });
  }
}
