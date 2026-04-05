import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:radar_clima/features/weather/presentation/widgets/weather_display.dart';
import '../providers/weather_notifier.dart';

class WeatherHomeScreen extends ConsumerWidget {
  const WeatherHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. "Assistimos" o estado do nosso Notifier.
    // Sempre que o estado mudar (Loading -> Data ou Error), este widget reconstrói.
    final weatherState = ref.watch(weatherProvider);
    final controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Clima com Riverpod 3')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Campo de Busca
            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Digite uma cidade',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    // 2. Usamos ref.read para disparar uma ação (Search)
                    // Não usamos watch aqui porque não queremos reconstruir ao clicar,
                    // apenas chamar a função da ViewModel.
                    ref
                        .read(weatherProvider.notifier)
                        .searchWeather(controller.text);
                    FocusScope.of(context).unfocus(); // Fecha o teclado
                  },
                ),
              ),
            ),
            const SizedBox(height: 32),

            // 3. O Poder do AsyncValue: OBRIGA a tratar os 3 estados
            weatherState.when(
              data: (weather) => Expanded(
                child: SingleChildScrollView(
                  child: WeatherDisplay(weather: weather),
                ),
              ),
              error: (err, stack) => Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Column(
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    const SizedBox(height: 16),
                    Text('Ops! $err', textAlign: TextAlign.center),
                  ],
                ),
              ),
              loading: () => const Expanded(
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
