import 'package:flutter/material.dart';
import 'package:radar_clima/core/constants/app_colors.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Center(
        child: CircularProgressIndicator(color: AppColors.accent),
      ),
    );
  }
}
