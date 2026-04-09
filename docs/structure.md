

lib/
├── core/
│   ├── network/
│   │   ├── dio_client.dart       # Configuração central do Dio
│   │   └── api_interceptors.dart # Erros e logs de rede
│   ├── constants/
│   │   ├── api_constants.dart    # Base URL e API Keys
│   │   └── app_colors.dart       # Estilização de cores
│   └── errors/
│       └── failure.dart          # Classe para mapear erros (Server, Network)
├── features/
│   └── weather/
│       ├── data/
│       │   ├── dto/
│       │   │   └── weather_dto.dart        # Model que reflete o JSON da API
│       │   └── repositories/
│       │       ├── weather_repository.dart  # Interface (Abstract class)
│       │       └── weather_repository_impl.dart
│       ├── domain/
│       │   └── models/
│       │       └── weather_model.dart      # Entidade limpa para a UI
│       ├── presentation/
│       │   ├── providers/
│       │   │   └── weather_notifier.dart    # Sua ViewModel (AsyncNotifier)
│       │   ├── screens/
│       │   │   └── weather_home_screen.dart
│       │   └── widgets/
│       │       ├── current_weather_card.dart
│       │       └── forecast_list_widget.dart
├── shared/
│   └── widgets/
│       └── loading_overlay.dart  # Widget de loading reaproveitável
├── app.dart                      # Configuração do MaterialApp
└── main.dart                     # Entrada (ProviderScope + runApp)