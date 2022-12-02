// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../blocs/home_bloc.dart' as _i8;
import '../constants/ab_test.dart' as _i3;
import '../networking/config.dart' as _i4;
import '../networking/dio_provider.dart' as _i9;
import '../networking/fact_client.dart' as _i6;
import '../repos/simple_repo.dart' as _i7;

const String _dev = 'dev';
const String _prod = 'prod';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final dioProvider = _$DioProvider();
  gh.factory<_i3.ABConstants>(
    () => _i3.ABConstantsDev(),
    registerFor: {_dev},
  );
  gh.factory<_i3.ABConstants>(
    () => _i3.ABConstantsProd(),
    registerFor: {_prod},
  );
  gh.factory<_i4.IConfig>(
    () => _i4.AppConfig(),
    registerFor: {_dev},
  );
  gh.factory<_i4.IConfig>(
    () => _i4.ChuckConfig(),
    registerFor: {_prod},
  );
  gh.singleton<_i5.Dio>(dioProvider.dio(get<_i4.IConfig>()));
  gh.factory<_i6.FactClient>(
    () => _i6.CatFactClient(
      dio: get<_i5.Dio>(),
      config: get<_i4.IConfig>(),
      constants: get<_i3.ABConstants>(),
    ),
    registerFor: {_dev},
  );
  gh.factory<_i6.FactClient>(
    () => _i6.ChuckFactClient(
      dio: get<_i5.Dio>(),
      config: get<_i4.IConfig>(),
      constants: get<_i3.ABConstants>(),
    ),
    registerFor: {_prod},
  );
  gh.factory<_i7.FunFactRepo>(
      () => _i7.CatFacts(factClient: get<_i6.FactClient>()));
  gh.factory<_i8.HomeBloc>(() => _i8.HomeBloc(get<_i7.FunFactRepo>()));
  return get;
}

class _$DioProvider extends _i9.DioProvider {}
