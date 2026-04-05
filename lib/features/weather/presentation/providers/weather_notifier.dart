import 'package:radar_clima/features/weather/data/repositories/weather_repository_provider.dart';
import 'package:radar_clima/features/weather/domain/models/weather_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weather_notifier.g.dart';

@riverpod
class WeatherNotifier extends _$WeatherNotifier {
  // O método build define o estado inicial do Provider.
  // Vamos começar buscando uma cidade padrão (ex: São Paulo).
  @override
  FutureOr<WeatherModel> build() async {
    return _fetchWeather('São Paulo');
  }

  // Método privado para buscar os dados no repositório
  Future<WeatherModel> _fetchWeather(String cityName) async {
    // Pegamos o repositório através do ref
    final repository = ref.read(weatherRepositoryProvider);
    return await repository.fetchWeather(cityName);
  }

  // Método público que a UI vai chamar quando o usuário pesquisar
  Future<void> searchWeather(String cityName) async {
    // 1. Colocamos o estado em "loading" manualmente para a UI reagir
    state = const AsyncLoading();

    // 2. Tentamos buscar os novos dados
    state = await AsyncValue.guard(() => _fetchWeather(cityName));

    // O AsyncValue.guard é um "açúcar sintático" que:
    // - Se der certo, coloca o resultado em AsyncData
    // - Se der erro, captura a exception e coloca em AsyncError automaticamente
  }
}
