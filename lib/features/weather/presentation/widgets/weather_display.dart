import 'package:flutter/material.dart';
import '../../domain/models/weather_model.dart';

class WeatherDisplay extends StatelessWidget {
  final WeatherModel weather;

  const WeatherDisplay({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          weather.cityName,
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Image.network(
          weather.iconUrl,
          scale: 0.5, // Deixa o ícone um pouco maior
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.wb_sunny_outlined, size: 50),
        ),
        Text(
          '${weather.temperature.round()}°C', // Arredondando para ficar mais limpo
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
            fontWeight: FontWeight.w300,
            color: Colors.blueAccent,
          ),
        ),
        Text(
          weather.description.toUpperCase(),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            letterSpacing: 1.2,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
