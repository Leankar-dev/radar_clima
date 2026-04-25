

lib/
├── core/
│   ├── env/
│   │   ├── env.dart                          # Variáveis de ambiente via Envied (obfuscated)
│   │   └── env.g.dart                        # gerado
│   ├── network/
│   │   ├── dio_client.dart                   # Configuração central do Dio (@riverpod)
│   │   ├── dio_client.g.dart                 # gerado
│   │   ├── api_interceptors.dart             # Logs e tratamento de erros de rede
│   │   └── connectivity_service.dart         # Verifica conectividade (connectivity_plus)
│   ├── constants/
│   │   ├── api_constants.dart                # Base URL e endpoints
│   │   └── app_colors.dart                   # Paleta de cores do app
│   └── errors/
│       └── failure.dart                      # Tipos de falha (ServerFailure, NetworkFailure)
├── features/
│   └── weather/
│       ├── data/
│       │   ├── dto/
│       │   │   ├── weather_dto.dart          # Model que reflete o JSON da API
│       │   │   ├── weather_dto.freezed.dart  # gerado
│       │   │   └── weather_dto.g.dart        # gerado
│       │   └── repositories/
│       │       ├── weather_repository.dart             # Interface (Abstract class)
│       │       ├── weather_repository_impl.dart        # Implementação concreta
│       │       ├── weather_repository_provider.dart    # Provider @riverpod do repositório
│       │       └── weather_repository_provider.g.dart  # gerado
│       ├── domain/
│       │   ├── models/
│       │   │   ├── weather_model.dart                  # Entidade limpa para a UI
│       │   │   └── weather_model.freezed.dart          # gerado
│       │   └── usecases/
│       │       ├── fetch_weather_use_case.dart          # Orquestra a busca por cidade
│       │       ├── fetch_weather_use_case_provider.dart # Provider @riverpod do use case
│       │       └── fetch_weather_use_case_provider.g.dart # gerado
│       └── presentation/
│           ├── providers/
│           │   ├── weather_notifier.dart                # ViewModel (AsyncNotifier)
│           │   └── weather_notifier.g.dart              # gerado
│           └── screens/
│               ├── home/
│               │   └── weather_home_screen.dart         # Tela principal com busca e estado
│               └── widgets/
│                   ├── aurora_halo.dart                 # Efeito de halo aurora boreal
│                   ├── current_weather_card.dart        # Card glass-morphism com clima atual
│                   └── weather_display.dart             # Exibição de temperatura e ícone
├── shared/
│   └── widgets/
│       └── loading_overlay.dart                         # Widget de loading reaproveitável
├── app.dart                                             # Configuração do MaterialApp
└── main.dart                                            # Entrada (ProviderScope + runApp)