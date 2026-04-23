import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:radar_clima/core/constants/app_colors.dart';
import 'package:radar_clima/features/weather/presentation/screens/widgets/aurora_halo.dart';
import 'package:radar_clima/features/weather/presentation/screens/widgets/weather_display.dart';
import '../../providers/weather_notifier.dart';

class WeatherHomeScreen extends ConsumerStatefulWidget {
  const WeatherHomeScreen({super.key});

  @override
  ConsumerState<WeatherHomeScreen> createState() => _WeatherHomeScreenState();
}

class _WeatherHomeScreenState extends ConsumerState<WeatherHomeScreen> {
  // late final TextEditingController _cityEC;
  final _cityEC = TextEditingController();

  @override
  void initState() {
    super.initState();
    // _cityEC = TextEditingController();
  }

  @override
  void dispose() {
    _cityEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final weatherState = ref.watch(weatherProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: const Text(
            'Radar Clima',
            style: TextStyle(
              color: AppColors.white90,
              fontWeight: FontWeight.w300,
              letterSpacing: 1.4,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          // --- Aurora: halo azul elétrico no canto superior esquerdo ---
          Positioned(
            top: -100,
            left: -80,
            child: AuroraHalo(
              size: 380,
              color: AppColors.auroraBlue,
              alpha: 55,
            ),
          ),
          // --- Aurora: halo violeta no centro-direita ---
          Positioned(
            top: 200,
            right: -90,
            child: AuroraHalo(
              size: 300,
              color: AppColors.auroraViolet,
              alpha: 45,
            ),
          ),
          // --- Aurora: halo azul suave na base ---
          Positioned(
            bottom: 40,
            left: 20,
            child: AuroraHalo(size: 220, color: AppColors.accent, alpha: 28),
          ),
          // --- Conteúdo ---
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  // Campo de busca
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white10,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: AppColors.white20),
                    ),
                    child: TextField(
                      controller: _cityEC,
                      style: const TextStyle(color: AppColors.white90),
                      cursorColor: AppColors.accent,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 18,
                        ),
                        labelText: 'Digite uma cidade',
                        labelStyle: const TextStyle(color: AppColors.white60),
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.search,
                            color: AppColors.accent,
                          ),
                          onPressed: () {
                            final city = _cityEC.text.trim();

                            if (city.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: AppColors.snackbarBg,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: const BorderSide(
                                      color: AppColors.white20,
                                    ),
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  content: const Text(
                                    'Digite o nome de uma cidade antes de buscar.',
                                    style: TextStyle(color: AppColors.white90),
                                  ),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                              return;
                            }
                            ref
                                .read(weatherProvider.notifier)
                                .searchWeather(city);
                            FocusScope.of(context).unfocus();
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  weatherState.when(
                    data: (weather) => Expanded(
                      child: SingleChildScrollView(
                        child: WeatherDisplay(weather: weather),
                      ),
                    ),
                    error: (err, stack) => Padding(
                      padding: const EdgeInsets.only(top: 48),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.error_outline,
                            color: AppColors.errorRed,
                            size: 60,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Ops! $err',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppColors.white60,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    loading: () => const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.accent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
