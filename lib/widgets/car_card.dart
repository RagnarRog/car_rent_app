import 'package:flutter/material.dart';

class CarCard extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String imageAsset;
  final Color bgColor;
  final Color foregroundColor;
  final Alignment imageAlignment;

  const CarCard({
    super.key,
    required this.title,
    required this.imageAsset,
    required this.bgColor,
    this.eyebrow = 'NEW COLLECTION',
    this.foregroundColor = Colors.black,
    this.imageAlignment = Alignment.bottomRight,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth;
        final cardHeight = constraints.maxHeight;
        final compact = cardWidth < 340 || cardHeight < 205;

        return Container(
          width: double.infinity,
          height: double.infinity,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [bgColor, Color.lerp(bgColor, Colors.black, 0.14)!],
            ),
            boxShadow: [
              BoxShadow(
                color: bgColor.withValues(alpha: 0.24),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                right: -cardWidth * 0.08,
                top: -cardWidth * 0.2,
                child: Container(
                  width: cardWidth * 0.55,
                  height: cardWidth * 0.55,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: foregroundColor.withValues(alpha: 0.07),
                  ),
                ),
              ),
              Positioned(
                right: compact ? -10 : -6,
                bottom: compact ? -8 : -12,
                width: cardWidth * (compact ? 0.58 : 0.64),
                height: cardHeight * (compact ? 0.62 : 0.7),
                child: Image.asset(
                  imageAsset,
                  fit: BoxFit.contain,
                  alignment: imageAlignment,
                  filterQuality: FilterQuality.high,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(compact ? 17 : 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      eyebrow,
                      style: TextStyle(
                        color: foregroundColor.withValues(alpha: 0.68),
                        fontSize: compact ? 10 : 11,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.35,
                      ),
                    ),
                    const SizedBox(height: 7),
                    SizedBox(
                      width: cardWidth * 0.55,
                      child: Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: foregroundColor,
                          fontSize: compact ? 24 : 29,
                          fontWeight: FontWeight.w900,
                          height: 1.02,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: compact ? 11 : 13,
                        vertical: compact ? 7 : 8,
                      ),
                      decoration: BoxDecoration(
                        color: foregroundColor.withValues(alpha: 0.11),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Explore now',
                            style: TextStyle(
                              color: foregroundColor,
                              fontSize: compact ? 11 : 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: foregroundColor,
                            size: compact ? 15 : 16,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
