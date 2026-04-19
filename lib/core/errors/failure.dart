abstract class Failure implements Exception {
  final String message;
  const Failure(this.message);

  @override
  String toString() => message;
}

class NetworkFailure extends Failure {
  const NetworkFailure()
    : super('Sem conexão com a internet. Verifique seu Wi-Fi ou dados móveis.');
}

class CityNotFoundException extends Failure {
  const CityNotFoundException()
    : super('Cidade não encontrada. Verifique o nome e tente novamente.');
}

class ApiKeyInvalidFailure extends Failure {
  const ApiKeyInvalidFailure()
    : super('Erro de autenticação com a API. Contate o suporte.');
}

class ServerFailure extends Failure {
  const ServerFailure()
    : super('Erro no servidor. Tente novamente mais tarde.');
}
