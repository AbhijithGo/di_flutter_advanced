import 'package:dependency_injection/constants/ab_test.dart';
import 'package:dependency_injection/networking/config.dart';
import 'package:dependency_injection/networking/models/fact.dart';
import 'package:dependency_injection/networking/rest_client.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract class FactClient {
  Future<Fact> randomFact();
}

@Injectable(as: FactClient)
@Environment('dev')
class CatFactClient extends FactClient {
  final Dio dio;
  final IConfig config;
  final RestClient client;

  final ABConstants constants;

  @override
  Future<Fact> randomFact() {
    constants.printVariant();
    return client
        .randomFact(config.path)
        .then((value) => _fromResponse(value.rawResponse));
  }

  Fact _fromResponse(Map<String, dynamic> json) {
    return Fact.fromJson(json);
  }

  CatFactClient({
    required this.dio,
    required this.config,
    required this.constants
  }) : client = RestClient(dio, baseUrl: config.baseUrl);
}

@Environment('prod')
@Injectable(as: FactClient)
class ChuckFactClient extends CatFactClient {
  ChuckFactClient({
    required Dio dio,
    required IConfig config,
    required ABConstants constants
  }) : super(dio: dio, config: config, constants: constants);

  @override
  Fact _fromResponse(Map<String, dynamic> json) {
    String data = "${json['value']}";
    return Fact(data, data.length);
  }
}
