import 'package:alessia_masuzzo_progetto_finale/theme/app_colors.dart';
import 'package:flutter/material.dart';

class BlobBackground extends StatelessWidget {
  const BlobBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
       const Positioned.fill(
         child: ColoredBox(color: AppColors.lightBackgroundDefault),
       ),
        Positioned(
          top: -50,
          right: -60,
          child: _Blob(size: 190, color: AppColors.lightBlobPurple),
        ),
        Positioned(
          bottom: -70,
          left: -60,
          child: _Blob(size: 200, color: AppColors.lightBlobGreen),
        ),
        Positioned.fill(child: child),
      ],
    );
  }
}

class _Blob extends StatelessWidget {
  const _Blob({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}