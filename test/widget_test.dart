import 'package:car_rent_app/widgets/car_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  for (final size in <Size>[const Size(320, 190), const Size(430, 228)]) {
    testWidgets('promotional car card fits at ${size.width.toInt()}px', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: size.width,
                height: size.height,
                child: const CarCard(
                  title: 'Mercedes\nS-Class',
                  imageAsset: 'assets/mercedes_main.png',
                  bgColor: Color(0xFF91F086),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(CarCard), findsOneWidget);
      expect(find.text('Mercedes\nS-Class'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }
}
